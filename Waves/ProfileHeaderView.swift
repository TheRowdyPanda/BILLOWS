//
//  ProfileHeaderView.swift
//  Waves
//
//  Created by Rijul Gupta on 9/22/16.
//  Copyright © 2016 Rijul Gupta. All rights reserved.
//

import UIKit
import ReactiveCocoa

class ProfileHeaderView:UICollectionReusableView{
    
    
    @IBOutlet weak var coverImageView:UIImageView!
    @IBOutlet weak var userImageView:UIImageView!
    @IBOutlet weak var userFirstNameLabel:UILabel!
    @IBOutlet weak var userLastNameLabel:UILabel!
    @IBOutlet weak var homeTownLabel:UILabel!
    @IBOutlet weak var homeStateCountryLabel:UILabel!
    
    
    @IBOutlet weak var numberWavesLabel:UILabel!
    @IBOutlet weak var numberMilesLabel:UILabel!
    @IBOutlet weak var numberFriendsLabel:UILabel!
    
    
    @IBOutlet weak var addFriendButton:UIButton!
    @IBOutlet weak var messageUserButton:UIButton!
    @IBOutlet weak var flagUserButton:UIButton!
    
    var userCoverImageLinkProperty = MutableProperty(NSURL(string:""))
    //    var userCoverImageViewProperty = MutableProperty(UIImage())
    var userImageViewProperty = MutableProperty(UIImage())
    
    var user:User!
    
    func setUpWith(user:User, completion: (result: Bool) -> Void){
        self.user = user
        
        
        completion(result: true)
        
    }
    
    
    override func awakeFromNib() {
        
        
        
        
        userImageView.layer.borderWidth = 1
        userImageView.layer.masksToBounds = false
        userImageView.layer.borderColor = UIColor.blackColor().CGColor
        userImageView.layer.cornerRadius = userImageView.frame.height/2
        userImageView.clipsToBounds = true
        
        
        addFriendButton.layer.masksToBounds = false
        addFriendButton.layer.cornerRadius = 10.0
        addFriendButton.clipsToBounds = true
        
        messageUserButton.layer.masksToBounds = false
        messageUserButton.layer.cornerRadius = 10.0
        messageUserButton.clipsToBounds = true
        
        
        
        //self.userImageView.layer.
    }
    
    func bindModel(){
        
        dispatch_async(dispatch_get_global_queue (DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            
            // self.userFirstNameLabel.text = self.user.firstName;
            // self.userLastNameLabel.text = self.user.lastName;
            //   self.homeTownLabel.text = self.user.homeTown;
            //   self.homeStateCountryLabel.text = self.user.homeCityState;
            
            self.user.firstName.producer.startWithNext({
                [weak self]
                next in
                
                self?.userFirstNameLabel.text = next;
                })
            
            self.user.lastName.producer.startWithNext({
                [weak self]
                next in
                
                self?.userLastNameLabel.text = next;
                })
            
            self.user.homeCityState.producer.startWithNext({
                [weak self]
                next in
                
                self?.homeStateCountryLabel.text = next;
                })
            
            self.user.firstName.producer.startWithNext({
                [weak self]
                next in
                
                self?.userFirstNameLabel.text = next;
                })
            
            self.user.coverImageLink.producer.startWithNext({
                [weak self]
                next in
                
                if let check = self{
                    
                }
                else{
                    return
                }
                if let data = NSData(contentsOfURL: (next)!){
                    
                    if let image = UIImage(data:data){
                        dispatch_async(dispatch_get_main_queue(), {
                            self!.coverImageView.image = image
                            self!.coverImageView.alpha = 1.0;
                        })
                    }
                }
                
                })
            
            
            self.user.profileImageLink.producer.startWithNext({
                [weak self]
                next in
                if let data = NSData(contentsOfURL: (next)!){
                    
                    if let image = UIImage(data:data){
                        dispatch_async(dispatch_get_main_queue(), {
                            self!.userImageView.image = image
                        })
                    }
                }
                
                })
            
            
            
            
        })
    }
    
    
}
