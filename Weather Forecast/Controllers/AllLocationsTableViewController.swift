//
//  AllLocationsTableViewController.swift
//  Weather Forecast
//
//  Created by Lucky on 22/03/2020.
//  Copyright © 2020 DmitriyYatsyuk. All rights reserved.
//

import UIKit

class AllLocationsTableViewController: UITableViewController {

    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)

        return cell
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
        print("We have added new Location", newLocation.country, newLocation.city)
    }
    
    
    
}
