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
    let request = NSMutableURLRequest(url: NSURL(string: "https://api.openweathermap.org/data/2.5/forecast?zip="+postalCode+",us&units=imperial&appid=" + apiKey)! as URL,
                                      cachePolicy: .useProtocolCachePolicy,
                                      timeoutInterval: 10.0)
    request.httpMethod = "GET"
    request.allHTTPHeaderFields = headers
    let session = URLSession.shared
    let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
        if (error != nil) {
            print(error)
    
        } else {
            completionHandler(NSString(data: data!, encoding: String.Encoding.utf8.rawValue) as! String)
        }
    })
    dataTask.resume()
}

/*
 Given the json retrived from openweathermap.org as a string this method will
 @return the list of 5 days as an array<any>
 */
func weatherJsonToArray(json:String) -> Array<Dictionary<String, AnyObject>>{
    let data = json.data(using: .utf8)!
    do {//converts json string to JsonObject
         let jsonArray = try JSONSerialization.jsonObject(with: data, options : [])
     if let dictionary = jsonArray as? [String: Any] {
        return (dictionary["list"] as! Array<Dictionary<String, AnyObject>> ) // gets list of weather for next 5days
     }else{
        print("nope")
        }
    } catch let error as NSError {
        print(error)
    }
    return Array() //return empty arry, converting json to array failed
}


