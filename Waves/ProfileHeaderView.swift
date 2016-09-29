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
    
    var userCoverImageViewProperty = MutableProperty(UIImage())
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
        
        self.userFirstNameLabel.text = self.user.firstName;
        self.userLastNameLabel.text = self.user.lastName;
        self.homeTownLabel.text = self.user.homeTown;
        self.homeStateCountryLabel.text = self.user.homeCityState;
        
        
        
        
        self.userCoverImageViewProperty
            .producer
            .startWithNext({
                [weak self]
                next in
                dispatch_async(dispatch_get_main_queue(), {
                    if let imageView = self!.coverImageView{
                        imageView.image = next
                        UIView.animateWithDuration(0.4, animations: {
                            imageView.alpha = 1.0
                            
                        })
                        
                    }
                })
                
                })
        
        self.userImageViewProperty
            .producer
            .startWithNext({
                [weak self]
                next in
                dispatch_async(dispatch_get_main_queue(), {
                    if let imageView = self!.userImageView{
                        imageView.image = next
                        
                    }
                })
                
                })
        
    }
    
}
