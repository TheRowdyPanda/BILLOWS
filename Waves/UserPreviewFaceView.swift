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
    override func layoutSubviews() {
        
                let viewHeight = self.frame.height;
        
                let padding:CGFloat = 2.0;
                let leftPadding:CGFloat = -10.0;
        
                //let calcViewWidth = (viewHeight + padding)*10.0;
        
                // self.frame = CGRectMake(0.0, 0.0, calcViewWidth, viewHeight)
                // self.setNeedsLayout()
        
                let imageHeight = viewHeight - padding*2.0;
                var left:CGFloat = self.frame.width;
        
                left = left - imageHeight - padding;
        
                let imageViewFrame = CGRectMake(left, padding, imageHeight, imageHeight)
                userImageView1 = UIImageView(frame: imageViewFrame)
                userImageView1!.backgroundColor = UIColor.yellowColor()
                userImageView1!.layer.borderWidth = 1
                userImageView1!.layer.masksToBounds = false
                userImageView1!.layer.borderColor = UIColor.redColor().CGColor
                userImageView1!.layer.cornerRadius = userImageView1!.frame.height/2
                userImageView1!.clipsToBounds = true
                self.addSubview(userImageView1!)
        
        
                left = left - imageHeight - leftPadding;
                let imageViewFrame2 = CGRectMake(left, padding, imageHeight, imageHeight)
                userImageView2 = UIImageView(frame: imageViewFrame2)
                userImageView2!.backgroundColor = UIColor.yellowColor()
                userImageView2!.layer.borderWidth = 1
                userImageView2!.layer.masksToBounds = false
                userImageView2!.layer.borderColor = UIColor.redColor().CGColor
                userImageView2!.layer.cornerRadius = userImageView2!.frame.height/2
                userImageView2!.clipsToBounds = true
                self.addSubview(userImageView2!)
        
        
                left = left - imageHeight - leftPadding;
                let imageViewFrame3 = CGRectMake(left, padding, imageHeight, imageHeight)
                userImageView3 = UIImageView(frame: imageViewFrame3)
                userImageView3!.backgroundColor = UIColor.yellowColor()
                userImageView3!.layer.borderWidth = 1
                userImageView3!.layer.masksToBounds = false
                userImageView3!.layer.borderColor = UIColor.redColor().CGColor
                userImageView3!.layer.cornerRadius = userImageView3!.frame.height/2
                userImageView3!.clipsToBounds = true
                self.addSubview(userImageView3!)
        
        
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
