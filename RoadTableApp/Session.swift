//
//  Session.swift
//  RoadTableApp
//
//  Created by Caleb Francis on 9/2/15.
//  Copyright (c) 2015 theironyard. All rights reserved.
//

import Foundation
import Alamofire

class Session {
    var origin:String
    var destination:String
//    var json : JSON?
    var restaurants = [String:String]()
    
    init(origin: String, destination: String) {
        self.origin = origin
        self.destination = destination
        var json : JSON?
        Alamofire.request(.POST, "http://roadtable.herokuapp.com/sessions", parameters: ["origin":"\(origin)",                                       "destination":"\(destination)"])
            .responseJSON { (_, _, data, _) in
                json = JSON(data!)
        }
    }


    
    // Create a session object
//    class func createSession() {
//        Alamofire.request(.POST, "http://roadtable.herokuapp.com/sessions", parameters: ["origin":"indianapolis",                                       "destination":"bloomington"])
//            .responseJSON { (_, _, json, _) in
//                var json = JSON(json!)
//                var session = Session(origin: json["origin"].string!, destination: json["destination"].string!)
//        }
//    }
    
    
}