//
//  SearchViewOutput.swift
//  GooglePlacesAPI
//
//  Created by Сергей Шабельник on 08.09.2020.
//  Copyright © 2020 Сергей Шабельник. All rights reserved.
//

import Foundation

protocol SearchViewOutput: AnyObject {
    func initialSetup()
    func cityDidSelected(city: String)
}
