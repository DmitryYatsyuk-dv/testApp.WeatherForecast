//
//  ForecastCollectionViewCell.swift
//  Weather Forecast
//
//  Created by Lucky on 21/03/2020.
//  Copyright © 2020 DmitriyYatsyuk. All rights reserved.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {

    //MARK: IBOutlets
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherIconImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func generateCell(weather: HourlyForecast) {
        
        timeLabel.text = weather.date.time()
        weatherIconImageView.image = getWeatherIconFor(weather.weatherIcon)
        tempLabel.text = "\(weather.temp)"
        
        
    }

}
