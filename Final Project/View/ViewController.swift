//
//  ViewController.swift
//  Final Project
//
//  Created by Денис Сторожик on 29.04.2022.
//

import UIKit
import CoreLocation
//CoreLocation
//UITable
//Api request
//CollectionView? (custom sell)
//Coordinator


class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate {
    
    
    

    var currentCoordinates: CLLocation?
    @IBOutlet var mainWeatherTable: UITableView!

    var models = [Weather]()
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLocation()
        mainWeatherTable.delegate = self
        mainWeatherTable.dataSource = self
    }
    
    // LOCATION
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if !locations.isEmpty, currentCoordinates == nil {
            currentCoordinates = locations.first
            locationManager.stopUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
    return
    }
    
    //Location Settings
    func setupLocation() {
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    
    //TABLE
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}

struct Weather {
    
}

