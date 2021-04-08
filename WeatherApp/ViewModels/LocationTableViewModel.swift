//
//  LocationTableViewModel.swift
//  WeatherApp
//
//  Created by Goksubay on 7.04.2021.
//

import Foundation

struct LocationTableViewModel{
    let locationList : [LocationModel]
    var cityList : [LocationModel]
    
    func numberOfRowsInSection() -> Int {
        return self.locationList.count
    }
    
    mutating func cityNumberOfRowsInSection() -> Int {
        self.cityList = self.cityList.filter({ (location) -> Bool in
            return location.location_type == "City"
        })
        
        return cityList.count
    }
    
    func atIndexPath(_ index: Int) -> LocationViewModel{
        let location = self.locationList[index]
        return LocationViewModel(location: location)
    }
    
    func cityAtIndexPath(_ index: Int) -> LocationViewModel{
        let city = self.cityList[index]
        return LocationViewModel(location: city)
    }
    
    
}
