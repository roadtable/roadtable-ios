//
//  RestaurantTableViewController.swift
//  RoadTableApp
//
//  Created by Daniel Nathan Beyrer on 9/3/15.
//  Copyright (c) 2015 theironyard. All rights reserved.
//

import UIKit
import CoreLocation

class RestaurantTableViewController: UITableViewController {
    // Mark: Properties
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var loadingLabel: UILabel!
    @IBOutlet weak var loadingView: UIView!
    

    var restaurantsCollection = [Restaurant]()
    var restaurantsList = [Restaurant]()
    
    var service:RestaurantService!
    let shareData = ShareData.sharedInstance
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SwiftSpinner.show("Pondering the meaning of life...", animated: true)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "routeToGoogleMaps:", name: "routeToPressed", object: nil)
        
        service = RestaurantService()
        service.getRestaurants {
            (response) in
            self.loadRestaurants(response as NSArray)
            SwiftSpinner.hide()
        }
    }
    
    //MARK Actions
    @IBAction func restaurantTableViewCellSwiped(sender: UISwipeGestureRecognizer) {
    }


    
    func loadRestaurants(restaurants:NSArray) {
        for restaurant in restaurants {
            // Set variables for Restaurant object
            var name = restaurant["name"]! as! String
            var rating_img_url = restaurant["rating_img_url"]! as! String
            var categories = restaurant["categories"]! as! String
            var id = restaurant["yelp_id"] as! String
            var image_url = restaurant["image_url"]! as! String
            var mobile_url = restaurant["mobile_url"] as! String
            var alert_point = restaurant["alert_point"] as! NSDictionary
            var address = restaurant["address"] as! String
            var lat = alert_point["latitude"] as! CLLocationDegrees
            var long = alert_point["longitude"] as! CLLocationDegrees

            var center = CLLocationCoordinate2DMake(lat, long)
            
            // Create Restaurant object
            var restaurantObj = Restaurant(name: name, rating_img_url: rating_img_url, categories: categories, id: id, image_url: image_url, mobile_url: mobile_url, center: center, alert_point: alert_point, address: address)
            restaurantsCollection.append(restaurantObj)
            
            // Reload on main thread
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantsCollection.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //Table view cells are reused and should be dequeed using a cell identifier
        
        let cellIdentifier = "RestaurantTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! RestaurantTableViewCell
        
        //Fetches the appropriate restaurant for the data source layout.
        
        let restaurant = restaurantsCollection[indexPath.row]
        
        let restaurantImgURL = NSURL(string: restaurant.image_url)
        let restaurantRatingURL = NSURL(string: restaurant.rating_img_url)

        self.service.downloadImage(restaurantImgURL!, imageView: cell.photoImageView)
        self.service.downloadImage(restaurantRatingURL!, imageView: cell.ratingImageView)
        
        cell.nameLabel.text = restaurant.name
        cell.categoryLabel.text = restaurant.categories

        return cell
    }
    
    // Notification action calls google maps
    func routeToGoogleMaps(notification: NSNotification) {
        let userInfo:NSDictionary! = notification.userInfo
        let addressForGoogle:String! = userInfo?["address"] as! String
        
        if (UIApplication.sharedApplication().canOpenURL(NSURL(string:"comgooglemaps://")!)) {
            UIApplication.sharedApplication().openURL(NSURL(string:
                "comgooglemaps://?saddr=&daddr=\(addressForGoogle!)&directionsmode=driving")!)
            
        } else {
            NSLog("Can't use comgooglemaps://");
            
            var url = NSURL(string: "https://maps.google.com?saddr=Current+Location&daddr=\(addressForGoogle)")!
            println("address stuff is next")
            println(addressForGoogle)
            println(url)
            UIApplication.sharedApplication().openURL(url)
        }
    }

    
    // Click goes to Yelp
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let restaurant = restaurantsCollection[indexPath.row]
        let url = NSURL(string: restaurant.mobile_url)!
        UIApplication.sharedApplication().openURL(url)
    }
    
    // Shows button
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
    }
    
    // Creates an add button
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
    
        var addAction = UITableViewRowAction(style: .Normal, title: "Add") { (action:UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            
            // Set restaurant
            let currentRestaurant = self.restaurantsCollection[indexPath.row]
            let address = currentRestaurant.address as NSString
            
            // Add items to database list
            self.service.addRestaurantToList(currentRestaurant.id)
            
            // Create notification for restaurant
            let notification = UILocalNotification()
            notification.alertBody = "You're almost to \(currentRestaurant.name)"
            notification.category = "routeCategory"
            notification.region = CLCircularRegion(center: currentRestaurant.center, radius: 16093, identifier: currentRestaurant.id)
            notification.regionTriggersOnce = true
            notification.userInfo = ["address": address]
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
            
            println(notification.region)
            println(currentRestaurant.center)
            
            self.tableView.reloadData()
        }
        
        addAction.backgroundColor = UIColor.blueColor()
        return [addAction]
    }
}
