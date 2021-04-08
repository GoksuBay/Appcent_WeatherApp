//
//  CityListViewController.swift
//  WeatherApp
//
//  Created by Goksubay on 7.04.2021.
//

import UIKit

class CityListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var cityList: UITableView!
    
    private var locationTableViewModel : LocationTableViewModel!
    static var id : Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cityList.delegate = self
        cityList.dataSource = self
        cityList.rowHeight = UITableView.automaticDimension
        cityList.estimatedRowHeight = UITableView.automaticDimension

        GPSService.shared.getUserLocation { (location) in
            
            Location.shared.latitute = String(location.coordinate.latitude)
            Location.shared.longitute = String(location.coordinate.longitude)
            
            WebService.shared.getLocations(latt_long: Location.shared.latitute + "," + Location.shared.longitute) { (locations, error) in
                if let location = locations{
                    self.locationTableViewModel=LocationTableViewModel(locationList: location, cityList: location)
                    DispatchQueue.main.async {
                        self.cityList.reloadData()
                    }
                    
                }
            }
        }

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationTableViewModel == nil ? 0 : self.locationTableViewModel.cityNumberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TableViewCell
            let locationViewModel = self.locationTableViewModel.cityAtIndexPath(indexPath.row)
            cell.cityLabel.text = locationViewModel.title

        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(self.locationTableViewModel.atIndexPath(indexPath.row).locationType == "City"){
        let location = self.locationTableViewModel.cityAtIndexPath(indexPath.row)
        CityListViewController.id =  location.woeid
        performSegue(withIdentifier: "toWeatherVC", sender: nil)
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toWeatherVC"{
            let destination = segue.destination as! WeatherViewController
            destination.id = CityListViewController.id
        }
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
