//
//  apiURLS.swift
//  Weather Forecast
//
//  Created by Lucky on 22/03/2020.
//  Copyright © 2020 DmitriyYatsyuk. All rights reserved.
//

import Foundation

let currentLocationURL = "https://api.weatherbit.io/v2.0/current?&lat=\(LocationService.shared.latitude!)&lon=\(LocationService.shared.longitude!)&key=b342eeba887043fc961e0549b91d3038"
let currentLocationWeeklyForecastURL = "https://api.weatherbit.io/v2.0/forecast/daily?lat=\(LocationService.shared.latitude!)&lon=\(LocationService.shared.longitude!)&days=7&key=b342eeba887043fc961e0549b91d3038"
let currentLocationHourlyForecastURL = "https://api.weatherbit.io/v2.0/forecast/hourly?lat=\(LocationService.shared.latitude!)&lon=\(LocationService.shared.longitude!)&hours=24&key=b342eeba887043fc961e0549b91d3038"

