//
//  MapInterfaceController.swift
//  HotOrCold
//
//  Created by Anand Sampat on 7/18/15.
//  Copyright © 2015 aks. All rights reserved.
//

import WatchKit
import Foundation

class MapInterfaceController: WKInterfaceController {

    @IBOutlet var map: WKInterfaceMap!
    @IBOutlet var coordsLabel: WKInterfaceLabel!
    
    let wormhole = MMWormhole(applicationGroupIdentifier: "group.aks.hotOrCold.wormhole", optionalDirectory: "wormhole")

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        let currentLoc = context as! CLLocationCoordinate2D // Pull currentLoc into this controller
        
        // Add current location to map
        
//        let location = CLLocationCoordinate2D(latitude: 37, longitude: -122)
        let coordinateSpan = MKCoordinateSpan(latitudeDelta: 10, longitudeDelta: 10)
        map.addAnnotation(currentLoc, withPinColor: WKInterfaceMapPinColor.Purple)
        map.setRegion(MKCoordinateRegion(center:currentLoc, span: coordinateSpan))
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
        
        // Read from wormhole to see if any messages have been passed
        wormhole.listenForMessageWithIdentifier("coordinates", listener: {(messageObject) -> Void in
            if let message: AnyObject = messageObject {
                self.coordsLabel.setText(message as! String)
            }
        })
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
