//
//  ApiResponse.swift
//  GooglePlacesAPI
//
//  Created by Сергей Шабельник on 07.09.2020.
//  Copyright © 2020 Сергей Шабельник. All rights reserved.
//

import Foundation

struct ApiResponse: Codable {
    
    let results: [PlaceModel]
}
