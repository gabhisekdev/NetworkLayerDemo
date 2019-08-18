//
//  RestaurantRequests.swift
//  NetworkLayerDemo
//
//  Created by G Abhisek on 17/08/19.
//  Copyright © 2019 Abhisek. All rights reserved.
//

import Foundation

typealias GetRestaurantResponse = (Result<[Restaurant], Error>) -> Void

protocol RestauranServiceRequestType {
    @discardableResult func getAllNearbyRestaurant(apiQueryModel: RestaurantAPIQueryParamModel, completion: @escaping GetRestaurantResponse) -> URLSessionDataTask?
}

struct RestaurantServiceRequests: RestauranServiceRequestType {
    
    @discardableResult func getAllNearbyRestaurant(apiQueryModel: RestaurantAPIQueryParamModel, completion: @escaping GetRestaurantResponse) -> URLSessionDataTask? {
        let contactRequestModel = APIRequestModel(api: RestaurantAPI.getNearbyRestaurant(apiQueryModel))
        return WebserviceHelper.requestAPI(apiModel: contactRequestModel) { response in
            switch response {
            case .success(let serverData):
                JSONResponseDecoder.decodeFrom(serverData, returningModelType: AllRestaurants.self, completion: { (allRestaurantResponse, error) in
                    if let parserError = error {
                        completion(.failure(parserError))
                        return
                    }
                    
                    if let restaurantResponse = allRestaurantResponse {
                        completion(.success(restaurantResponse.restaurantList))
                        return
                    }
                })
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
