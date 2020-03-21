//
//  WeatherViewController.swift
//  Weather Forecast
//
//  Created by Lucky on 21/03/2020.
//  Copyright © 2020 DmitriyYatsyuk. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {

    
    //MARK: IBOutlets
    @IBOutlet weak var weatherScrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!

    
    
    
    
    //MARK: ViewLifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func viewDidAppear(_ animated: Bool) {
        
        let weatherView = WeatherView()
        
        weatherView.frame = CGRect(x: 0, y: 0, width: weatherScrollView.bounds.width, height: weatherScrollView.bounds.height)
        weatherScrollView.addSubview(weatherView)
        
        weatherView.currentWeather = CurrentWeather()
        weatherView.currentWeather.getCurrentWeather { (success) in
            
            weatherView.refreshData()
        }
    }
}
