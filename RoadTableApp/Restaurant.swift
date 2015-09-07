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
    var id : String
    
    init(name:String, rating_img_url:String, categories:String, id:String) {
        self.name = name
        self.rating_img_url = rating_img_url
        self.categories = categories
        self.id = id
    }
    
    func toJSON() -> String {
        return ""
    }
    

}