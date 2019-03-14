
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
        case getllBreeds
        case getImageBreed(String)
        case getAllSubBreeds(String)
        case getImageSubBreed(String,String)
        
        
        var url: URL {
            return URL(string: self.stringValue)!
        }
        var stringValue: String {
            switch self {
            case .getllBreeds:
                return "https://dog.ceo/api/breeds/list/all"
            case .getImageBreed(let breed):
                return "https://dog.ceo/api/breed/\(breed)/images/random"
            case .getAllSubBreeds(let breed):
                return "https://dog.ceo/api/breed/\(breed)/list"
            case .getImageSubBreed(let breed, let subBreed):
                return "https://dog.ceo/api/breed/\(breed)/\(subBreed)/images/random"
            }
        }
    }
    class func requestBreedsList(completionHandler: @escaping ([String], Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: Endpoint.getllBreeds.url) { (data, response, error) in
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
    class func requestSubBreedsList(breed: String!, completionHandler: @escaping ([String], Error?) -> Void) {
        let subBreedEndPoint = Endpoint.getAllSubBreeds(breed).url
        let task = URLSession.shared.dataTask(with: subBreedEndPoint) { (data, response, error) in
            if let error = error {
                print("Task error: " + error.localizedDescription)
                return
            }
            guard let data = data else {
                completionHandler([], error)
                return
            }
            let decoder = JSONDecoder()
            let breedsResponse = try! decoder.decode(SubBreedListResponse.self, from: data)
            let subBreeds = breedsResponse.message.map({$0})
            print(subBreeds)
            
            completionHandler(subBreeds, nil)
        }
        task.resume()
    }
    class func requestBreedsImagesRandom(breed: String, completionHandler: @escaping (BreedImage?, Error?) -> Void) {
        let ramdomBreedImageEndPoint = Endpoint.getImageBreed(breed).url
        let task = URLSession.shared.dataTask(with: ramdomBreedImageEndPoint){ (data, response, error) in
            if let error = error {
                print("Task error: " + error.localizedDescription)
                return
            }
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            let decoder = JSONDecoder()
            let imageData = try! decoder.decode(BreedImage.self, from: data)
            completionHandler(imageData, nil)
        }
        task.resume()
    }
    class func requestSubBreedImagesRandom(breed: String, subBreed: String, completionHandler: @escaping (BreedImage?, Error?) -> Void) {
        let ramdomSubBreedImageEndPoint = Endpoint.getImageSubBreed(breed, subBreed).url
        let task = URLSession.shared.dataTask(with: ramdomSubBreedImageEndPoint){ (data, response, error) in
            if let error = error {
                print("Task error: " + error.localizedDescription)
                return
            }
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            let decoder = JSONDecoder()
            let imageData = try! decoder.decode(BreedImage.self, from: data)
            completionHandler(imageData, nil)
        }
        task.resume()
    }
    class func requestImageFile(url: URL, completionHandler: @escaping (UIImage?, Error?) -> Void) {
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
            guard let data = data else {
                completionHandler(nil, error)
                return
            }
            let downloadedImage = UIImage(data: data)
            completionHandler(downloadedImage, nil)
        })
        task.resume()
    }
}

