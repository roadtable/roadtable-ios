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
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        createSession("indianapolis", destination: "bloomington")
        
        
    }
    
    
    
    
    func createSession(origin: String, destination: String) {
        Alamofire.request(.POST, "http://roadtable.herokuapp.com/sessions", parameters: ["origin":"\(origin)",                                       "destination":"\(destination)"], encoding: .JSON)
            .responseJSON { (request, response, data, error) in
                if let anError = error {
                    // got an error in getting the data, need to handle it
                    println("error calling POST on /posts")
                    println(error)
                } else if let data: AnyObject = data {
                    let session = JSON(data)
                    for (name, info) in session["restaurants"] {
                        println(name)
                        println(info["rating"])
                    }
                    println("done!")
                }
        }
        
        
    } // end createSession()
 
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

