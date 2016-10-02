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
    @IBOutlet weak var viewWavesButton:UIButton!
        
    @IBOutlet weak var cityCoverImageView:UIImageView!
    
    @IBOutlet weak var userPreviewFaceView:UserPreviewFaceView!
    
    //this city may be fully loaded, or it may be in the process of loading thing
    func setUpWith(city:City, completion:(result:Bool)->Void){
        self.city = city
        completion(result: true)
    }
    
    override func awakeFromNib() {
        
        self.cityNameLabel.sizeToFit()
        self.cityNameLabel.layoutIfNeeded()
        
        self.cityStateCountryNameLabel.sizeToFit()
        self.cityStateCountryNameLabel.layoutIfNeeded()
        
        
        
        viewWavesButton.layer.borderWidth = 1
        viewWavesButton.layer.masksToBounds = false
        viewWavesButton.layer.borderColor = UIColor.whiteColor().CGColor
        viewWavesButton.layer.cornerRadius = 4.0;
        viewWavesButton.clipsToBounds = true
        
       // self.bindModel()
        
    }
    
    func bindModel(){
        self.city.name.producer.startWithNext({
            next in
            
            self.cityNameLabel.text = next
        })
        
        self.city.coverImage.producer.startWithNext({
            next in
            
            self.cityCoverImageView.image = next
        })
    }
    
//    func setUpUserPreviews(previews:[UserPreview]){
//        
//        userPreviewFaceView.setUpWithPreviews(previews)
//    }
    
    
}
