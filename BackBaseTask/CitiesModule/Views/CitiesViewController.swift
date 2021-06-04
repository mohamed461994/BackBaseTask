//
//  ViewController.swift
//  BackBaseTask
//
//  Created by Muhamed Shaban on 03/06/2021.
//

import UIKit

protocol CitiesViewToInteractorProtocol: class {
    func searchFor(userInput: String)
}

class CitiesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    var interactorDelegate: CitiesViewToInteractorProtocol!
    var citiesRouter: citiesRouterProtocol!
    lazy var searchBar = UISearchBar(frame: CGRect.zero)
    var filtteredCities: [City] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    func setupViews() {
        searchBar.delegate = self
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.placeholder = "Search"
        navigationItem.titleView = searchBar
        activityIndicator?.startAnimating()
    }
}

extension CitiesViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filtteredCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CitiyCellID", for: indexPath)
        cell.textLabel?.text = "\(filtteredCities[indexPath.row].name), \(filtteredCities[indexPath.row].country)"
        cell.detailTextLabel?.text = "lat: \(filtteredCities[indexPath.row].coord.lat)   lon: \(filtteredCities[indexPath.row].coord.lon)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        citiesRouter.navigateToLocationScreen(view: self, cityInfo: filtteredCities[indexPath.row])
    }
}

extension CitiesViewController: CitiesPresenterToViewProtocol {
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
        interactorDelegate.searchFor(userInput: searchText)
//        let fiterServices = filtteredCities.filter({$0.name.lowercased().hasPrefix(searchText.lowercased())})
//        filtteredCities = fiterServices
//        DispatchQueue.main.async { [weak self] in
//            self?.tableView.reloadData()
//        }
    }
}
