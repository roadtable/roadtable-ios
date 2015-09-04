//
//  ShareData.swift
//  RoadTableApp
//
//  Created by Caleb Francis on 9/4/15.
//  Copyright (c) 2015 theironyard. All rights reserved.
//

import Foundation

class ShareData {
    class var sharedInstance : ShareData {
        struct Static {
            static var instance: ShareData?
            static var token: dispatch_once_t = 0
        }
    
        dispatch_once(&Static.token) {
            Static.instance = ShareData()
        }
        return Static.instance!
    }
    
    var apiKey:String!






}