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
    
    var presenterDelegate: CitiesInteractorToPresenterProtocol!
    var citiesDistributedData: [String: [City]] = [:]
    
    init() {
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            self?.loadCitiesJsonData()
        }
    }
    
    func loadCitiesJsonData() {
        if let url = Bundle.main.url(forResource: "cities", withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let citiesJsonData = try decoder.decode([City].self, from: data)
                print(citiesJsonData.count)
                
                addCitiesToDataSourceBasedOnFirstChar(cities: citiesJsonData)
                print(citiesDistributedData.count)
                sortCitiesAlphabetically()
                presenterDelegate.dataIsReady()
            } catch {
                print("error:\(error)")
            }
        }
    }
    
    func addCitiesToDataSourceBasedOnFirstChar(cities: [City]) {
        for city in cities {
            let firstChar = String(city.name.prefix(1))
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
                    }
                }
                for index in middleIndex...rightEndIndex {
                    if citiesArray[index].name.lowercased().hasPrefix(searchedText) {
                        filteredArray.append(citiesArray[index])
                    }
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
    func searchFor(userInput: String) {
        let firstChar = String(userInput.prefix(1))
        let fiteredCities = binarySearch(in: citiesDistributedData[firstChar] ?? [City](), for: userInput.lowercased())
        presenterDelegate.citiesSearchResults(cities: fiteredCities)
    }
}
