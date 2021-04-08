//
//  GPSService.swift
//  WeatherApp
//
//  Created by Goksubay on 6.04.2021.
//

import Foundation
import CoreLocation

class GPSService: NSObject, CLLocationManagerDelegate{
    static let shared = GPSService()
    
    private override init() {}
    let locationManager = CLLocationManager()
    
    var completion : ((CLLocation) -> Void)?
    
    public func getUserLocation(completion : @escaping ((_ location : CLLocation) -> Void)){
        self.completion = completion
        locationManager.requestWhenInUseAuthorization()
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let locations = locations.first
        else{
            return
        }
        
        completion?(locations)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        locationManager.startUpdatingLocation()
    }
    
    
}

