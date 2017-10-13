//
//  NewReminderViewController.swift
//  Geofencing
//
//  Created by Hesham Abd-Elmegid on 3/23/17.
//  Copyright © 2017 CareerFoundry. All rights reserved.
//

import UIKit
import MapKit

class NewReminderViewController: UIViewController, UIPopoverPresentationControllerDelegate {
    
    // variables for the data that was input on RadiusViewController
    
    var radius: Double = 0
    var enter: Bool = false
    var exit: Bool = false
    
    //outlets

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    var coordinate: CLLocationCoordinate2D?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let location = RemindersManager.shared.currentLocation {
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpanMake(0.01, 0.01))
            
            mapView.setRegion(region, animated: true)
        } // mapview will focus on the location we obtained from remindersmanager

        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(NewReminderViewController.handleMapTap(_:)))
        mapView.addGestureRecognizer(gestureRecognizer)
    }
    

    @IBAction func cancelButtonTapped(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func doneButtonTapped(_ sender: Any) {
        if let text = textField.text, let coordinate = coordinate  {
            let reminder = Reminder(text: text, coordinate: coordinate, radius: radius, enter: enter, exit: exit)
            RemindersManager.shared.add(reminder: reminder)
            //dismiss(animated: true, completion: nil)
            self.navigationController?.popViewController(animated: true) // pop instead of dismiss :D
        } else {
            let alertController = UIAlertController(title: "Error",
                                                    message: "Please select a map location.",
                                                    preferredStyle: .alert)
            
            let alertAction = UIAlertAction(title: "Okay", style: .default, handler: nil)
            
            alertController.addAction(alertAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    @objc func handleMapTap(_ gestureRecognizer: UIGestureRecognizer) {
        let touchPoint = gestureRecognizer.location(in: mapView)
        let touchMapCoordinate = mapView.convert(touchPoint, toCoordinateFrom: mapView)
        
        let annotation = MKPointAnnotation()
        annotation.coordinate = touchMapCoordinate
        
        mapView.removeAnnotations(mapView.annotations)
        mapView.addAnnotation(annotation)
        
        coordinate = touchMapCoordinate
        
        print(touchMapCoordinate.latitude)
        print(touchMapCoordinate.longitude)
    }
    
    // The show detail segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "RadiusView" {
            if let destinationVC = segue.destination as? RadiusViewController {
                destinationVC.radius = radius
                destinationVC.enter = enter
                destinationVC.exit = exit
            }
          }
    }
}
