//
//  CityTableCell.swift
//  Waves
//
//  Created by Rijul Gupta on 9/20/16.
//  Copyright © 2016 Rijul Gupta. All rights reserved.
//

import UIKit
import ReactiveCocoa

class CityTableCell:UITableViewCell{
    
    @IBOutlet weak var coverImage:UIImageView!
    
    @IBOutlet weak var cityNameLabel:UILabel!
    @IBOutlet weak var countryNameLabel:UILabel!
    
    var cityImageLink:NSURL!
    
    weak var city:City!
    
    func setupWithCity(city:City){
        self.city = city
        
        self.bindModel()
    }
    
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
    
    
    func bindModel(){
        
        dispatch_async(dispatch_get_global_queue (DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            
            self.city.name.producer.startWithNext({
                [weak self]
                next in
                self!.cityNameLabel.text = next
            })
            
            self.city.stateName.producer.startWithNext({
                [weak self]
                next in
                
                self!.countryNameLabel.text = next
            })
            
            self.city.stateName.producer.combineLatestWith(self.city.countryName.producer).startWithNext({
                [weak self]
                next in
                if(next.1 == "USA"){
                    self!.countryNameLabel.text = next.0
                }
                else{
                    self!.countryNameLabel.text = next.1
                }
                
            })
            
            self.city.coverImageData.producer.startWithNext({
                [weak self]
                next in
                if let image = UIImage(data:next!){
                    dispatch_async(dispatch_get_main_queue(), {
                        [weak self] in
                        
                        
                        self!.coverImage.image = image
                        })
                }
                })
            //            self.city.coverImage.producer.startWithNext({
            //                next in
            //
            //                dispatch_async(dispatch_get_main_queue(), {
            //
            //
            //                    self.coverImage.image = next
            //                })
            //            })
            
        })
        
    }
    
    
    func viewDidLoad(){
        
        
    }
    
    
}
