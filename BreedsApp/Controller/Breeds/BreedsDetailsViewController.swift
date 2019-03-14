//
//  BreedsDetailsViewController.swift
//  BreedsApp
//
//  Created by Silas S. Caxias on 14/03/19.
//  Copyright © 2019 Silas S. Caxias. All rights reserved.
//

import UIKit

class BreedsDetailsViewController: UIViewController {
    
    var breedName: String? = nil
    var breedImage: UIImage? = nil
    
    @IBOutlet weak var breedNameLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        breedNameLabel.text = breedName
        if let data = breedImage {
            imageView.image = data
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let subBreedsViewController = segue.destination as? SubBreedsViewController {
            subBreedsViewController.breed = breedName
        }
    }

}
