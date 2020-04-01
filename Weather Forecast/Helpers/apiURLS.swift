//
//  apiURLS.swift
//  Weather Forecast
//
//  Created by Lucky on 22/03/2020.
//  Copyright © 2020 DmitriyYatsyuk. All rights reserved.
//

import Foundation

let currentLocationURL = "https://api.weatherbit.io/v2.0/current?&lat=\(LocationService.shared.latitude!)&lon=\(LocationService.shared.longitude!)&key=2385fb7ddfba401ca5827ee878911553"
let currentLocationWeeklyForecastURL = "https://api.weatherbit.io/v2.0/forecast/daily?lat=\(LocationService.shared.latitude!)&lon=\(LocationService.shared.longitude!)&days=7&key=2385fb7ddfba401ca5827ee878911553"
let currentLocationHourlyForecastURL = "https://api.weatherbit.io/v2.0/forecast/hourly?lat=\(LocationService.shared.latitude!)&lon=\(LocationService.shared.longitude!)&hours=24&key=2385fb7ddfba401ca5827ee878911553"

