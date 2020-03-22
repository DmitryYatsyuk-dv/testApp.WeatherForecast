//
//  WeatherView.swift
//  Weather Forecast
//
//  Created by Lucky on 21/03/2020.
//  Copyright © 2020 DmitriyYatsyuk. All rights reserved.
//

import UIKit


class WeatherView: UIView {
        
    //MARK: IBOutlets
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var weatherInfoLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var bottomContainer: UIView!
    @IBOutlet weak var hourlyCollectionView: UICollectionView!
    @IBOutlet weak var infoCollectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    //MARK: Vars
    var currentWeather: CurrentWeather!
    
    var weeklyWeatherForecastData: [WeeklyWeatherForecast] = []
    var dailyWeatherForecastData: [HourlyForecast] = []
    var weatherInfoData: [WeatherInfo] = []
    
    //MARK: Inits
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        mainInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        mainInit()
    }
    
    private func mainInit() {
        
        Bundle.main.loadNibNamed("WeatherView", owner: self, options: nil)
        addSubview(mainView)
        mainView.frame = self.bounds
        mainView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        
        setupTableView()
        setupHourlyCollectionView()
        setupInfocollectionView()
    }
    
    private func setupTableView() {
        
        tableView.register(UINib(nibName: "WeatherTableViewCell", bundle: Bundle.main), forCellReuseIdentifier: "Cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        
    }
    
    private func setupHourlyCollectionView() {
        
        hourlyCollectionView.register(UINib(nibName: "ForecastCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "Cell")
        hourlyCollectionView.dataSource = self
    }
    
    private func setupInfocollectionView() {
        
        infoCollectionView.register(UINib(nibName: "InfoCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "Cell")
        infoCollectionView.dataSource = self
    }
    
    func refreshData() {
        setupCurrentWeather()
        setupWeatherInfo()
        infoCollectionView.reloadData()
    }
    
    private func setupCurrentWeather() {
        
        cityNameLabel.text = currentWeather.city
        dateLabel.text = "Today, \(currentWeather.date.shortDate())"
        temperatureLabel.text = "\(currentWeather.currentTemp)"
        weatherInfoLabel.text = currentWeather.weatherType
    }
    
    private func setupWeatherInfo() {
        
        let windInfo = WeatherInfo(infoText: String(format: "%.1f m/sec", currentWeather.windSpeed), nameText: nil, image: getWeatherIconFor("wind"))
        let humidityInfo = WeatherInfo(infoText: String(format: "%.0f ", currentWeather.humidity), nameText: nil, image: getWeatherIconFor("humidity"))
        let pressureInfo = WeatherInfo(infoText: String(format: "%.0f mb", currentWeather.pressure), nameText: nil, image: getWeatherIconFor("pressure"))
        let visibilityInfo = WeatherInfo(infoText: String(format: "%.0f km", currentWeather.visibility), nameText: nil, image: getWeatherIconFor("visibility"))
        let feelsLikeInfo = WeatherInfo(infoText: String(format: "%.1f˚С", currentWeather.feelsLike), nameText: nil, image: getWeatherIconFor("feelslike"))
        let uvInfo = WeatherInfo(infoText: String(format: "%.1f", currentWeather.uv), nameText: "UV Index", image: nil)
        let sunriseInfo = WeatherInfo(infoText: currentWeather.sunrise, nameText: nil, image: getWeatherIconFor("sunrise"))
        let sunsetInfo = WeatherInfo(infoText: currentWeather.sunset, nameText: nil, image: getWeatherIconFor("sunset"))
        
        weatherInfoData = [windInfo,humidityInfo, pressureInfo,
                           visibilityInfo, feelsLikeInfo, uvInfo,
                           sunriseInfo, sunsetInfo]
        
        
    }
}

extension WeatherView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return weeklyWeatherForecastData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! WeatherTableViewCell
        
        cell.generateCell(forecast: weeklyWeatherForecastData[indexPath.row])
        
        return cell
    }
}

extension WeatherView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == hourlyCollectionView {
            
            return dailyWeatherForecastData.count
        } else {
            return weatherInfoData.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == hourlyCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! ForecastCollectionViewCell
            
            cell.generateCell(weather: dailyWeatherForecastData[indexPath.row])
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! InfoCollectionViewCell
            
            cell.generateCell(weatherInfo: weatherInfoData[indexPath.row])
            return cell
        }
    }
}

