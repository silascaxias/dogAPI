//
//  BreedsListResponse.swift
//  BreedsApp
//
//  Created by Silas S. Caxias on 14/03/19.
//  Copyright © 2019 Silas S. Caxias. All rights reserved.
//

import Foundation

class BreedsListResponse: Codable {
    let status: String
    let message: [String: [String]]
}
