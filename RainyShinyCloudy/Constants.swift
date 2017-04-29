//
//  Constants.swift
//  RainyShinyCloudy
//
//  Created by B0nty on 26/04/2017.
//  Copyright © 2017 B0nty. All rights reserved.
//

import Foundation


typealias DownloadComplete = () -> ()   // Alias to check if download from API is complete

let current_url = "http://api.openweathermap.org/data/2.5/weather?&lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&appid=f2d0064647d16b980345ff52d3f8c026"

let forecast_url = "http://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedInstance.latitude!)&lon=\(Location.sharedInstance.longitude!)&cnt=10&appid=f2d0064647d16b980345ff52d3f8c026"


