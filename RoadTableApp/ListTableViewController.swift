//
//  ListTableViewController.swift
//  RoadTableApp
//
//  Created by Daniel Nathan Beyrer on 9/7/15.
//  Copyright (c) 2015 theironyard. All rights reserved.
//

import Foundation
import UIKit

class ListTableViewController: UITableViewController {
    // Mark: Properties
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    
    var restaurantsList = [Restaurant]()
    
    var service:RestaurantService!
    let shareData = ShareData.sharedInstance
    
    override func viewDidLoad() {
//        activityIndicatorView.startAnimating()
        println(self.shareData.apiKey)
        super.viewDidLoad()
        service = RestaurantService()
        service.getList {
            (response) in
            self.loadRestaurantsList(response["list"]! as! NSArray)
        }
    }
    
    //MARK Actions
    @IBAction func restaurantTableViewCellSwiped(sender: UISwipeGestureRecognizer) {
    }
    
    
    func loadRestaurantsList(list:NSArray) {
        for restaurant in list {
            var name = restaurant["name"]! as! String
            var rating_img_url = restaurant["rating_img_url"]! as! String
            var categories = restaurant["categories"]! as! String
            var id = restaurant["id"] as! String
            var image_url = restaurant["image_url"]! as! String
            var mobile_url = restaurant["mobile_url"] as! String
            var restaurantObj = Restaurant(name: name, rating_img_url: rating_img_url, categories: categories, id: id, image_url: image_url, mobile_url: mobile_url)
            restaurantsList.append(restaurantObj)
            dispatch_async(dispatch_get_main_queue()) {
                self.tableView.reloadData()
            }
        }
    }
    
    // Click goes to Yelp
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let restaurant = restaurantsList[indexPath.row]
        let url = NSURL(string: restaurant.mobile_url)!
        UIApplication.sharedApplication().openURL(url)
    }
    
    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantsList.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //Table view cells are reused and should be dequeed using a cell identifier
        
        let cellIdentifier = "ListTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! ListTableViewCell
        
        //Fetches the appropriate restaurant for the data source layout.
        
        let restaurant = restaurantsList[indexPath.row]
        
        let restaurantImgURL = NSURL(string: restaurant.image_url)
        let restaurantRatingURL = NSURL(string: restaurant.rating_img_url)
        
        self.service.downloadImage(restaurantImgURL!, imageView: cell.photoImageView)
        self.service.downloadImage(restaurantRatingURL!, imageView: cell.ratingImageView)
        
        cell.nameLabel.text = restaurant.name
        cell.categoryLabel.text = restaurant.categories
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [AnyObject]? {
        
        var deleteAction = UITableViewRowAction(style: .Normal, title: "Delete") { (action:UITableViewRowAction!, indexPath: NSIndexPath!) -> Void in
            
            let firstActivityItem = self.restaurantsList[indexPath.row]
            
            self.service.deleteRestaurantToList(firstActivityItem.id)
            self.restaurantsList.removeAtIndex(indexPath.row)
            self.tableView.reloadData()
            
        }
        
        return [deleteAction]
    }
}
