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

class ViewController: UIViewController {
    // Mark: Properties
    @IBOutlet weak var startTextField: UITextField!
    @IBOutlet weak var endTextField: UITextField!
    @IBOutlet weak var logoImageView: UIImageView!
    
    var service:RestaurantService!
    let shareData = ShareData.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SwiftSpinner.hide()
    }
    
    // Mark: Actions
    @IBAction func getTablesButtonClicked(sender: UIButton) {
        service = RestaurantService()
        self.shareData.apiKey = NSUUID().UUIDString
        service.createSession(startTextField.text, destination: endTextField.text)
        
        performSegueWithIdentifier("nextView", sender: self)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

