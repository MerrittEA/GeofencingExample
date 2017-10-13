//
//  Reminder.swift
//  Geofencing
//
//  Created by Hesham Abd-Elmegid on 3/23/17.
//  Copyright © 2017 CareerFoundry. All rights reserved.
//

import UIKit
import MapKit

class Reminder: NSObject, NSCoding {
    // add all the parameters for the geofence
    let text: String
    let coordinate: CLLocationCoordinate2D
    let identifier: String
    let radius: Double //add
    let enter: Bool //add
    let exit: Bool //add
    
    convenience init(text: String, coordinate: CLLocationCoordinate2D, radius: Double, enter: Bool, exit: Bool) {
        self.init(text: text, coordinate: coordinate, identifier: NSUUID().uuidString, radius: radius, enter: enter, exit: exit)
    }
    
    init(text: String, coordinate: CLLocationCoordinate2D, identifier: String, radius: Double, enter: Bool, exit: Bool) {
        self.text = text
        self.coordinate = coordinate
        self.identifier = identifier
        self.radius = radius
        self.enter = enter
        self.exit = exit
    }
    
    required convenience init(coder aDecoder: NSCoder) {
        let text = aDecoder.decodeObject(forKey: "text") as! String
        let longitude = aDecoder.decodeDouble(forKey: "longitude")
        let latitude = aDecoder.decodeDouble(forKey: "latitude")
        let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        let identifier = aDecoder.decodeObject(forKey: "identifier") as! String
        let radius = aDecoder.decodeDouble(forKey: "radius")
        let enter = aDecoder.decodeBool(forKey: "enter")
        let exit = aDecoder.decodeBool(forKey: "exit")
        
        self.init(text: text, coordinate: coordinate, identifier: identifier, radius: radius, enter: enter, exit: exit  )
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(text, forKey: "text")
        aCoder.encode(coordinate.longitude, forKey: "longitude")
        aCoder.encode(coordinate.latitude, forKey: "latitude")
        aCoder.encode(identifier, forKey: "identifier")
        aCoder.encode(radius, forKey: "radius")
        aCoder.encode(enter, forKey: "enter")
        aCoder.encode(exit, forKey: "exit")
    }

}
// everything is added
