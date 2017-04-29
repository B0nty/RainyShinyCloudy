//
//  WeatherCell.swift
//  RainyShinyCloudy
//
//  Created by B0nty on 27/04/2017.
//  Copyright © 2017 B0nty. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLbl: UILabel!
    @IBOutlet weak var weatherLbl: UILabel!
    @IBOutlet weak var highTempLbl: UILabel!
    @IBOutlet weak var lowTempLbl: UILabel!

    func configureCell(forecast: Forecast) {
        
        lowTempLbl.text = "\(forecast.lowTemp)"
        highTempLbl.text = "\(forecast.highTemp)"
        weatherLbl.text = forecast.weatherType
        dayLbl.text = forecast.date
        weatherIcon.image = UIImage(named: forecast.weatherType)
    }
    
    
 
}
