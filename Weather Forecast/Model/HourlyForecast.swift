//
//  HourlyForecast.swift
//  Weather Forecast
//
//  Created by Lucky on 20/03/2020.
//  Copyright © 2020 DmitriyYatsyuk. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class HourlyForecast {
    
    private var _date: Date!
    private var _temp: Double!
    private var _weatherIcon: String!
    
    var date: Date {
        if _date == nil {
            _date = Date()
        }
        return _date
    }
    var temp: Double {
        if _temp == nil {
            _temp = 0.0
        }
        return _temp
    }
    var weatherIcon: String {
        if _weatherIcon == nil {
            _weatherIcon = ""
        }
        return _weatherIcon
    }
    
    
    init(weatherDictionary: Dictionary<String, AnyObject>) {
        
        let json = JSON(weatherDictionary)
        
        self._temp = json["temp"].double
        self._date = currentDateFromUnix(unixDate: json["ts"].double)
        self._weatherIcon = json["weather"]["icon"].stringValue
    }
    
    
    class func downloadHourlyWeatherForecast(completion: @escaping (_ hourlyForecast: [HourlyForecast]) -> Void) {
        
        let hourlyForecastUrl = "https://api.weatherbit.io/v2.0/forecast/hourly?city=Moscow,RU&hours=24&key=b342eeba887043fc961e0549b91d3038"
        
        AF.request(hourlyForecastUrl).responseJSON { (response) in
            
            var forecastArray: [HourlyForecast] = []
            
            switch response.result {
                
            case .success(let json):
                //                print("JSON: ", json)
                if let dictionary = json as? Dictionary<String, AnyObject> {
                    if let list = dictionary["data"] as? [Dictionary<String, AnyObject>] {
                        
                        for item in list {
                            let forecast = HourlyForecast(weatherDictionary: item)
                            forecastArray.append(forecast)
                            
                        }
                    }
                }
                completion(forecastArray)
                
            case .failure(let error):
                completion(forecastArray)
                print("No forecast data: ", error)
            }
        }
    }
}
