//
//  InterfaceController.swift
//  HotOrCold WatchKit Extension
//
//  Created by Anand Sampat on 7/18/15.
//  Copyright © 2015 aks. All rights reserved.
//

import WatchKit
import Foundation

class InterfaceController: WKInterfaceController, CLLocationManagerDelegate {
    
    struct Place {
        let name: String
        let id: Int
        let lat: Double // range 0 to +/- 90
        let lng: Double // range 0 to +/- 180
    }
    
    let locationManager = CLLocationManager()
    
    let currentLoc = CLLocationCoordinate2D()
    
    func distanceBetweenPoints(origin:CLLocationCoordinate2D, destination:CLLocationCoordinate2D) -> Double {
        let earth_rad = 6372797.6 // earth radius in meters
        
        let lat1 = origin.latitude * M_PI / 180
        let lon1 = origin.longitude * M_PI / 180
        
        let lat2 = destination.latitude * M_PI / 180
        let lon2 = destination.longitude * M_PI / 180
        
        // Calculate distance between two points
        let dlon = lon2 - lon1
        let dlat = lat2 - lat1
        let a = pow((sin(dlat/2)),2) + cos(lat1) * cos(lat2) * pow((sin(dlon/2)),2)
        let c = 2 * atan2( sqrt(a), sqrt(1-a) )
        return earth_rad * c
    }
    
    func createCoordsFromPlace(place: Place) -> CLLocationCoordinate2D{
        // Create CLLocationCoordinate2D object for lat/long
        let momentaryLatitude = place.lat
        let momentaryLongitude = place.lng
        let coordinates = CLLocationCoordinate2D(latitude: momentaryLatitude as
            CLLocationDegrees, longitude: momentaryLongitude as CLLocationDegrees)
        return coordinates
    }

    
    @IBAction func startGame() {
        
        let examplePlace = Place(name: "example", id: 1, lat: -90.345, lng: -100.345)
        let placeCoords = createCoordsFromPlace(examplePlace)
        
        // Get the current location and set it
        
        
        
    }
    
    // Function to pass current location to MapInterfaceController
    func contextForSegueWithIdentifier(segueIdentifier: String) -> CLLocationCoordinate2D? {
        // Return data to be accessed
        return self.currentLoc
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
