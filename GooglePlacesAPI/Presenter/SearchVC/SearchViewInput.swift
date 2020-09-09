//
//  SearchViewInput.swift
//  GooglePlacesAPI
//
//  Created by Сергей Шабельник on 08.09.2020.
//  Copyright © 2020 Сергей Шабельник. All rights reserved.
//

import Foundation
import CoreLocation

protocol SearchViewInput: AnyObject {
    func showPlace(places: [PlaceModel])
    func setupGoogleMaps()
    func setupSearchController()
    func moveCameraToLocation(location: CLLocationCoordinate2D)
}
