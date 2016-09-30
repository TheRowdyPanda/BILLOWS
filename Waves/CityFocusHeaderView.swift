//
//  CityFocusHeaderView.swift
//  Waves
//
//  Created by Rijul Gupta on 9/29/16.
//  Copyright © 2016 Rijul Gupta. All rights reserved.
//

import UIKit
import ReactiveCocoa

class CityFocusHeaderView:UICollectionReusableView{
    
    
    var city:City!
    @IBOutlet weak var cityNameLabel:UILabel!
    @IBOutlet weak var cityStateCountryNameLabel:UILabel!
    
    @IBOutlet weak var searchButton:UIButton!
    @IBOutlet weak var backButton:UIButton!
    
    @IBOutlet weak var numberFriendsVisited:UILabel!
        
    @IBOutlet weak var cityCoverImageView:UIImageView!
    
    
    //this city may be fully loaded, or it may be in the process of loading thing
    func setUpWith(city:City){
        self.city = city
        
    }
    
    
}
