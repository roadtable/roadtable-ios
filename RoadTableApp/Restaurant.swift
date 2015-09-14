//
//  Restaurant.swift
//  RoadTableApp
//
//  Created by Daniel Nathan Beyrer on 9/3/15.
//  Copyright (c) 2015 theironyard. All rights reserved.
//

import Foundation
import CoreLocation

class Restaurant {
    
    var name : String
    var rating_img_url : String
    var categories : String
    var id : String
    var image_url : String
    var mobile_url : String
    var center: CLLocationCoordinate2D
    var alert_point: NSDictionary
    
    init(name:String, rating_img_url:String, categories:String, id:String, image_url:String, mobile_url:String, center: CLLocationCoordinate2D, alert_point: NSDictionary) {
        self.name = name
        self.rating_img_url = rating_img_url
        self.categories = categories
        self.image_url = image_url
        self.id = id
        self.mobile_url = mobile_url
        self.center = center
        self.alert_point = alert_point
    }

} // end Restaurant