//
//  ViewController.swift
//  Weather Forecast
//
//  Created by Lucky on 20/03/2020.
//  Copyright © 2020 DmitriyYatsyuk. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HourlyForecast.downloadHourlyWeatherForecast { (hourlyforecastArray) in
            
            for data in hourlyforecastArray {
                print("Forecast data: \(data.temp), \(data.date), \(data.weatherIcon))")
            }
        }
    }
}

