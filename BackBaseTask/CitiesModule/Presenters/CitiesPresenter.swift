//
//  CitiesPresenter.swift
//  BackBaseTask
//
//  Created by Muhamed Shaban on 03/06/2021.
//

import Foundation

protocol CitiesPresenterToViewProtocol: class {
    func startLoading()
    func stopLoading()
    func setFillteredCities(cities: [City])
}

class CitiesPresenter {
   
    var viewDelegate: CitiesPresenterToViewProtocol!
}

extension CitiesPresenter: CitiesInteractorToPresenterProtocol {
    func dataIsReady() {
        viewDelegate.stopLoading()
    }
    
    func citiesSearchResults(cities: [City]) {
        viewDelegate.setFillteredCities(cities: cities)
    }
    
}
