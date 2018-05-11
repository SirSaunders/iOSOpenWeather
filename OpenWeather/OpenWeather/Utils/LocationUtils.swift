//
//  LocationUtils.swift
//  OpenWeather
//
//  Created by Johnathan Saunders on 5/10/18.
//  Copyright © 2018 Johnathan Saunders. All rights reserved.
//

import Foundation
import CoreLocation

let locManager = CLLocationManager()

/**
 * gets the current location in long and lat
 * @return longitude as double and latitude as double
 */
func getCurrentLocation() -> (longitude:Double,latitude:Double){
    locManager.requestWhenInUseAuthorization()//request location access
    var currentLocation: CLLocation!
    //check if we can get the location
    if( CLLocationManager.authorizationStatus() == CLAuthorizationStatus.authorizedWhenInUse ||
        CLLocationManager.authorizationStatus() != CLAuthorizationStatus.denied){
        currentLocation = locManager.location
        if(currentLocation != nil){
        return  (currentLocation.coordinate.longitude, currentLocation.coordinate.latitude)
        }
    }
        print("could not get location")
        return (40.7,74.0) //error getting current loaction return 0.0, 0.0 as default
}

/*
 * @return the postal as String code given a longitude and latitude
 */
func getPostalCodeFromCoordinates(latitude: Double, longitude: Double,completionHandler:  @escaping (String) -> Void){
    print(latitude)
    print(longitude)
    let location = CLLocation(latitude: latitude, longitude: longitude )
    //use CLGeocoder to get readable location information
    CLGeocoder().reverseGeocodeLocation(location, completionHandler: { (placemarks, error) -> Void in
        var placeMark: CLPlacemark!
        placeMark = placemarks?[0]
        //return postal code
        if(placeMark != nil && placeMark.postalCode != nil){
        completionHandler(placeMark.postalCode!)
        }else{
            completionHandler("10001")
        }
        //todo: error is not handled, could cause a lock up as this function may never complete in some cases.
    })
}
