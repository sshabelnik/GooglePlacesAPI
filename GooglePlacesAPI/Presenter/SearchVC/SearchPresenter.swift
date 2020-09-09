//
//  SearchPresenter.swift
//  GooglePlacesAPI
//
//  Created by Сергей Шабельник on 08.09.2020.
//  Copyright © 2020 Сергей Шабельник. All rights reserved.
//

import Foundation

class SearchPresenter: SearchViewOutput {
    
    weak var view: SearchViewInput!
    var dataManager: PlacesService!
    
    func cityDidSelected(city: String) {
        dataManager.getPlacesBy(city: city) { (response) in
            switch response{
            case .success(let data):
                let places = data.results
                self.view.showPlace(places: places)
            case .failure(let error):
                print(String(describing: error))
                
            }
        }
    }
    
    func initialSetup() {
        view.setupGoogleMaps()
        view.setupSearchController()

    }
    
    
    
}
