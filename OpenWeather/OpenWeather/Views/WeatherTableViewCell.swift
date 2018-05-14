//
//  weatherTableViewCell.swift
//  OpenWeather
//
//  Created by Johnathan Saunders on 5/10/18.
//  Copyright © 2018 Johnathan Saunders. All rights reserved.
//

import Foundation
import UIKit
class WeatherTableViewCell: UITableViewCell {
    @IBOutlet var icon: UIImageView!
    @IBOutlet var dateTime: UILabel!
    @IBOutlet var weatherDesc: UILabel!
    @IBOutlet var tempHi: UILabel!
    @IBOutlet var tempLo: UILabel!
    
    func setTempHi(temp:Double)  {
        tempHi.text = String(Int(temp))+"ºF"
    }
    func setTempLo(temp:Double)  {
        tempLo.text = String(Int(temp))+"ºF"
    }
    func setWeatherDesc(desc:String)  {
        weatherDesc.text = desc
    }
    func setDateTime(time:String)  {
        dateTime.text = time
    }
    
    func setIcon(iconCode: String){
        //hacky fix for optionals
        var iconHackyFix = ""
        iconHackyFix = iconCode.replacingOccurrences(of:"Optional(",with:"")
        iconHackyFix = iconHackyFix.replacingOccurrences(of:")",with:"")
        let urlString = "https://openweathermap.org/img/w/"+iconHackyFix+".png"
        print(urlString)
        if let url = URL(string: urlString) {
            icon.contentMode = .scaleAspectFit
            downloadImage(url: url)
        }
    }
    
    
    func downloadImage(url: URL) {
        print("Download Started")
        getDataFromUrl(url: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() {
                self.icon.image = UIImage(data: data)
            }
        }
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
}
