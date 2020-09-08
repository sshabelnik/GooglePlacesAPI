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

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var resultsViewController: GMSAutocompleteResultsViewController?
    var searchController: UISearchController?
    var resultView: UITextView?
    var filter: GMSAutocompleteFilter?
    var googleMapsView: GMSMapView!
    var locationManager = CLLocationManager()
    var networkManager: PlacesService!
    
    var response: ApiResponse?
    
    @IBOutlet weak var googleMapsContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resultsViewController = GMSAutocompleteResultsViewController()
        resultsViewController?.delegate = self
        filter?.type = .city
        resultsViewController?.autocompleteFilter = filter
        
        self.locationManager.delegate = self
        self.locationManager.startUpdatingLocation()
        
        
        self.googleMapsView = GMSMapView(frame: googleMapsContainer.frame)
        self.view.addSubview(self.googleMapsView)
        
        networkManager = PlacesServiceImplementation()
    }
    
    @IBAction func searchControllerButtonPressed(_ sender: Any) {
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.searchResultsUpdater = resultsViewController
        self.present(searchController!, animated: true, completion: nil)
        
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let location = locationManager.location?.coordinate else { return }
        moveCameraToLocation(location: location)
        
    }
    
    func moveCameraToLocation(location: CLLocationCoordinate2D){
        let camera = GMSCameraPosition.camera(withTarget: location, zoom: 15)
        
        googleMapsView.isMyLocationEnabled = true
        self.googleMapsView.animate(to: camera)
        
        self.locationManager.stopUpdatingLocation()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC = segue.destination as! DetailsViewController
        let segueData = response?.results
        destVC.places = segueData
    }
    
}

// MARK: - GoogleMapsAutocompleteDelegate

// Handle the user's selection.
extension ViewController: GMSAutocompleteResultsViewControllerDelegate {
    func resultsController(_ resultsController: GMSAutocompleteResultsViewController,
                           didAutocompleteWith place: GMSPlace) {
        searchController?.isActive = false
        // Do something with the selected place.
        guard place.name != nil else { return }
        networkManager.getPlacesBy(city: place.name!) { (response) in
            switch response{
            case .success(let data):
                self.response = data
                self.performSegue(withIdentifier: "detailsSegue", sender: nil)
            case .failure(let error):
                print(String(describing: error))
                
            }
        }  
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

