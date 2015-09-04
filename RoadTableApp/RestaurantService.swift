//
//  RestaurantService.swift
//  RoadTableApp
//
//  Created by Daniel Nathan Beyrer on 9/3/15.
//  Copyright (c) 2015 theironyard. All rights reserved.
//

import Foundation

class RestaurantService {
    
    var settings:Settings!
    
    init(){
        self.settings = Settings()
    }
    
    func getRestaurants(callback:(NSDictionary) -> ()) {
        request(settings.viewRestaurants, callback: callback)
    }
    
    func request(url:String, callback:(NSDictionary) -> () ) {
        var nsURL = NSURL(string: url)
        
        let task = NSURLSession.sharedSession().dataTaskWithURL(nsURL!) {
            (data, response, error) in
            var error:NSError?
            var response = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as! NSDictionary
            callback(response)
        }
        task.resume()
    }
    
}