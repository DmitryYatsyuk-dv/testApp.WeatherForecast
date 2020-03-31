//
//  WeatherViewController.swift
//  Weather Forecast
//
//  Created by Lucky on 21/03/2020.
//  Copyright © 2020 DmitriyYatsyuk. All rights reserved.
//

import UIKit
import CoreLocation

class WeatherViewController: UIViewController {

    
    //MARK: IBOutlets
    @IBOutlet weak var weatherScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!

    var weatherLocation: WeatherLocation!
    
    //MARK: Variables
    var locationManager: CLLocationManager?
    var currentLocation: CLLocationCoordinate2D!
    
    //MARK: ViewLifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManagerStart()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
//        let weatherView = WeatherView()
//        weatherView.frame = CGRect(x: 0, y: 0,
//                                   width: weatherScrollView.bounds.width,
//                                   height: weatherScrollView.bounds.height)
//        weatherScrollView.addSubview(weatherView)
//
//        weatherLocation = WeatherLocation(city: "Moscow", country: "Russian Federation", countryCode: "RU", isCurrentLocation: false)
//
//        getCurrentWeather(weatherView: weatherView)
//        getWeeklyWeather(weatherView: weatherView)
//        getHourlyWeather(weatherView: weatherView)
//
    }
    
    //MARK: Download Weather
    private func getCurrentWeather(weatherView: WeatherView) {
        
        weatherView.currentWeather = CurrentWeather()
        weatherView.currentWeather.getCurrentWeather(location: weatherLocation) { (success) in
            weatherView.refreshData()
        }
         
    }
    
    private func getWeeklyWeather(weatherView: WeatherView) {
        
        WeeklyWeatherForecast.downloadWeeklyWeatherForecast(location: weatherLocation) { (weatherForecast) in
            weatherView.weeklyWeatherForecastData = weatherForecast
            weatherView.tableView.reloadData()
        }
    }
    
    private func getHourlyWeather(weatherView: WeatherView) {
        
        HourlyForecast.downloadHourlyWeatherForecast(location: weatherLocation) { (weatherForecast) in
            weatherView.dailyWeatherForecastData = weatherForecast
            weatherView.hourlyCollectionView.reloadData()
        }
    }
    
    //MARK: LocationManager
    private func locationManagerStart() {
        
        if locationManager == nil {
            locationManager = CLLocationManager()
            locationManager!.desiredAccuracy = kCLLocationAccuracyBest
            locationManager!.requestWhenInUseAuthorization()
            locationManager!.delegate = self
        }
        locationManager!.startMonitoringSignificantLocationChanges()
    }
    
    private func locationManagerStop() {
     
        if locationManager != nil {
            
            locationManager!.stopMonitoringSignificantLocationChanges()
        }
    }
    
    private func locationAuthCheck() {
        
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            
            currentLocation = locationManager!.location?.coordinate
            
            if currentLocation != nil {
                // Set our coordinates
            } else {
                locationAuthCheck()
            }
        } else {
            locationManager?.requestWhenInUseAuthorization()
            locationAuthCheck()
        }
    }
}

extension WeatherViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Fail to get location, \(error.localizedDescription)")
    }
}

