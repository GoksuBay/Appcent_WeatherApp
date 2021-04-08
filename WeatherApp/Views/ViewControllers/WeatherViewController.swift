//
//  WeatherViewController.swift
//  WeatherApp
//
//  Created by Goksubay on 8.04.2021.
//

import UIKit

class WeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var id : Int!
    var weatherTableViewModel : WeatherTableViewModel!

    @IBOutlet weak var weatherTable: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherTable.delegate = self
        weatherTable.dataSource = self
        weatherTable.rowHeight = UITableView.automaticDimension
        weatherTable.estimatedRowHeight = UITableView.automaticDimension
        
        WebService.shared.getWeather(id: self.id) { (weather, error) in
            if let error = error
                {print(error)}
            if let weather = weather{
                self.weatherTableViewModel=WeatherTableViewModel(weatherList: weather)
                DispatchQueue.main.async {
                    self.weatherTable.reloadData()
                }
                
            }
            
        }
        
        

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weatherTableViewModel == nil ? 0 : self.weatherTableViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as! WeatherTableViewCell
        let weatherViewModel = self.weatherTableViewModel.atIndexPath(indexPath.row)
        
        cell.maxTempLabel.text = String(format: "%.2f" , weatherViewModel.maxTemp) + "C"
        cell.minTempLabel.text = String(format: "%.2f" , weatherViewModel.minTemp) + "C"
        cell.HumidityLabel.text = String(weatherViewModel.humidity) + "%"
        cell.dateLabel.text = String(weatherViewModel.date)
        cell.windSpeedLabel.text = String(format: "%.2f" , weatherViewModel.windSpeed) + "km/h"
        cell.stateLabel.text = String(weatherViewModel.stateName)
        cell.directionLabel.text = String(weatherViewModel.windDirection)
        
        WebService.shared.getImage(urlString: API.ICON_URL + weatherViewModel.stateCode + ".png") { (data) in
            if let image = data {
                DispatchQueue.main.async {
                    cell.stateImage.image = UIImage(data: image)
                }
            }
        }
        
        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
