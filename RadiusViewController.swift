//
//  RadiusViewController.swift
//  Geofencing
//
//  Created by PotPie on 9/23/17.
//  Copyright © 2017 CareerFoundry. All rights reserved.
//

import UIKit
//handle the new information

class RadiusViewController: UIViewController {
    
    //RadiusViewController.delegate = self // I don't understand what is happening here
    
    //How do I pass this information to the other controller?

    // variables for passing the info 
    
    var radius: Double = 0
    var exit: Bool = false
    var enter: Bool = false
    
    var Radius: Radius?
    
    //outlets User input of data
    
    
    @IBOutlet weak var exitSwitch: UISwitch!
    @IBOutlet weak var enterSwitch: UISwitch!
    @IBOutlet weak var radiusInputField: UITextField!
    
    
    // actions
    
    
    @IBAction func savePressed(_ sender: UISwitch) {
        
        if enterSwitch.isOn {
            enter = true
        } else {
            enter = false
        }
        
        if exitSwitch.isOn {
            exit = true
        } else {
            exit = false
        }
        dismiss(animated: true, completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // loading the popover with set data
        
        radiusInputField.text = "50"
        enterSwitch.isOn = false
        exitSwitch.isOn = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
