//
//  RestaurantService.swift
//  RoadTableApp
//
//  Created by Daniel Nathan Beyrer on 9/3/15.
//  Copyright (c) 2015 theironyard. All rights reserved.
//

import Foundation
import Alamofire

class RestaurantService {
    
    var settings:Settings!
    let shareData = ShareData.sharedInstance
    
    init(){
        self.settings = Settings()
    }
    
    func getRestaurants(callback:(NSDictionary) -> ()) {
        request("http://roadtable.herokuapp.com/sessions?api_key=\(self.shareData.apiKey)", callback: callback)
    }
    
    func getList(callback:(NSDictionary) -> ()) {
        request("http://roadtable.herokuapp.com/sessions/view_list?api_key=\(self.shareData.apiKey)", callback: callback)
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
    
    
    func createSession(origin: String, destination: String) {
        Alamofire.request(.POST, "http://roadtable.herokuapp.com/sessions", parameters: ["origin":"\(origin)", "destination":"\(destination)", "api_key":"\(self.shareData.apiKey)"], encoding: .JSON)
            .responseJSON { (request, response, data, error) in
                if let anError = error {
                    // got an error in getting the data, need to handle it
                    println("error calling POST on /posts")
                    println(error)
                } else if let data: AnyObject = data {
                    let session = JSON(data)
                    println(response)
                }
        }
    } // end createSession()
    
    func addRestaurantToList(id: String) {
        Alamofire.request(.POST, "http://roadtable.herokuapp.com/sessions/add_to_list", parameters: ["id":"\(id)", "api_key":"\(self.shareData.apiKey)"], encoding: .JSON)
            .responseJSON { (request, response, data, error) in
                if let anError = error {
                    // got an error in getting the data, need to handle it
                    println("error calling POST on /posts")
                    println(error)
                } else if let data: AnyObject = data {
                    let session = JSON(data)
                    println(response)
                }
                println(self.shareData.apiKey)
        }
        
    }// end addRestaurantToList()
    
}