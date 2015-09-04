//
//  Restaurant.swift
//  RoadTableApp
//
//  Created by Daniel Nathan Beyrer on 9/3/15.
//  Copyright (c) 2015 theironyard. All rights reserved.
//

import Foundation
import Alamofire


class Restaurant {
    
    var name : String
    var rating_img_url : String
    var categories : String
    
    init(name:String, rating_img_url:String, categories:String) {
        self.name = name
        self.rating_img_url = rating_img_url
        self.categories = categories
    }
    
    func toJSON() -> String {
        return ""
    }
    
    func getRestaurantsAtPath( completionHandler: (AnyObject?, NSError?) -> Void)  {
        Alamofire.request(.GET, "http://roadtable.herokuapp.com")
            .responseJSON { (request, response, data, error) in
            if let anError = error {
                // got an error in getting the data, need to handle it
                completionHandler(nil, error)
                return
            }
            completionHandler(data, nil)
        }
    }
    

}