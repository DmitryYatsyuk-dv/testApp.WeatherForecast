//
//  AllLocationsTableViewController.swift
//  Weather Forecast
//
//  Created by Lucky on 22/03/2020.
//  Copyright © 2020 DmitriyYatsyuk. All rights reserved.
//

import UIKit

protocol AllLocationsTableViewControllerDelegate {
    func didChooseLocation(atIndex: Int, shouldRefresh: Bool)
}

class AllLocationsTableViewController: UITableViewController {
    
    //MARK: Variables
    let userDefaults = UserDefaults.standard
    var savedLocations: [WeatherLocation]?
    var weatherData: [CityTempData]?
    
    var delegate: AllLocationsTableViewControllerDelegate?
    var shouldRefresh = false
    
    //MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadFromUserDefaults()
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return weatherData?.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MainWeatherTableViewCell
        
        if weatherData != nil {
            cell.generateCell(weatherData: weatherData![indexPath.row])
        }
        return cell
    }
    
    //MARK: TableViewDelegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
        tableView.deselectRow(at: indexPath, animated: true)
        delegate?.didChooseLocation(atIndex: indexPath.row, shouldRefresh: shouldRefresh)
        self.dismiss(animated: true, completion: nil)
        
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        return indexPath.row != 0
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let locationToDelete = weatherData?[indexPath.row]
            weatherData?.remove(at: indexPath.row)
            
            removeSavedLocation(location: locationToDelete!.city)
            tableView.reloadData()
        }
    }
    
    private func removeSavedLocation(location: String) {
        
        if savedLocations != nil {
            for i in 0..<savedLocations!.count {
                
                let tempLocation = savedLocations![i]
                if tempLocation.city == location {
                    savedLocations!.remove(at: i)
                    saveNewLocationToUserDefaults()
                    return
                }
            }
        }
    }
    
    private func saveNewLocationToUserDefaults() {
        
        shouldRefresh = true
        userDefaults.set(try? PropertyListEncoder().encode(savedLocations!), forKey: "Locations")
        userDefaults.synchronize()
    }
    
    //MARK: UserDefaults
    private func loadFromUserDefaults() {
        
        if let data = userDefaults.value(forKey: "Locations") as? Data {
            savedLocations = try? PropertyListDecoder().decode(Array<WeatherLocation>.self, from: data)
        }
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "chooseLocationSegue" {
            let vc = segue.destination as! ChooseCityViewController
            vc.delegate = self
        }
    }
}

extension AllLocationsTableViewController: ChooseCityViewControllerDelegate {
    
    func didAdd(newLocation: WeatherLocation) {
        
        shouldRefresh = true
        weatherData?.append(CityTempData(city: newLocation.city, temp: 0.0))
        tableView.reloadData()
    }
    
    
    
}
