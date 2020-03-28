//
//  WeatherLocation.swift
//  Weather Forecast
//
//  Created by Lucky on 22/03/2020.
//  Copyright © 2020 DmitriyYatsyuk. All rights reserved.
//

import Foundation

struct WeatherLocation: Codable, Equatable {
    
    var city: String!
    var country: String!
    var countryCode: String!
    var isCurrentLocation: Bool!
}

