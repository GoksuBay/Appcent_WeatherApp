//
//  WeatherViewModel.swift
//  WeatherApp
//
//  Created by Goksubay on 6.04.2021.
//

import Foundation

struct WeatherViewModel {
    
    let weather : LocationWeather
    
    var id : Int {
        return self.weather.id!
    }
    var stateName : String {
        return self.weather.weather_state_name!
    }
    var stateCode : String {
        return self.weather.weather_state_abbr!
    }
    var windDirection : String {
        return self.weather.wind_direction_compass!
    }
    var date : String  {
        return self.weather.applicable_date!
    }
    var minTemp : Double {
        return self.weather.min_temp!
    }
    var maxTemp : Double {
        return self.weather.max_temp!
    }
    var temperature : Double {
        return self.weather.the_temp!
    }
    var windSpeed : Double {
        return self.weather.wind_speed!
    }
    var humidity : Int {
        return self.weather.humidity!
    }
    var predictability : Int {
        return self.weather.predictability!
    }
}
