//
//  LocationModel.swift
//  WeatherApp
//
//  Created by Goksubay on 6.04.2021.
//

import Foundation

/* Only Location informations return in JSON response*/
struct LocationModel : Decodable {
    var distance:Int?
    var title:String?
    var location_type:String?
    var woeid:Int?
    var latt_long:String?
}
