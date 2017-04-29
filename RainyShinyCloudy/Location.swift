//
//  Location.swift
//  RainyShinyCloudy
//
//  Created by B0nty on 27/04/2017.
//  Copyright © 2017 B0nty. All rights reserved.
//

import CoreLocation


class Location {
    static var sharedInstance = Location()
    
    private init() {}
    
    var latitude: Double!
    var longitude: Double!
    
}
