//
//  CitiesService.swift
//  BackBaseTask
//
//  Created by Muhamed Shaban on 03/06/2021.
//

import Foundation

/// This protocol is implemented by cities Presenter
/// Interactor to Presenter
protocol CitiesInteractorToPresenterProtocol: class {
    func citiesSearchResults(cities: [City])
    func dataIsReady()
}

class CitiesInteractor {
    
    // MARK: - Properties
    var presenterDelegate: CitiesInteractorToPresenterProtocol?
    var citiesDistributedData: [String: [City]] = [:]
    
    // MARK: - Methodsc
    /// This method used to map json data to array of City models
    /// - Parameter data: json cities data
    /// - Returns: array of Cities Model
    func mapCitiesJsonData(from data: Data?) -> [City] {
        guard let citiesData = data else {return [City]()}
        do {
            let citiesJsonData = try JSONDecoder().decode([City].self, from: citiesData)
            return citiesJsonData
        } catch {
            print("error:\(error)")
        }
        return [City]()
    }
    
    /// This method takes cities models as array then add it to a dictionarry where key is the first char of the city and value is array of cities model that start with same char
    /// So after this method end we will have a dictionary that group all cities base on first char
    /// This will improve the performance so instead of searching in the whole cities array, I'll search on sub arrays based on the first charchter on the word user is searching for
    /// - Parameter cities: all cities models non sorted
    func addCitiesToDataSourceBasedOnFirstChar(cities: [City]) {
        for city in cities {
            let firstChar = String(city.name.prefix(1).lowercased())
            if citiesDistributedData[firstChar] != nil {
                citiesDistributedData[firstChar]?.append(city)
            } else {
                citiesDistributedData[firstChar] = [City]()
                citiesDistributedData[firstChar]?.append(city)
            }
        }
    }
    
    /// This method will loop over all dictionary values of type [City] and Sort it alphabetically
    /// Note: I've implement Comparable protocol by City Model to be able to compare between Cities Models
    func sortCitiesAlphabetically() {
        for (cityFirstCarshKey, _) in citiesDistributedData {
            citiesDistributedData[cityFirstCarshKey] = citiesDistributedData[cityFirstCarshKey]?.sorted { $0 < $1 }
        }
    }
    
    /// This method will read cities.json file and return its content as data
    /// - Returns: cities json data
    func loadCitiesFileData() -> Data? {
        if let url = Bundle.main.url(forResource: "cities", withExtension: "json") {
            do {
                return try Data(contentsOf: url)
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }
    
    /// This Binnary Search Agorithm impelimentation
    /// Time omplexity is O(log n).
    /// Note: used operator overloading to directly be able to compare between City model and user typed string
    /// - Parameters:
    ///   - citiesArray: array that will search in it
    ///   - searchedText: user typed text
    /// - Returns: Filtered array of type City which its prefix match with user typed string
    func binarySearch(in citiesArray: [City], for searchedText: String) -> [City] {
        var leftStartIndex = 0
        var rightEndIndex = citiesArray.count - 1
        var filteredArray = [City]()
        
        while leftStartIndex <= rightEndIndex {
            let middleIndex = (leftStartIndex + rightEndIndex) / 2
            if citiesArray[middleIndex] == searchedText {
                for index in (leftStartIndex..<middleIndex).reversed() {
                    if citiesArray[index].name.lowercased().hasPrefix(searchedText) {
                        filteredArray.insert(citiesArray[index], at: 0)
                    } else {break}
                }
                for index in middleIndex...rightEndIndex {
                    if citiesArray[index].name.lowercased().hasPrefix(searchedText) {
                        filteredArray.append(citiesArray[index])
                    } else {break}
                }
                return filteredArray
            } else if citiesArray[middleIndex] < searchedText {
                leftStartIndex = middleIndex + 1
            } else if citiesArray[middleIndex] > searchedText {
                rightEndIndex = middleIndex - 1
            }
        }
        
        return [City]()
    }
}

extension CitiesInteractor: CitiesViewToInteractorProtocol {
    
    /// This is the first method that will run after ViewLoad
    // This method will load, map, distribute, sort and prepare cities data source
    func prepareCitiesData() {
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            guard let weakSelf = self else {return}
            let loadedData = weakSelf.loadCitiesFileData()
            let citiesModels = weakSelf.mapCitiesJsonData(from: loadedData)
            weakSelf.addCitiesToDataSourceBasedOnFirstChar(cities: citiesModels)
            weakSelf.sortCitiesAlphabetically()
            weakSelf.presenterDelegate?.dataIsReady()
        }
    }
    
    
    /// This method will be called by View when user type in search bar
    /// - Parameter userInput: String that user typed in search bar
    func searchFor(userInput: String) {
        let firstChar = String(userInput.prefix(1)).lowercased()
        let fiteredCities = binarySearch(in: citiesDistributedData[firstChar] ?? [City](), for: userInput.lowercased())
        presenterDelegate?.citiesSearchResults(cities: fiteredCities)
    }
}

