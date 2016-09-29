//
//  CityTableCell.swift
//  Waves
//
//  Created by Rijul Gupta on 9/20/16.
//  Copyright © 2016 Rijul Gupta. All rights reserved.
//

import UIKit

class CityTableCell:UITableViewCell{
    
    @IBOutlet weak var coverImage:UIImageView!
    
    @IBOutlet weak var cityNameLabel:UILabel!
    @IBOutlet weak var countryNameLabel:UILabel!
    
    var cityImageLink:NSURL!
    
    override func awakeFromNib() {
        
        cityNameLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        cityNameLabel.layer.shadowOpacity = 1
        cityNameLabel.layer.shadowRadius = 12
        cityNameLabel.layer.shadowColor = UIColor.blackColor().CGColor
        
        countryNameLabel.layer.shadowOffset = CGSize(width: 0, height: 0)
        countryNameLabel.layer.shadowOpacity = 1
        countryNameLabel.layer.shadowRadius = 8
        countryNameLabel.layer.shadowColor = UIColor.blackColor().CGColor
    }
    func viewDidLoad(){
        
        
    }
    
    
}
