//
//  GlobalHelpers.swift
//  Weather Forecast
//
//  Created by Lucky on 20/03/2020.
//  Copyright © 2020 DmitriyYatsyuk. All rights reserved.
//

import Foundation


func currentDateFromUnix(unixDate: Double?) -> Date {
    
    if unixDate != nil {
        return Date(timeIntervalSince1970: unixDate!)
    } else {
        return Date()
    }
}
