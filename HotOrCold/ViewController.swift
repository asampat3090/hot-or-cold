//
//  ViewController.swift
//  HotOrCold
//
//  Created by Anand Sampat on 7/18/15.
//  Copyright © 2015 aks. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {

    let locationManager = CLLocationManager()

    let wormhole = MMWormhole(applicationGroupIdentifier: "group.aks.hotOrCold.wormhole", optionalDirectory: "wormhole")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // Add delegate methods for locationManager
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError!) {
        print("Error: " + error.localizedDescription)
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        CLGeocoder().reverseGeocodeLocation(manager.location!, completionHandler: {
            (placemarks, error) -> Void in
            
            if error != nil
            {
                print("Error: " + error!.localizedDescription)
                return
            }
            
            // Store location information in app group and print result
            let coordinate = manager.location!.coordinate
            let coordinateString = "location = \(coordinate.latitude) \(coordinate.longitude)"
            print(coordinateString)
            
            // Send this information to WatchKit via MMWormhole
            self.wormhole.passMessageObject(coordinateString, identifier: "coordinates")
        })
    }

}

