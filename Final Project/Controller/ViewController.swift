//
//  ViewController.swift
//  Final Project
//
//  Created by Денис Сторожик on 29.04.2022.
//

import UIKit
import CoreLocation



class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //        if section == 0 {
        //            // 1 cell that is collectiontableviewcell
        return 1
    }
    //        // return models count
    //        return models.count
    //    }
    //
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainWeatherTableViewCell.identifier, for: indexPath) as! MainWeatherTableViewCell
        //        cell.configure(with: crashModels[indexPath.row]) // FATAL ERROR while config -> threads?
        return cell}
    
    
    
    
    let locationManager = CLLocationManager()
    private let API_KEY = "07943b31e51725a27912d0471ef4e908"
    private var dataTask: URLSessionDataTask?
    var tempData: [WeatherModel] = [WeatherModel]()
    var models = [Daily]()
    var crashModels = [Daily]()
    var hourlyModels = [Hourly]()
    
    @IBOutlet var mainWeatherTable: UITableView!
    
    @IBOutlet weak var cityName: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var currentTempLabel: UILabel!
    
    @IBOutlet weak var lowTempLabel: UILabel!
    
    @IBOutlet weak var highTempLabel: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        mainWeatherTable.delegate = self
        mainWeatherTable.dataSource = self
        
        mainWeatherTable.register(MainWeatherTableViewCell.nib(), forCellReuseIdentifier: MainWeatherTableViewCell.identifier)
        
        DispatchQueue.global(qos: .background).async { [self] in
            loadWeatherData()
            
        }
        //        DispatchQueue.main.async {
        //        self.mainWeatherTable.reloadData()
        
        
        // UI reload timer
        Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(self.uIReload), userInfo: nil, repeats: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    
    
    
    // UI timer selector
    @objc func uIReload() {
        loadWeatherData()
    }
    
    //DATA MANAGER
    //main 1
    func loadWeatherData() {
        loadDataOrRequestLocationAuth()
    }
    
    //auth - 2
    func loadDataOrRequestLocationAuth() {
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
    
    // make url + request + convert to objects 4
    public func requestAndDecode(forCoordinates coordinates: CLLocationCoordinate2D) {
        guard let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(API_KEY)&units=metric"
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
            let entries = result.daily
            self.models.append(contentsOf: entries)
            self.mainWeatherTable.register(MainWeatherTableViewCell.nib(), forCellReuseIdentifier: MainWeatherTableViewCell.identifier)
            let current = result.current
            
            
            
            self.hourlyModels = result.hourly
            
            //UI
            DispatchQueue.main.async {
                self.cityName.text = result.timezone.deletingSuffix()
                self.descriptionLabel.text = String(result.timezone.deletingPrefix())
                self.currentTempLabel.text = String(Int(result.current.temp)) + "°"
                switch result.current.clouds {
                case 0...50:
                    self.weatherImage.image = UIImage(named: "Clear")
                default:
                    self.weatherImage.image = UIImage(named: "clouds")
                }
                //                self.mainWeatherTable.reloadData()
            }
        }
                                   
        ).resume() }
}







extension ViewController: CLLocationManagerDelegate {
    // stop upd + request 3
    public func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        guard let location = locations.first else { return }
        requestAndDecode(forCoordinates: location.coordinate)
        locationManager.stopUpdatingLocation()
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        loadDataOrRequestLocationAuth()
    }
    func locationManager(
        _ manager: CLLocationManager,
        didFailWithError error: Error
    ) {
        print("Something went wrong: \(error.localizedDescription)")
    }
}

