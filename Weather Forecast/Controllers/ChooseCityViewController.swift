//
//  ChooseCityViewController.swift
//  Weather Forecast
//
//  Created by Lucky on 22/03/2020.
//  Copyright © 2020 DmitriyYatsyuk. All rights reserved.
//

import UIKit

class ChooseCityViewController: UIViewController {

    //MARK: IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: Variables
    var allLocations: [WeatherLocation] = []
    var filteredLocations: [WeatherLocation] = []
    
    let searchController = UISearchController(searchResultsController: nil)
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadLocationsFromCSV()
        
    }
    
    //MARK: Get Locations
    private func loadLocationsFromCSV() {
        
        if let path = Bundle.main.path(forResource: "locations", ofType: "csv") {
            
            parseCSVat(url: URL(fileURLWithPath: path))
        }
    }
    
    private func parseCSVat(url: URL) {
        
        do {
            
            let data = try Data(contentsOf: url)
            let dataEncoded = String(data: data, encoding: .utf8)
            
            if let dataArray = dataEncoded?.components(separatedBy: "\n").map({ $0.components(separatedBy: ",")}) {
                
                var i = 0
                
                for line in dataArray {
                    
                    if line.count > 2 && i != 0 {
                        
                    }
                    i += 1
                }
            }
            
        } catch {
            print("Error reading CSV file, ", error.localizedDescription)
        }
        
    }
    
}
