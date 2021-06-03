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
}

class CitiesPresenter {
    let citiesService: CitiesService
    weak var delegate: CitiesViewDelegate?
    
    init(citiesService: CitiesService) {
        self.citiesService = citiesService
        citiesService.loadCitiesJsonData { [weak self] citiesResponse in
            self?.delegate?.stopLoading()
        }
        delegate?.startLoading()
    }
}
