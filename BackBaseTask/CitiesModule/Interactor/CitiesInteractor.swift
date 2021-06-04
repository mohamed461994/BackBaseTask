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
            citiesDistributedData[cityFirstCarshKey] = citiesDistributedData[cityFirstCarshKey]?.sorted { $0.name.lowercased() < $1.name.lowercased() }
        }
    }
    
}

extension CitiesInteractor: CitiesViewToInteractorProtocol {
    func searchFor(userInput: String) {
        let firstChar = String(userInput.prefix(1))
        let fiteredCities = citiesDistributedData[firstChar]?.filter({$0.name.lowercased().hasPrefix(userInput.lowercased())})
        presenterDelegate.citiesSearchResults(cities: fiteredCities ?? [City]())
    }
}
