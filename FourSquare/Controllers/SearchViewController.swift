//
//  ViewController.swift
//  FourSquare
//
//  Created by Anthony Gonzalez on 11/16/19.
//  Copyright © 2019 Antnee. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class SexySearchViewController: UIViewController {
    
    lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.mapType = .standard
        view.addSubview(map)
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    lazy var eroticVenueSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        searchBar.placeholder = "Search Venue..."
        searchBar.delegate = self
        return searchBar
    }()
    
    lazy var eroticLocationSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Location..."
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        searchBar.delegate = self
        return searchBar
    }()
    
    lazy var hamBoogerMenYou: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "line.horizontal.3"), for: .normal)
    }()
    
    private func setConstraints(){
        setMapConstraints()
        setVenueSearchBarConstraints()
        setLocationSearchBarConstraints()
    }
    
    private func setVenueSearchBarConstraints() {
        NSLayoutConstraint.activate([
            eroticVenueSearchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            eroticVenueSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            eroticVenueSearchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -60)
        ])
    }
    
    private func setLocationSearchBarConstraints() {
        NSLayoutConstraint.activate([
            eroticLocationSearchBar.topAnchor.constraint(equalTo: eroticVenueSearchBar.bottomAnchor),
            eroticLocationSearchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            eroticLocationSearchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    private func setMapConstraints() {
        NSLayoutConstraint.activate([
            mapView.heightAnchor.constraint(equalTo: view.heightAnchor),
            mapView.widthAnchor.constraint(equalTo: view.widthAnchor),
            mapView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mapView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    let locationManager = CLLocationManager()
    
    private func requestLocationAndAuthorize() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    
    private func configMapView () {
        mapView.showsBuildings = true
        mapView.showsUserLocation = true
        mapView.isZoomEnabled = true
        mapView.isScrollEnabled = true
        mapView.showsCompass = true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        requestLocationAndAuthorize()
        setConstraints()
        configMapView()
    }
}

extension SexySearchViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            let span = MKCoordinateSpan(latitudeDelta: 0.5, longitudeDelta: 0.5)
            let region = MKCoordinateRegion(center: location.coordinate, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("An error occurred: \(error)")
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        print("Authorization status changed to \(status.rawValue)")
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        default:
            break
        }
    }
}

extension SexySearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("SMD")
    }
}

