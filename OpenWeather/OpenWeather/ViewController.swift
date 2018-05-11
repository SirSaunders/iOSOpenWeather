//
//  ViewController.swift
//  OpenWeather
//
//  Created by Johnathan Saunders on 5/10/18.
//  Copyright © 2018 Johnathan Saunders. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var weatherDataArray: [Dictionary<String,Any>]? = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let location = getCurrentLocation()
        getPostalCodeFromCoordinates(latitude: location.latitude,longitude: location.longitude,completionHandler: {
                (postalCode) -> Void in
                getWeatherData(postalCode: postalCode,completionHandler: {
                    (weatherData) -> Void in
                    self.weatherDataArray = weatherJsonToArray(json:weatherData) as! [Dictionary<String, Any>]
                })
        })
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

