//
//  WeatherService.swift
//  Final Project
//
//  Created by Денис Сторожик on 01.05.2022.
//

import Foundation
import CoreLocation


public final class WeatherService: NSObject {
    
    private let locationManager = CLLocationManager()
    private let API_KEY = "07943b31e51725a27912d0471ef4e908"
    private var dataTask: URLSessionDataTask?
    
    public override init() {
        super.init()
        locationManager.delegate = self
    }
    
    //main 1
    func loadWeatherData() {
        loadDataOrRequestLocationAuth()
    }
    
    // make url + request + convert to objects 4
    private func makeFinalUrl(forCoordinates coordinates: CLLocationCoordinate2D) {
        guard let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(API_KEY)"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        
        URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: { data, response, error in
            
            // Validation
            guard let data = data, error == nil else {
                print("something went wrong")
                return
            }
            
            // Convert data to objects
            var json: WeatherModel?
            do {
                json = try JSONDecoder().decode(WeatherModel.self, from: data)
            }
            catch {
                print("error: \(error)")
            }
            
            guard let result = json else {
                return
            }
            
            let entries = result.timezone.description
            print(entries)
            
            //
            //              self.models.append(contentsOf: entries)
            //
            //              let current = result.currently
            //              self.current = current
            //
            //              self.hourlyModels = result.hourly.data
            //
            //              // Update user interface
            //              DispatchQueue.main.async {
            //                  self.table.reloadData()
            //
            //                  self.table.tableHeaderView = self.createTableHeader()
            //              }
            
        }).resume()
    }
    
    
    //auth - 2
    private func loadDataOrRequestLocationAuth() {
        switch locationManager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
        case .denied, .restricted:
            //      completionHandler?(nil, LocationAuthError())
            break
        default:
            locationManager.requestWhenInUseAuthorization()
        }
    }
}

extension WeatherService: CLLocationManagerDelegate {
    // stop upd + request 3
    public func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.first else { return }
        makeFinalUrl(forCoordinates: location.coordinate)
        locationManager.stopUpdatingLocation()
    }
    
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        loadDataOrRequestLocationAuth()
    }
    public func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print("Something went wrong: \(error.localizedDescription)")
    }
}



public struct LocationAuthError: Error {}
