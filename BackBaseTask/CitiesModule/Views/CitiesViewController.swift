//
//  ViewController.swift
//  BackBaseTask
//
//  Created by Muhamed Shaban on 03/06/2021.
//

import UIKit

protocol CitiesPresenterDelegate: NSObjectProtocol {
    func searchFor(userInput: String)
}

class CitiesViewController: UIViewController {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    let ciriesPresenter = CitiesPresenter(citiesService: CitiesService.shared())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }
    
    func setupViews() {
        activityIndicator?.startAnimating()
        ciriesPresenter.delegate = self
    }

}

extension CitiesViewController: CitiesViewDelegate {
    func startLoading() {
        activityIndicator?.startAnimating()
    }

    func stopLoading() {
        activityIndicator?.stopAnimating()
    }
    
    
}
