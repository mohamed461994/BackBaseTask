//
//  CityLocationViewController.swift
//  BackBaseTask
//
//  Created by Muhamed Shaban on 04/06/2021.
//

import UIKit
import MapKit

class CityLocationViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var mapView: MKMapView!
    
    // MARK: - Properties
    var city: City?
    
    // MARK: - Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }

    private func setupViews() {
        guard let cityInfo = city else {return}
        let selectedCityAnnotation = MKPointAnnotation()
        title = "\(cityInfo.name), \(cityInfo.country)"
        selectedCityAnnotation.title = "\(cityInfo.name), \(cityInfo.country)"
        selectedCityAnnotation.coordinate = CLLocationCoordinate2D(latitude: cityInfo.coord.lat, longitude: cityInfo.coord.lon)
        mapView.addAnnotation(selectedCityAnnotation)
        zoomOnMapAnnotation(lat: cityInfo.coord.lat, lon: cityInfo.coord.lon)
    }
    
    private func zoomOnMapAnnotation(lat: Double, lon: Double) {
        let cityLocation = CLLocation(latitude: lat, longitude: lon)
        let cityRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: cityLocation.coordinate.latitude, longitude: cityLocation.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        mapView.setRegion(cityRegion, animated: true)
    }

}
