//
//  ViewController.swift
//  RoadTableApp
//
//  Created by Caleb Francis on 9/2/15.
//  Copyright (c) 2015 theironyard. All rights reserved.
//

import UIKit
import Alamofire
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    // Mark: Properties
    @IBOutlet weak var startTextField: UITextField!
    @IBOutlet weak var endTextField: UITextField!
    @IBOutlet weak var logoImageView: UIImageView!
    
    var service:RestaurantService!
    let shareData = ShareData.sharedInstance
    let locManager = CLLocationManager()
    var locationString:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SwiftSpinner.hide()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        if self.locManager.location != nil {
            var lat = self.locManager.location.coordinate.latitude
            var long = self.locManager.location.coordinate.longitude
            self.locationString = "\(lat),\(long)"
        }
        
    }
    
    // Mark: Actions
    @IBAction func getTablesButtonClicked(sender: UIButton) {
        service = RestaurantService()
        self.shareData.apiKey = NSUUID().UUIDString
        
        if self.locManager.location == nil {
            service.createSession(startTextField.text, destination: endTextField.text)
        } else {
            if startTextField.text.lowercaseString == "current location" {
                service.createSession(locationString, destination: endTextField.text)
            } else {
                service.createSession(startTextField.text, destination: endTextField.text)
            }
        }
        performSegueWithIdentifier("nextView", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

