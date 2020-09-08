//
//  PlaceModel.swift
//  GooglePlacesAPI
//
//  Created by Сергей Шабельник on 07.09.2020.
//  Copyright © 2020 Сергей Шабельник. All rights reserved.
//

import Foundation

struct PlaceModel: Codable {
    
    let name: String
    let rating: Double
    let photos: [Photo]
}

struct Photo: Codable{
    
    let photo_reference: String
}
