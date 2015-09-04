//
//  Settings.swift
//  RoadTableApp
//
//  Created by Daniel Nathan Beyrer on 9/3/15.
//  Copyright (c) 2015 theironyard. All rights reserved.
//

import Foundation

class Settings {
    
    
    
    var api_key:String!
    var viewRestaurants:String!
    
    init() {
        self.api_key = NSUUID().UUIDString
        self.viewRestaurants = "http://roadtable.herokuapp.com/sessions?api_key=\(api_key)"
        println(viewRestaurants)
    }
    
//    var api_key = NSUUID().UUIDString
//    var viewRestaurants = "http://roadtable.herokuapp.com/sessions?api_key=\(api_key)"
    
}