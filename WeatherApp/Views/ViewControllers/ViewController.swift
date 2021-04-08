//
//  ViewController.swift
//  WeatherApp
//
//  Created by Goksubay on 6.04.2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private var locationTableViewModel : LocationTableViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
        
        GPSService.shared.getUserLocation { (location) in
            Location.shared.latitute = String(location.coordinate.latitude)
            Location.shared.longitute = String(location.coordinate.longitude)
            
            WebService.shared.getLocations(latt_long: Location.shared.latitute + "," + Location.shared.longitute) { (locations, error) in
                if let location = locations{
                    self.locationTableViewModel=LocationTableViewModel(locationList: location, cityList: location)
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                    
                }
            }
        }
        // Do any additional setup after loading the view.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return locationTableViewModel == nil ? 0 : self.locationTableViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainCell", for: indexPath) as! MainTableViewCell
        let locationViewModel = self.locationTableViewModel.atIndexPath(indexPath.row)
        cell.cityLabel.text = locationViewModel.title
        cell.typeLabel.text = locationViewModel.locationType
        
        return cell
    }
    



}

