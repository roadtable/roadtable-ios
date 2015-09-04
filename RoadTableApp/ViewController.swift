//
//  ViewController.swift
//  RoadTableApp
//
//  Created by Caleb Francis on 9/2/15.
//  Copyright (c) 2015 theironyard. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController {
    // Mark: Properties
    @IBOutlet weak var startTextField: UITextField!
    @IBOutlet weak var endTextField: UITextField!
    
    var service:RestaurantService!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    // Mark: Actions
    @IBAction func getTablesButtonClicked(sender: UIButton) {
        service = RestaurantService()
        service.createSession(startTextField.text, destination: endTextField.text)
        println(service.settings.api_key)
        performSegueWithIdentifier("nextView", sender: self)
    }
    

 
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

