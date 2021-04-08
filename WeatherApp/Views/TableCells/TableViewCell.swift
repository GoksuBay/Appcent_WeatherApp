//
//  TableViewCell.swift
//  WeatherApp
//
//  Created by Goksubay on 7.04.2021.
//

import UIKit

class TableViewCell: UITableViewCell {


    @IBOutlet weak var cityLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
