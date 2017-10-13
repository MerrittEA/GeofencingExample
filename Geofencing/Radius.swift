//
//  Radius.swift
//  Geofencing
//
//  Created by PotPie on 9/23/17.
//  Copyright © 2017 CareerFoundry. All rights reserved.
//

import Foundation

// define the new information

class Radius {
    let radius: Double
    let enterSwitch: Bool
    let exitSwitch: Bool
    
    
    init(radius: Double, enterSwitch: Bool, exitSwitch: Bool) {
        self.radius = radius
        self.enterSwitch = enterSwitch
        self.exitSwitch = exitSwitch
    }
}
