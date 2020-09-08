//
//  Endpoints.swift
//  GooglePlacesAPI
//
//  Created by Сергей Шабельник on 07.09.2020.
//  Copyright © 2020 Сергей Шабельник. All rights reserved.
//

import Foundation

class Endpoints{
    
    static func setURL(with city: String) -> String{
        return "https://maps.googleapis.com/maps/api/place/textsearch/json?query=\(city)+point+of+interest&key=\(Constants.API_KEY)"
    }
    
    static func getImageURL(referense: String) -> String{
        return "https://maps.googleapis.com/maps/api/place/photo?key=\(Constants.API_KEY)&photoreference=\(referense)&maxwidth=200"
    }
}
