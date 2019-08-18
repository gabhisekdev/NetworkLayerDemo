//
//  Restaurant.swift
//  NetworkLayerDemo
//
//  Created by G Abhisek on 17/08/19.
//  Copyright © 2019 G Abhisek. All rights reserved.
//

import Foundation
import CoreLocation

struct AllRestaurants {
    let restaurantList: [Restaurant]
}

extension AllRestaurants: Decodable {
    enum CodingKeys: String, CodingKey {
        case restaurantList = "results"
    }
}

struct Restaurant {
    let name: String?
    let vicinity: String?
}

extension Restaurant: Decodable {
    enum CodingKeys: CodingKey {
        case name
        case vicinity
    }
}
