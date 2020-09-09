//
//  ViewController.swift
//  GooglePlacesAPI
//
//  Created by Сергей Шабельник on 06.09.2020.
//  Copyright © 2020 Сергей Шабельник. All rights reserved.
//

import UIKit
import GooglePlaces
import GoogleMaps

class ViewController: UIViewController {
        
    //MARK: -
    var resultsViewController: GMSAutocompleteResultsViewController!
    var searchController: UISearchController!
    var filter: GMSAutocompleteFilter!
    var googleMapsView: GMSMapView!
    var locationManager: CLLocationManager!
    var presenter: SearchViewOutput!
    
    @IBOutlet weak var googleMapsContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter.initialSetup()
    }
    
    //MARK: - Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! DetailsViewController
        destVC.places = sender as? [PlaceModel]
    }
    
    //MARK: - IBAction
    @IBAction func searchControllerButtonPressed(_ sender: Any) {
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        searchController.searchBar.sizeToFit()
        self.present(searchController!, animated: true, completion: nil)
        
    }
    
}

// MARK: - GoogleMapsAutocompleteDelegate

extension ViewController: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        guard let city = place.name else { return }
        presenter.cityDidSelected(city: city)
         
    }
    
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didFailAutocompleteWithError error: Error){
        // TODO: handle the error.
        print("Error: ", error.localizedDescription)
    }
    
    // Turn the network activity indicator on and off again.
    func didRequestAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictions(_ viewController: GMSAutocompleteViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}

// MARK: - LocationManager
extension ViewController: CLLocationManagerDelegate{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locationManager.location?.coordinate else { return }
        DispatchQueue.main.async {
            self.moveCameraToLocation(location: location)
        }
    }
}

// MARK: - ViewInput
extension ViewController: SearchViewInput{
    
    
    func showPlace(places: [PlaceModel]) {
        self.performSegue(withIdentifier: "detailsSegue", sender: places)
    }
    
    func moveCameraToLocation(location: CLLocationCoordinate2D){
        googleMapsView.isMyLocationEnabled = true
        let camera = GMSCameraPosition.camera(withTarget: location, zoom: 15)
        self.googleMapsView.animate(to: camera)
        
        self.locationManager.stopUpdatingLocation()
    }
    
    func setupSearchController() {
        resultsViewController?.delegate = self
        filter.type = .city
        resultsViewController?.autocompleteFilter = filter
    }
    
    func setupGoogleMaps() {
        self.googleMapsView = GMSMapView(frame: googleMapsContainer.frame)
        self.view.addSubview(self.googleMapsView)
        
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        self.locationManager.requestWhenInUseAuthorization()
    }
}

