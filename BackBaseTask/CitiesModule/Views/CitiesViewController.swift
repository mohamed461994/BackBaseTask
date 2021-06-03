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

class CitiesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    let citiesPresenter = CitiesPresenter(citiesService: CitiesService.shared())
    lazy var searchBar = UISearchBar(frame: CGRect.zero)
    var filtteredCities: [City] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    func setupViews() {
        activityIndicator?.startAnimating()
        citiesPresenter.delegate = self
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.placeholder = "Search"
        navigationItem.titleView = searchBar
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtteredCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CitiyCellID", for: indexPath)
        cell.textLabel?.text = "\(filtteredCities[indexPath.row].name), \(filtteredCities[indexPath.row].country)"
        cell.detailTextLabel?.text = "lat: \(filtteredCities[indexPath.row].coord.lat)   lon: \(filtteredCities[indexPath.row].coord.lon)"
        return cell
    }
}

extension CitiesViewController: CitiesViewDelegate {
    func setFillteredCities(cities: [City]) {
        filtteredCities = cities
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func startLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator?.startAnimating()
        }
    }

    func stopLoading() {
        DispatchQueue.main.async { [weak self] in
            self?.activityIndicator?.stopAnimating()
        }
    }
    
}

extension CitiesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
       
    }
}
