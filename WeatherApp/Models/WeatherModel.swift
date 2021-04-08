//
//  WeatherModel.swift
//  WeatherApp
//
//  Created by Goksubay on 6.04.2021.
//

import Foundation
//
//  Locations.swift
//  WeatherApp
//
//  Created by Goksubay on 6.04.2021.
//

import Foundation

/* For the weather of single location for 7 days */
/* TODO: Body tekrar kontrol et hata çıkmasın */
struct LocationWeather : Decodable{
    
    var id:Int?
    var weather_state_name:String?
    var weather_state_abbr:String?
    var wind_direction_compass:String?
    var applicable_date:String?
    var min_temp:Double?
    var max_temp:Double?
    var the_temp:Double?
    var wind_speed:Double?
    var humidity:Int?
    var predictability:Int?
    
}

/* Weather body in JSON response*/
struct WeatherModel : Decodable {
    var consolidated_weather:[LocationWeather]?
    var title:String?
    var latt_long:String?
}



