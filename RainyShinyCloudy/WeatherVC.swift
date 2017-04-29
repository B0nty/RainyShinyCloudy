//
//  WeatherVC.swift
//  RainyShinyCloudy
//
//  Created by B0nty on 25/04/2017.
//  Copyright © 2017 B0nty. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class WeatherVC: UIViewController, UITableViewDelegate, UITableViewDataSource,CLLocationManagerDelegate  {
    
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var placeLbl: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentTypeLbl: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    
    var currentWeather: CurrentWeather!
    var forecast: Forecast!
    var forecasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest // Set user loacation accurancy
        locationManager.requestWhenInUseAuthorization() //Use location only when app is in use
        locationManager.startMonitoringSignificantLocationChanges() // Check when app load if user location was changed from previouse load
        
        tableView.delegate = self
        tableView.dataSource = self
        
        currentWeather = CurrentWeather()

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loacationAuthStatus()
    }
    
    
    // Check if authorization of location is confirmed by the user otherwise ask user for authorization
    // If auth si granted then set longitude and latitude to singleton Class Location
    func loacationAuthStatus() {
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse {
            currentLocation = locationManager.location
            Location.sharedInstance.latitude = currentLocation.coordinate.latitude
            Location.sharedInstance.longitude = currentLocation.coordinate.longitude
            currentWeather.downloadWeatherDetails {
                self.dowloadForecastData {
                    self.updateWeatherUI()
                }
            }
        } else {
            locationManager.requestWhenInUseAuthorization()
            loacationAuthStatus()
        }
    }
    
    //Download Data to tableview UI
    func dowloadForecastData(completed: @escaping DownloadComplete) {
        Alamofire.request(forecast_url).responseJSON { response in
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    for object in list {
                        let forecast = Forecast(weatherDict: object)
                        self.forecasts.append(forecast)
                    }
                    self.forecasts.remove(at: 0)
                    self.tableView.reloadData()
                }
            }
            completed()
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return forecasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "weatherCell", for: indexPath) as? WeatherCell {
            let forecast = forecasts[indexPath.row]
            
            cell.configureCell(forecast: forecast)
             return cell
        } else {
            return WeatherCell()
        }
        
    }
    
    // Func to update UI with data
    
    func updateWeatherUI() {
        dateLbl.text = currentWeather.date
        tempLbl.text = "\(round(currentWeather.currentTemp))°"
        currentTypeLbl.text = currentWeather.weatherType
        placeLbl.text = currentWeather.cityName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
        
    }
    
}

