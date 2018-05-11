//
//  ViewController.swift
//  OpenWeather
//
//  Created by Johnathan Saunders on 5/10/18.
//  Copyright © 2018 Johnathan Saunders. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    @IBOutlet var tableView: UITableView!

    var weatherDataArray: Array<Dictionary<String,Any>> = []
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let location = getCurrentLocation()
        getPostalCodeFromCoordinates(latitude: location.latitude,longitude: location.longitude,completionHandler: {
                (postalCode) -> Void in
                getWeatherData(postalCode: postalCode,completionHandler: {
                    (weatherData) -> Void in
                    
                    //doing UI call make sure it calls from the main thread
                    DispatchQueue.main.sync {
                        self.weatherDataArray = (weatherJsonToArray(json:weatherData))
                        self.tableView.reloadData()
                        print("reloaded")
                        print(self.weatherDataArray.count)
                    }
                })
        })
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.weatherDataArray.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //load information into WeatherTableViewCell and return it as cell
        let cell:WeatherTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: "WeatherTableViewCell") as! WeatherTableViewCell
        print("made cell" + String(describing: indexPath))
        let weatherData = weatherDataArray[indexPath.item]
        let mainData = weatherData["main"] as! Dictionary<String,Any>
        print(mainData)
        print(weatherData)
        let weatherDictData = (weatherData["weather"] as! Array<Dictionary<String,Any>>)[0]
        cell.setTempHi(temp: mainData["temp_max"]! as! Double)
        cell.setTempLo(temp: mainData["temp_min"]! as! Double)
        cell.setWeatherDesc(desc: weatherDictData["description"] as! String)
        cell.setDateTime(time: weatherData["dt_txt"] as! String)
        cell.setIcon(iconCode: String(describing: weatherDictData["icon"]))
        return cell

    }
}

