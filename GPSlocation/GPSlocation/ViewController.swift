//
//  ViewController.swift
//  GPSlocation
//
//  Created by 김민지 on 5/18/24.
//

// ADD Background Modes
// NSLocationWhenInUseUsageDescription
// NSLocationAlwaysAndWHenInUseUsageDescription

 import UIKit
 import CoreLocation    // 현위치 좌표를 가져오기 위한 모듈
 
class ViewController: UIViewController, CLLocationManagerDelegate {
    private var locationManager: CLLocationManager?
 
    override func viewDidLoad() {
        super.viewDidLoad()
            getUserLocation()
    }

    // initializing the locationManager
    func getUserLocation() {
        locationManager = CLLocationManager()
        locationManager?.requestAlwaysAuthorization()
        locationManager?.delegate = self
        // even it is int the backgroud it will recienve the location updates
 
    }
    
    func authenticationChecker() {
        let access = CLLocationManager.authorizationStatus()
        
        switch access {
        case .restricted, .denied:
            print("Access denied")
        case .authorizedAlways:
            <#code#>
        case .authorizedWhenInUse:
            <#code#>
        @unknown default:
            <#code#>
        }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        authenticationChecker()
    }

    
 
    // periodic updates
     func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
         // if the location is different to the last location => being changed
         if let location = locations.last {
             print("Lat: \(location.coordinate.latitude)  \nLng: \(location.coordinate.longitude)")
        
             // printing two location coordinates latitude, longtitude
         }
     }
    
    
    
    locationManager?.startUpdatingLocation()
    locationManager?.allowsBackgroundLocationUpdates = true
}


