//
//  LocationManager.swift
//  NetworkLayerDemo
//
//  Created by G Abhisek on 18/08/19.
//  Copyright © 2019 G Abhisek. All rights reserved.
//

import Foundation
import CoreLocation

final class LocationManager: NSObject, CLLocationManagerDelegate {
    
    static let sharedManager = LocationManager()
    fileprivate var locationManager: CLLocationManager!
    var userCurrentCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
    
    func initializeLocationManager() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let userLocation = manager.location else { return }
        if userLocation.coordinate.latitude != 0.0 &&  userLocation.coordinate.longitude != 0.0 {
            userCurrentCoordinate = userLocation.coordinate
            notifyLocationAvailability()
        }
    }
    
    private func notifyLocationAvailability() {
        NotificationCenter.default.post(name: Notification.Name("LocationAvailable"), object: nil)
    }
    
}
