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
    
}
