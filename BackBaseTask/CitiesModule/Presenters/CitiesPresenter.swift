//
//  CitiesPresenter.swift
//  BackBaseTask
//
//  Created by Muhamed Shaban on 03/06/2021.
//

import Foundation

/// This protocol is implemented by cities View
/// Presenter To View
protocol CitiesPresenterToViewProtocol: class {
    func startLoading()
    func stopLoading()
    func setFillteredCities(cities: [City])
}

class CitiesPresenter {
    var viewDelegate: CitiesPresenterToViewProtocol!
    
}

extension CitiesPresenter: CitiesInteractorToPresenterProtocol {
    
    /// Interactor will call this method when cities data is ready
    func dataIsReady() {
        viewDelegate.stopLoading()
    }
    
    /// Interactor will call this method when search result is ready
    func citiesSearchResults(cities: [City]) {
        viewDelegate.setFillteredCities(cities: cities)
    }
}
