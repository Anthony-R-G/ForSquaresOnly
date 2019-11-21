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
    
    //MARK: -- Lazy Properties
    lazy var mapView: MKMapView = {
        let map = MKMapView()
        map.mapType = .standard
        map.showsBuildings = true
        map.showsUserLocation = true
        map.isZoomEnabled = true
        map.isScrollEnabled = true
        map.showsCompass = true
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
        searchBar.tag = 0
        return searchBar
    }()
    
    lazy var eroticLocationSearchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.placeholder = "Search Location..."
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(searchBar)
        searchBar.delegate = self
        searchBar.tag = 1
        return searchBar
    }()
    
    lazy var hamBoogerMenYouButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "list.dash"), for: .normal)
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.showsTouchWhenHighlighted = true
        button.addTarget(self, action: #selector(listButtonPressed), for: .touchUpInside)
        button.backgroundColor = .white
        button.tintColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        return button
    }()
    
    lazy var mapCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        //        layout.estimatedItemSize = CGSize(width: 100, height: 100)
        let collection = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collection.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "mapSearchCell")
        collection.backgroundColor = .clear
        collection.delegate = self
        return collection
    }()
    //MARK: -- Properties
    let locationManager = CLLocationManager()
    
    var venues = [Venues]() {
        didSet {
            
            mapCollectionView.reloadData()
            
        }
    }
    
    var userLocation = "New York, NY" {
        didSet {
            eroticLocationSearchBar.placeholder = userLocation
        }
    }
    
    
    
    //MARK: -- Methods
    @objc private func listButtonPressed() {
        
    }
    
    private func getCoordinateFromVenue(location: String) {
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(location) { (placemarks, error) in
            guard error == nil else {
                print("error found")
                return
            }
            
            guard let placemark = placemarks?[0] else {
                print("smd")
                return
            }
            
            guard let newLocation = placemark.location else {
                print("i said smd")
                return
            }
            
            self.mapView.setCenter(CLLocationCoordinate2D(latitude: newLocation.coordinate.latitude, longitude: newLocation.coordinate.longitude), animated: true)
            
            self.loadVenues(query: self.eroticVenueSearchBar.text ?? "", lat: newLocation.coordinate.latitude, long: newLocation.coordinate.longitude)
            
        }
    }
    
    private func requestLocationAndAuthorize() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.requestLocation()
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
    
    private func loadVenues(query: String, lat: Double, long: Double) {
        FourSquareAPIClient.manager.getVenueData(query: query, lat: lat, long: long) { (result) in
            switch result {
            case .success(let venuesFromOnline):
                DispatchQueue.main.async {
                     self.venues = venuesFromOnline
                    dump(venuesFromOnline)
                }
               
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        requestLocationAndAuthorize()
        setConstraints()
    }
}


extension SexySearchViewController {
    //MARK: -- Constraints
    private func setConstraints(){
        setMapConstraints()
        setVenueSearchBarConstraints()
        setLocationSearchBarConstraints()
        setButtonConstraints()
        setMapCollectionConstraints()
    }
    
    private func setMapCollectionConstraints() {
        mapView.addSubview(mapCollectionView)
        mapCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mapCollectionView.bottomAnchor.constraint(equalTo: mapView.bottomAnchor),
            mapCollectionView.leadingAnchor.constraint(equalTo: mapView.leadingAnchor),
            mapCollectionView.trailingAnchor.constraint(equalTo: mapView.trailingAnchor),
            mapCollectionView.heightAnchor.constraint(equalToConstant: 100)])
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
    
    private func setButtonConstraints() {
        hamBoogerMenYouButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            hamBoogerMenYouButton.topAnchor.constraint(equalTo: eroticVenueSearchBar.topAnchor),
            hamBoogerMenYouButton.leadingAnchor.constraint(equalTo: eroticVenueSearchBar.trailingAnchor),
            hamBoogerMenYouButton.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hamBoogerMenYouButton.heightAnchor.constraint(equalTo: eroticVenueSearchBar.heightAnchor),
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
        switch searchBar.tag {
        case 0:
            guard let venue = searchBar.text else { return }
            getCoordinateFromVenue(location: userLocation)
        case 1:
            guard let location = searchBar.text else { return }
            getCoordinateFromVenue(location: userLocation)
        default: ()
        }
    }
}


extension SexySearchViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return venues.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "mapSearchCell", for: indexPath) as? SearchCollectionViewCell else {
            return UICollectionViewCell()
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = SexyDetailViewController()
        detailVC.venue = venues[indexPath.row]
        present(detailVC, animated: true, completion: nil)
    }
}
