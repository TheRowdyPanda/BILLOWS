//
//  UserPreviewFaceView.swift
//  Waves
//
//  Created by Rijul Gupta on 9/30/16.
//  Copyright © 2016 Rijul Gupta. All rights reserved.
//

import UIKit

class UserPreviewFaceView:UIView{
    
    var userImageView1:UIImageView?
    var userImageView2:UIImageView?
    var userImageView3:UIImageView?
    
    var hasLoaded = false
    
    
//    override func layoutSubviews() {
//        super.layoutSubviews()
//        
//        
//        
//        
////        
//
//
//        
//        
//        
//    }
    func setupUpImages(){
        
        
        if(hasLoaded == true){
            return
        }
        hasLoaded = true
        dispatch_async(dispatch_get_main_queue(), {
            [weak self] in
            let viewHeight = self!.frame.height;
            
            let padding:CGFloat = 2.0;
            let leftPadding:CGFloat = -10.0;
            
            //let calcViewWidth = (viewHeight + padding)*10.0;
            
            // self.frame = CGRectMake(0.0, 0.0, calcViewWidth, viewHeight)
            // self.setNeedsLayout()
            
            let imageHeight = viewHeight - padding*2.0;
            var left:CGFloat = self!.frame.width;
            
            left = left - imageHeight - padding;
            
            let imageViewFrame = CGRectMake(left, padding, imageHeight, imageHeight)
            self!.userImageView1 = UIImageView(frame: imageViewFrame)
            self!.userImageView1!.backgroundColor = UIColor.yellowColor()
            self!.userImageView1!.layer.borderWidth = 1
            self!.userImageView1!.layer.masksToBounds = false
            self!.userImageView1!.layer.borderColor = UIColor.redColor().CGColor
            self!.userImageView1!.layer.cornerRadius = self!.userImageView1!.frame.height/2
            self!.userImageView1!.clipsToBounds = true
            self!.addSubview(self!.userImageView1!)
            
            let topConst1 = NSLayoutConstraint(item: self!.userImageView1!, attribute: .Top, relatedBy: .Equal, toItem: self, attribute: .Top, multiplier: 1.0, constant: 0.0)
            let bottomConst1 = NSLayoutConstraint(item: self!.userImageView1!, attribute: .Bottom, relatedBy: .Equal, toItem: self, attribute: .Bottom, multiplier: 1.0, constant: 0.0)
            self!.addConstraints([topConst1, bottomConst1])
            
            
            
            
            left = left - imageHeight - leftPadding;
            let imageViewFrame2 = CGRectMake(left, padding, imageHeight, imageHeight)
            self!.userImageView2 = UIImageView(frame: imageViewFrame2)
            self!.userImageView2!.backgroundColor = UIColor.yellowColor()
            self!.userImageView2!.layer.borderWidth = 1
            self!.userImageView2!.layer.masksToBounds = false
            self!.userImageView2!.layer.borderColor = UIColor.redColor().CGColor
            self!.userImageView2!.layer.cornerRadius = self!.userImageView2!.frame.height/2
            self!.userImageView2!.clipsToBounds = true
            self!.addSubview(self!.userImageView2!)
            
            
            left = left - imageHeight - leftPadding;
            let imageViewFrame3 = CGRectMake(left, padding, imageHeight, imageHeight)
            self!.userImageView3 = UIImageView(frame: imageViewFrame3)
            self!.userImageView3!.backgroundColor = UIColor.yellowColor()
            self!.userImageView3!.layer.borderWidth = 1
            self!.userImageView3!.layer.masksToBounds = false
            self!.userImageView3!.layer.borderColor = UIColor.redColor().CGColor
            self!.userImageView3!.layer.cornerRadius = self!.userImageView3!.frame.height/2
            self!.userImageView3!.clipsToBounds = true
            self!.addSubview(self!.userImageView3!)
            })
        

        
    }
    override func layoutSubviews() {
            }

    //    var userPreviews:[UserPreview]?
    //
    //
    //    func setUpWithPreviews(previews:[UserPreview]){
    //
    //        let viewHeight = self.frame.height;
    //        let padding:CGFloat = 2.0;
    //        let imageHeight = viewHeight - padding*2.0;
    //        var left:CGFloat = 0.0;
    //
    //        left = left + padding;
    //
    //        let imageViewFrame = CGRectMake(left, padding, imageHeight, imageHeight)
    //        let imageView1 = UIImageView(frame: imageViewFrame)
    //        imageView1.backgroundColor = UIColor.blackColor()
    //        self.addSubview(imageView1)
    //
    //
    //    }
    
    
    
}
