//
//  RemindersManager.swift
//  Geofencing
//
//  Created by Hesham Abd-Elmegid on 3/23/17.
//  Copyright © 2017 CareerFoundry. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class RemindersManager: NSObject {
    
    // lesson
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation?

    let defaultRadius: Double = 500
    
    // already here
    static let shared = RemindersManager()
    let userDefaultsKey = "RemindersUserDefaultsKey"
        
    func reminders() -> [Reminder] {
        if let remindersData  = UserDefaults.standard.object(forKey: userDefaultsKey) as? Data {
            let reminders = NSKeyedUnarchiver.unarchiveObject(with: remindersData) as! [Reminder]
            
            return reminders
        }
        
        return [Reminder]()
    }
    
    func add(reminder: Reminder) {
        var reminders = self.reminders()
        reminders.append(reminder)
        
        let remindersData = NSKeyedArchiver.archivedData(withRootObject: reminders)
        UserDefaults.standard.set(remindersData, forKey: userDefaultsKey)
        UserDefaults.standard.synchronize()
        
        //lesson
        let region = CLCircularRegion(center: reminder.coordinate, radius: reminder.radius, identifier: reminder.identifier)
        
        
        //Switch logic
        
        if reminder.enter {
            region.notifyOnEntry = true
        } else {
            region.notifyOnEntry = false
        }
        
        if reminder.exit {
            region.notifyOnExit = true
        } else {
            region.notifyOnExit = false
        }
        
        
        locationManager.startMonitoring(for: region)
    }
    
    func delete(reminderAtIndex index: Int) {
        var reminders = self.reminders()
        // lesson
        let reminderIdentifier = reminders[index].identifier
        
        for region in locationManager.monitoredRegions {
            if let circularRegion = region as? CLCircularRegion, circularRegion.identifier ==
                reminderIdentifier {
                locationManager.stopMonitoring(for: circularRegion)
            }
        }
        
        
        reminders.remove(at: index)
        
        let remindersData = NSKeyedArchiver.archivedData(withRootObject: reminders)
        UserDefaults.standard.set(remindersData, forKey: userDefaultsKey)
        UserDefaults.standard.synchronize()
    }
    
    func updateLocation() {
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.startUpdatingLocation()
    }
    
    // functions for the alerts
    
    func showAlert(reminder: Reminder) {
        print(reminder.text)
        let alertController = UIAlertController(title: "Reminder", message: reminder.text, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        
        alertController.addAction(alertAction)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    func showOnExit(reminder: Reminder) {
        print(reminder.text)
        
        let alertController = UIAlertController(title: "Reminder", message: reminder.text, preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
        
        alertController.addAction(alertAction)
        
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
}

extension RemindersManager: CLLocationManagerDelegate { // saves location from user to currentLocation & implements CLLDelegate
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error: " + error.localizedDescription)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.last
    }
    // alert on enter
    func locationManager(_ manager: CLLocationManager, didEnterRegion region: CLRegion) {
        for reminder in reminders() {
            if reminder.identifier == region.identifier {
                showAlert(reminder: reminder)
            }
        }
    }
    
    // alert on exit
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        for reminder in reminders() {
            if reminder.identifier == region.identifier {
                showOnExit(reminder: reminder)
            }
        }
    }
}
