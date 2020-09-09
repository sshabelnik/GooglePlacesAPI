//
//  SearchVCAssembly.swift
//  GooglePlacesAPI
//
//  Created by Сергей Шабельник on 08.09.2020.
//  Copyright © 2020 Сергей Шабельник. All rights reserved.
//

import Foundation
import UIKit
import GooglePlaces

class SearchVCAssembly: NSObject{
    
    @IBOutlet weak var viewController: UIViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        guard let view = viewController as? ViewController else { return }
        
        let presenter = SearchPresenter()
        let dataManager = PlacesServiceImplementation()
        
        view.presenter = presenter
        view.resultsViewController = GMSAutocompleteResultsViewController()
        view.locationManager = CLLocationManager()
        view.filter = GMSAutocompleteFilter()
        
        presenter.view = view
        presenter.dataManager = dataManager
    }
}
