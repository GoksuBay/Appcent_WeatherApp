//
//  LocationViewModel.swift
//  WeatherApp
//
//  Created by Goksubay on 6.04.2021.
//

import Foundation

struct LocationViewModel{
    let location : LocationModel
    
    var distance : Int {
        return self.location.distance!
    }
    var title : String {
        return self.location.title!
    }
    var locationType : String {
        return self.location.location_type!
    }
    var woeid : Int {
        return self.location.woeid!
    }
    var latt_long : String{
        return self.location.latt_long!
    }
}
