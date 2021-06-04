//
//  CitiesRouter.swift
//  BackBaseTask
//
//  Created by Muhamed Shaban on 04/06/2021.
//

import UIKit

protocol citiesRouterProtocol {
    func navigateToLocationScreen(view: CitiesViewController, cityInfo: City)
}

class CitiesRouter {
    static func createCitiesModule() -> UINavigationController {
        let citiesPresenter = CitiesPresenter()
        let citiesInteractor = CitiesInteractor()
        let citiesVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "CitiesViewController") as! CitiesViewController
        citiesVC.citiesRouter = CitiesRouter()
        citiesVC.interactorDelegate = citiesInteractor
        citiesInteractor.presenterDelegate = citiesPresenter
        citiesPresenter.viewDelegate
 = citiesVC
        return UINavigationController(rootViewController: citiesVC)
    }
}

extension CitiesRouter: citiesRouterProtocol {
    func navigateToLocationScreen(view: CitiesViewController, cityInfo: City) {
        let locationViewController = CityLocationViewController(nibName: "LocationViewController", bundle: nil)
        locationViewController.city = cityInfo
        view.navigationController?.pushViewController(locationViewController, animated: false)
    }
}
