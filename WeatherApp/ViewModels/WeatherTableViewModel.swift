//
//  WeatherTableViewModel.swift
//  WeatherApp
//
//  Created by Goksubay on 8.04.2021.
//

import Foundation

struct WeatherTableViewModel{
    let weatherList : [LocationWeather]
    
    func numberOfRowsInSection() -> Int {
        return self.weatherList.count
    }
    
    func atIndexPath(_ index: Int) -> WeatherViewModel{
        let weather = self.weatherList[index]
        return WeatherViewModel(weather: weather)
    }
}
