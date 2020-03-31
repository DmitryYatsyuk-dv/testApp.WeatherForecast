//
//  LocationService.swift
//  Weather Forecast
//
//  Created by Lucky on 31/03/2020.
//  Copyright © 2020 DmitriyYatsyuk. All rights reserved.
//

import Foundation

class LocationService {
    
    static var shared = LocationService()
    
    var longitude: Double!
    var latitude: Double!
}
