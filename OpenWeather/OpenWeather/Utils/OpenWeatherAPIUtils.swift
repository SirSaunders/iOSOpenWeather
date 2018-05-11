//
//  OpenWeatherAPIUtils.swift
//  OpenWeather
//
//  Created by Johnathan Saunders on 5/10/18.
//  Copyright © 2018 Johnathan Saunders. All rights reserved.
//

import Foundation
func getWeatherData(postalCode:String,completionHandler:  @escaping (String) -> Void){
    let headers = [
        "Cache-Control": "no-cache",
    ]
    let request = NSMutableURLRequest(url: NSURL(string: "https://api.openweathermap.org/data/2.5/forecast?zip="+postalCode+",us&appid=" + apiKey)! as URL,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        if (error != nil) {
            print(error)
    
        } else {
            let httpResponse = response as? HTTPURLResponse
            completionHandler(NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as! String)
        }
    })
    
    dataTask.resume()
}
