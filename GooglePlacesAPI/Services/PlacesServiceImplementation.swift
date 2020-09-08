//
//  PlacesServiceImplementation.swift
//  GooglePlacesAPI
//
//  Created by Сергей Шабельник on 08.09.2020.
//  Copyright © 2020 Сергей Шабельник. All rights reserved.
//

import Foundation
import Alamofire

class PlacesServiceImplementation: PlacesService {
    
    func getPlacesBy(city: String, completion: @escaping (Result<ApiResponse, Error>) -> Void){
        AF.request(Endpoints.setURL(with: city))
            .response { (response) in
                
                if let error = response.error{
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
                
                guard let result = response.data else {return}
                
                let decoder = JSONDecoder()
                
                let places = try! decoder.decode(ApiResponse.self, from: result)
                
                DispatchQueue.main.async {
                    
                    completion(.success(places))
                    
                }
        }
    }
    
}
