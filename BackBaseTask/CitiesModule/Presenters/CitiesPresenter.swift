//
//  CitiesPresenter.swift
//  BackBaseTask
//
//  Created by Muhamed Shaban on 03/06/2021.
//

import Foundation

protocol CitiesViewDelegate: NSObjectProtocol {
    func startLoading()
    func stopLoading()
    func setFillteredCities(cities: [City])
}

class CitiesPresenter {
    let citiesService: CitiesService
    weak var delegate: CitiesViewDelegate?
    
    init(citiesService: CitiesService) {
        self.citiesService = citiesService
        DispatchQueue.global(qos: .userInteractive).async { [weak self] in
            self?.loadCitiesDate()
        }
    }
    
    func loadCitiesDate() {
        citiesService.loadCitiesJsonData { [weak self] citiesResponse in
            self?.delegate?.stopLoading()
            self?.delegate?.setFillteredCities(cities: citiesResponse ?? [City]())
        }
    }
}
