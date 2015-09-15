//
//  RestaurantService.swift
//  RoadTableApp
//
//  Created by Daniel Nathan Beyrer on 9/3/15.
//  Copyright (c) 2015 theironyard. All rights reserved.
//

import Foundation
import Alamofire
import UIKit

class RestaurantService {
    
    var settings:Settings!
    let shareData = ShareData.sharedInstance
    
    init(){
        self.settings = Settings()
    }
    
    // GET available restaurants // routes#show
    func getRestaurants(callback:(NSArray) -> ()) {
        request("http://roadtable.herokuapp.com/routes?api_key=\(self.shareData.apiKey)", callback: callback)
    }
    
    // GET filtered available restaurants // routes#show with filter
    func getFilteredRestaurants(parameter:String, callback:(NSArray) -> ()) {
        request("http://roadtable.herokuapp.com/routes?api_key=\(self.shareData.apiKey)&filter=\(parameter)", callback: callback)
    }
    
    // GET chosen restaurants // sessions#show
    func getList(callback:(NSArray) -> ()) {
        request("http://roadtable.herokuapp.com/sessions?api_key=\(self.shareData.apiKey)", callback: callback)
    }
    
    // GET available restaurants
    func request(url:String, callback:(NSArray) -> () ) {
        var nsURL = NSURL(string: url)
        let task = NSURLSession.sharedSession().dataTaskWithURL(nsURL!) {
            (data, response, error) in
            var error:NSError?
            var response_json:NSArray?
            
            if error == nil {
                println(error)
                response_json = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers, error: &error) as? NSArray
            }
            if error != nil {
                println(error)
                response_json = []
            }
            callback(response_json!)
        }
        task.resume()
    }
    
    
    // Downloading images
    func getDataFromUrl(urL:NSURL, completion: ((data: NSData?) -> Void)) {
        NSURLSession.sharedSession().dataTaskWithURL(urL) { (data, response, error) in
            completion(data: data)
            }.resume()
    }
    
    func downloadImage(url:NSURL, imageView:UIImageView){
        println("Started downloading \"\(url.lastPathComponent!.stringByDeletingPathExtension)\".")
        getDataFromUrl(url) { data in
            dispatch_async(dispatch_get_main_queue()) {
                println("Finished downloading \"\(url.lastPathComponent!.stringByDeletingPathExtension)\".")
                imageView.image = UIImage(data: data!)
            }
        }
    }
    
    // Create a new API session
    func createSession(origin: String, destination: String) {
        Alamofire.request(.POST, "http://roadtable.herokuapp.com/sessions", parameters: ["origin":"\(origin)", "destination":"\(destination)", "api_key":"\(self.shareData.apiKey)"], encoding: .JSON)
            .responseJSON { (request, response, data, error) in
                if let anError = error {
                    println(error)
                }         }
    }
    
    // Add restaurant to API chosen list
    func addRestaurantToList(id: String) {
        Alamofire.request(.PATCH, "http://roadtable.herokuapp.com/sessions/update", parameters: ["akushon":"add" , "yelp_id":"\(id)", "api_key":"\(self.shareData.apiKey)"], encoding: .JSON)
            .responseJSON { (request, response, data, error) in
                if let anError = error {
                    // got an error in getting the data, need to handle it
                    println("error calling POST on /posts")
                    println(error)
                }
        }
        
    }
    
    // Remove restaurant from API chosen list
    func deleteRestaurantToList(id: String) {
        Alamofire.request(.PATCH, "http://roadtable.herokuapp.com/sessions/update", parameters: ["akushon":"delete", "yelp_id":"\(id)", "api_key":"\(self.shareData.apiKey)"], encoding: .JSON)
            .responseJSON { (request, response, data, error) in
                if let anError = error {
                    // got an error in getting the data, need to handle it
                    println("error calling POST on /posts")
                    println(error)
                }
        }
        
    }
}