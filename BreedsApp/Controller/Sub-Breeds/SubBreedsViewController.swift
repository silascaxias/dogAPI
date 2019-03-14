//
//  SubBreedsViewController.swift
//  BreedsApp
//
//  Created by Silas S. Caxias on 14/03/19.
//  Copyright © 2019 Silas S. Caxias. All rights reserved.
//

import UIKit

class SubBreedsViewController: UIViewController {
  
    var breed: String? = nil
    var subBreeds: [String] = []

    @IBOutlet weak var breedNameLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        breedNameLabel.text = breed
        
        DogApi.requestSubBreedsList(breed: breed, completionHandler: handleSubBreedsListResponse(subBreeds:error:))
    }
    func handleSubBreedsListResponse(subBreeds: [String], error: Error?) {
        self.subBreeds = subBreeds
        print(subBreeds)
        DispatchQueue.main.async {
            self.pickerView.reloadAllComponents()
        }
    }
    func handleRandomImageResponse(imageData: BreedImage?, error: Error?) {
        guard let imageURL = URL(string: imageData?.message ?? "") else {
            return
        }
        DogApi.requestImageFile(url: imageURL, completionHandler: self.handleImageFileResponse(image:error:))
        
    }
    
    func handleImageFileResponse(image: UIImage?, error: Error?) {
        DispatchQueue.main.async {
            self.imageView.image = image
        }
    }


}
extension SubBreedsViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return subBreeds.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return subBreeds[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        DogApi.requestSubBreedImagesRandom(breed: breed!, subBreed: subBreeds[row], completionHandler: handleRandomImageResponse(imageData:error:))
    }
    
}
