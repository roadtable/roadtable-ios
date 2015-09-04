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
    let shareData = ShareData.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()  
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
    
//    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
//        if (segue.identifier == "nextView") {
//            var key = segue!.destinationViewController as! RestaurantTableViewController
//            key.toPass = apiKey
//        }
//    }


}

