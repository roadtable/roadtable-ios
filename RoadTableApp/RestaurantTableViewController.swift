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
    

    var restaurantsCollection = [Restaurant]()
    var restaurantsList = [Restaurant]()
    
    var service:RestaurantService!
    let shareData = ShareData.sharedInstance
    
    override func viewDidLoad() {
        activityIndicatorView.startAnimating()
        println(self.shareData.apiKey)
        super.viewDidLoad()
        service = RestaurantService()
        service.getRestaurants {
            (response) in
            self.loadRestaurants(response["restaurants"]! as! NSArray)
        }
        activityIndicatorView.stopAnimating()
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
            var id = restaurant["id"] as! String
            var image_url = restaurant["image_url"]! as! String
            var mobile_url = restaurant["mobile_url"] as! String
            var polypoint = restaurant["polypoint"] as! NSDictionary
            var lat = polypoint["latitude"] as! CLLocationDegrees
            var long = polypoint["longitude"] as! CLLocationDegrees

            var center = CLLocationCoordinate2DMake(lat, long)
            
            // Create Restaurant object
            var restaurantObj = Restaurant(name: name, rating_img_url: rating_img_url, categories: categories, id: id, image_url: image_url, mobile_url: mobile_url, center: center)
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
            
            // Add items to database list
            self.service.addRestaurantToList(currentRestaurant.id)
            
            // Create notification for restaurant
            let notification = UILocalNotification()
            notification.alertBody = "You're almost to \(currentRestaurant.name)"
            notification.region = CLCircularRegion(center: currentRestaurant.center, radius: 16093, identifier: currentRestaurant.id)
            notification.regionTriggersOnce = true
            UIApplication.sharedApplication().scheduleLocalNotification(notification)
            
            println(notification.region)
            println(currentRestaurant.center)
            
//            self.tableView.reloadData()
        }
        
        addAction.backgroundColor = UIColor.blueColor()
        return [addAction]
    }
    
    
    
    
    
    
    
    
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

}
