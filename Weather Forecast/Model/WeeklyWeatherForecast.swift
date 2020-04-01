//
//  WeeklyWeatherForecast.swift
//  Weather Forecast
//
//  Created by Lucky on 21/03/2020.
//  Copyright © 2020 DmitriyYatsyuk. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire


class WeeklyWeatherForecast {
    
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
    
    class func downloadWeeklyWeatherForecast(location: WeatherLocation,completion: @escaping (_ weatherForecast: [WeeklyWeatherForecast]) -> Void) {
        
        var weeklyForecastUrl: String!
        
        if !location.isCurrentLocation {
            weeklyForecastUrl = String(format: "https://api.weatherbit.io/v2.0/forecast/daily?city=%@,%@&days=7&key=2385fb7ddfba401ca5827ee878911553",
                                    location.city, location.countryCode)
        } else {
            weeklyForecastUrl = currentLocationWeeklyForecastURL
        }
        
        AF.request(weeklyForecastUrl).responseJSON { (response) in
            
            var forecastArray: [WeeklyWeatherForecast] = []
            
            
            
            switch response.result {
                
            case .success(let json):
                
                if let dictionary = json as? Dictionary<String, AnyObject> {
                    if var list = dictionary["data"] as? [Dictionary<String, AnyObject>] {
                        
                        list.remove(at: 0) // remove current day
                        
                        for item in list {
                            let forecast = WeeklyWeatherForecast(weatherDictionary: item)
                            forecastArray.append(forecast)
                        }
                    }
                }
                
                completion(forecastArray)
//                print("Weekly data: ", json)
                
            case .failure(let error):
                completion(forecastArray)
                print("No weekly forecast: ", error)
            }
        }
    }
    
    
    
    
    
}
