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
    
    
    //MARK: View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.tableFooterView = UIView()
        
        setupSearchController()
        tableView.tableHeaderView = searchController.searchBar
        
        loadLocationsFromCSV()
    }
    
    private func setupSearchController() {
        
        searchController.searchBar.placeholder = "Enter city or country name"
//        searchController.searchResultsUpdater = false
        searchController.obscuresBackgroundDuringPresentation = true
        definesPresentationContext = true
        
        searchController.searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchController.searchBar.sizeToFit()
        searchController.searchBar.backgroundImage = UIImage()
        
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
                        createLocation(line: line)
                    }
                    i += 1
                }
            }
            
        } catch {
            print("Error reading CSV file, ", error.localizedDescription)
        }
    }
    
    private func createLocation(line: [String]) {
        
        allLocations.append(WeatherLocation(city: line[1], country: line[4], countryCode: line[3], isCurrentLocation: false))
    }
    
}

extension ChooseCityViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredLocations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Save location
        
    }
}
