//
//  BaseViewController+CLLocationManagerDelegate.swift
//  BU
//
//  Created by Aman Kumar on 31/01/21.
//

import Foundation
import CoreLocation
extension BaseViewController:CLLocationManagerDelegate{
    
    //MARK:- Intance Methods
    
    internal func determineCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let mUserLocation:CLLocation = locations.first{
            let lat = mUserLocation.coordinate.latitude
            let long = mUserLocation.coordinate.longitude
            print(lat)
            print(long)
            self.locationManager.stopUpdatingLocation()
            self.locationManager.delegate = nil
            
            self.getLocationCallBack?(lat,long)
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error - locationManager: \(error.localizedDescription)")
    }
}

