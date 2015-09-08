//
//  ListTableViewCell.swift
//  RoadTableApp
//
//  Created by Daniel Nathan Beyrer on 9/7/15.
//  Copyright (c) 2015 theironyard. All rights reserved.
//

import Foundation
import UIKit

class ListTableViewCell: UITableViewCell {

    // MARK Properties
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }


}