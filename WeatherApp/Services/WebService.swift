//
//  WebService.swift
//  WeatherApp
//
//  Created by Goksubay on 6.04.2021.
//

import Foundation

class WebService{
    private init(){}
    
    static let shared = WebService()
    let imageCache = NSCache<NSString, NSData>()
    
    func getLocations(latt_long:String , completion: @escaping (_ data:[LocationModel]? , _ error:Error?) -> Void){
        if let url = URL(string: API.URL + Type.location.rawValue + latt_long.replacingOccurrences(of: " ", with: "")){
        URLSession.shared.dataTask(with: url){
            (data , response, error) in
            if let error = error{
                print(error.localizedDescription)
                return
            }
            
            print(url)
            
            
            if let data = data {
                do {
                    _ = try JSONDecoder().decode([LocationModel].self, from: data)
                } catch let error {
                    print(error.localizedDescription)
                }
                
                let locations = try? JSONDecoder().decode([LocationModel].self, from: data)
                locations == nil ? completion(nil, error) :  completion(locations!.self,nil)
            }
        }.resume()
            
        }
    }
    
    
    func getWeather(id:Int , completion: @escaping (_ data:[LocationWeather]? ,_ error:Error?) -> Void){
        let url = URL(string: API.URL + Type.weather.rawValue + String(id))
        URLSession.shared.dataTask(with: url!){
            (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            if let data = data {
                do {
                    _ = try JSONDecoder().decode(WeatherModel.self, from: data)
                } catch let error {
                    print(error.localizedDescription)
                }
                let weather = try? JSONDecoder().decode(WeatherModel.self, from: data)
                weather == nil ? completion(nil,error) : completion(weather!.consolidated_weather,nil)
            }
        }.resume()
        
    }
    
    func getImage(urlString: String, completion: @escaping (Data?) -> Void){
        guard let url = URL(string: urlString) else{
            completion(nil)
            return
        }
        
        if let cachedImage = imageCache.object(forKey: NSString(string: urlString)){
            completion(cachedImage as Data)
        } else{
            URLSession.shared.dataTask(with: url){(data,response,error) in
                guard error == nil , let data = data
                else {completion(nil) ;  return}
                
                self.imageCache.setObject(data as NSData, forKey: NSString(string: urlString))
                completion(data)
            }.resume()
        }
    }
}
