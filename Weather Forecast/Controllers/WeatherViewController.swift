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
    
    //MARK: Variables
    let userDefaults = UserDefaults.standard
    
    var locationManager: CLLocationManager?
    var currentLocation: CLLocationCoordinate2D!
    
    var allLocations: [WeatherLocation] = []
    var allWeatherViews: [WeatherView] = []
    var allWeatherData: [CityTempData] = []
    
    //MARK: ViewLifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManagerStart()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        locationAuthCheck()
    }
    
    //MARK: Download Weather
    private func getWeather() {
        
        loadLocationsFromUserDefaults()
        createWeatherViews()
        addWeatherToScrollView()
    }
    
    private func createWeatherViews() {
        
        for _ in allLocations {
            allWeatherViews.append(WeatherView())
        }
    }
    
    private func addWeatherToScrollView() {
        
        for i in 0..<allWeatherViews.count {
            
            let weatherView = allWeatherViews[i]
            let location = allLocations[i]
            
            getCurrentWeather(weatherView: weatherView, location: location)
            getWeeklyWeather(weatherView: weatherView, location: location)
            getHourlyWeather(weatherView: weatherView, location: location)
            
            let xPos = self.view.frame.width * CGFloat(i)
            weatherView.frame = CGRect(x: xPos, y: 0,
                                       width: weatherScrollView.bounds.width,
                                       height: weatherScrollView.bounds.height)
            weatherScrollView.addSubview(weatherView)
            weatherScrollView.contentSize.width = weatherView.frame.width * CGFloat(i + 1)
        }
    }
    
    private func getCurrentWeather(weatherView: WeatherView, location: WeatherLocation) {
        
        weatherView.currentWeather = CurrentWeather()
        weatherView.currentWeather.getCurrentWeather(location: location) { (success) in
            weatherView.refreshData()
        }
         
    }
    
    private func getWeeklyWeather(weatherView: WeatherView, location: WeatherLocation) {
        
        WeeklyWeatherForecast.downloadWeeklyWeatherForecast(location: location) { (weatherForecast) in
            weatherView.weeklyWeatherForecastData = weatherForecast
            weatherView.tableView.reloadData()
        }
    }
    
    private func getHourlyWeather(weatherView: WeatherView, location: WeatherLocation) {
        
        HourlyForecast.downloadHourlyWeatherForecast(location: location) { (weatherForecast) in
            weatherView.dailyWeatherForecastData = weatherForecast
            weatherView.hourlyCollectionView.reloadData()
        }
    }
    
    //MARK: Load Locations from User Defaults
    
    private func loadLocationsFromUserDefaults() {
        
        let currentLocation = WeatherLocation(city: "", country: "",
                                              countryCode: "", isCurrentLocation: true)
        
        if let data = userDefaults.value(forKey: "Locations") as? Data {
            allLocations = try! PropertyListDecoder().decode(Array<WeatherLocation>.self, from: data)
            
            allLocations.insert(currentLocation, at: 0)
            
        } else {
            print("No user data in user defaults")
            allLocations.append(currentLocation)
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
                LocationService.shared.latitude = currentLocation.latitude
                LocationService.shared.longitude = currentLocation.longitude
                
                getWeather()
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

