//
//  RestaurantAPI.swift
//  NetworkLayerDemo
//
//  Created by G Abhisek on 17/08/19.
//  Copyright © 2019 Abhisek. All rights reserved.
//

import Foundation
import CoreLocation

struct RestaurantAPIQueryParamModel {
    let coordinate: CLLocationCoordinate2D
    let lookupRadius: Int
}

///  This API will hold all APIs related to restaurant
enum RestaurantAPI {
    case getNearbyRestaurant(RestaurantAPIQueryParamModel)
}

extension RestaurantAPI: APIProtocol {
    func httpMthodType() -> HTTPMethodType {
        var methodType = HTTPMethodType.get
        switch self {
        case .getNearbyRestaurant(_):
            methodType = .get
        }
        return methodType
    }

    func apiEndPath() -> String {
        var apiEndPath = ""
        switch self {
        case .getNearbyRestaurant(let queryModel):
            apiEndPath += WebserviceConstants.placesAPI + "location=\(queryModel.coordinate.latitude),\(queryModel.coordinate.longitude)&radius=\(queryModel.lookupRadius)&type=restaurant&key=\(AppConstants.googleApiKey)"
        }
        return apiEndPath
    }

    func apiBasePath() -> String {
        switch self {
        case .getNearbyRestaurant(_):
            return WebserviceConstants.baseURL
        }
    }
}
