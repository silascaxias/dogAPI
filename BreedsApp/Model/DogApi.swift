
//
//  APIService.swift
//  BreedsApp
//
//  Created by Silas S. Caxias on 13/03/19.
//  Copyright © 2019 Silas S. Caxias. All rights reserved.
//

import Foundation
import UIKit

class DogApi{
    enum Endpoint {
        case listAllBreeds
        
        var url: URL {
            return URL(string: self.stringValue)!
        }
        var stringValue: String {
            switch self {
            case .listAllBreeds:
                return "https://dog.ceo/api/breeds/list/all"
            }
        }
    }
    class func requestBreedsList(completionHandler: @escaping ([String], Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: Endpoint.listAllBreeds.url) { (data, response, error) in
            if let error = error {
                print("Task error: " + error.localizedDescription)
                return
            }
            guard let data = data else {
                completionHandler([], error)
                return
            }
            let decoder = JSONDecoder()
            let breedsResponse = try! decoder.decode(BreedsListResponse.self, from: data)
            let breeds = breedsResponse.message.keys.map({$0})
            completionHandler(breeds, nil)
        }
        task.resume()
    }
}

