//
//  CitiesService.swift
//  BackBaseTask
//
//  Created by Muhamed Shaban on 03/06/2021.
//

import Foundation

protocol CitiesInteractorToPresenterProtocol: class {
    func citiesSearchResults(cities: [City])
    func dataIsReady()
}

class CitiesInteractor {
    
    var presenterDelegate: CitiesInteractorToPresenterProtocol?
    var citiesDistributedData: [String: [City]] = [:]
    
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
    
    func sortCitiesAlphabetically() {
        for (cityFirstCarshKey, _) in citiesDistributedData {
            citiesDistributedData[cityFirstCarshKey] = citiesDistributedData[cityFirstCarshKey]?.sorted { $0 < $1 }
        }
    }
    
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
    
    func searchFor(userInput: String) {
        let firstChar = String(userInput.prefix(1)).lowercased()
        let fiteredCities = binarySearch(in: citiesDistributedData[firstChar] ?? [City](), for: userInput.lowercased())
        presenterDelegate?.citiesSearchResults(cities: fiteredCities)
    }
}
