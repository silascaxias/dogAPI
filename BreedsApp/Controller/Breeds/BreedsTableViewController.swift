//
//  BreedsTableViewController.swift
//  BreedsApp
//
//  Created by Silas S. Caxias on 14/03/19.
//  Copyright © 2019 Silas S. Caxias. All rights reserved.
//

import UIKit

class BreedsTableViewController: UITableViewController {
    var breeds: [String] = []
    var breedImage: UIImage? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        DogApi.requestBreedsList(completionHandler: handleBreedsListResponse(breeds:error:))
    }

    func handleBreedsListResponse(breeds: [String], error: Error?) {
        self.breeds = breeds
        DispatchQueue.main.sync {
            self.tableView.reloadData()
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
            self.breedImage = image
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        breeds.sort()
        return breeds.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        let breed = breeds[indexPath.row]
        cell.textLabel?.text = breed
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectBreed = breeds[indexPath.row]
        DogApi.requestBreedsImagesRandom(breed: selectBreed, completionHandler: self.handleRandomImageResponse(imageData:error:))
        
        performSegue(withIdentifier: "moveToDetails", sender: selectBreed)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let breedsDetailsViewController = segue.destination as? BreedsDetailsViewController {
            if let selectedTask = sender as? String {
                breedsDetailsViewController.breedName = selectedTask
                breedsDetailsViewController.breedImage = breedImage
            }
        }        
    }
}
