//
//  ProfileViewModel.swift
//  Waves
//
//  Created by Rijul Gupta on 9/13/16.
//  Copyright © 2016 Rijul Gupta. All rights reserved.
//

import UIKit
import ReactiveCocoa
//import AWSS3
//import AWSCore

class ProfileViewModel{
    
    
    var isLoadingMoreWaves = MutableProperty(false)

    
    var user:User
    init(user:User){
        self.user = user

        
        
        //self.loadUserCoverImage()
        
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            // do some task
//            self.loadUserCoverImage()
//            self.loadUserProfileImage()
        //});
        
        
    }
    
    
    func bindUser(){
        

    }
    
    func loadMorePreviewsForUser(){
        
        //set up a rac binding to this value and our view controller. We call this function when the person scrolls to the bottom of the screen and there are more wave previews to load.
        isLoadingMoreWaves.value = true
        self.user.loadMoreWavePreviews(){
            (result:Bool) in
            self.isLoadingMoreWaves.value = false

        }
    }
    
    func imageWithGradient(image:UIImage!) -> UIImage{
        
        UIGraphicsBeginImageContext(image.size)
        var context = UIGraphicsGetCurrentContext()
        
        image.drawAtPoint(CGPointMake(0, 0))
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let locations:[CGFloat] = [0.0, 1.0]
        let bottom = UIColor(red: 0, green: 0, blue: 0, alpha: 1.5).CGColor
        let top = UIColor(red: 0, green: 0, blue: 0, alpha: 0).CGColor
        
        let gradient = CGGradientCreateWithColors(colorSpace,
                                                  [top, bottom], locations)
        
        let startPoint = CGPointMake(image.size.width / 2, image.size.height / 2)
        let endPoint = CGPointMake(image.size.width / 2, image.size.height)
        //CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0)
        CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, .DrawsBeforeStartLocation)
        
        let finalImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        
        return finalImage
    }
    
    
//    public func getPreviewImage() -> SignalProducer<UIImage?, NoError> {
//        if let previewImage = self.userCoverImage {
//            return SignalProducer(value: previewImage).observeOn(UIScheduler())
//        }
//        else {
//            let imageProducer = network.requestImage(previewURL)
//                .takeUntil(self.racutil_willDeallocProducer)
//                .on(next: { self.previewImage = $0 })
//                .map { $0 as UIImage? }
//                .flatMapError { _ in SignalProducer<UIImage?, NoError>(value: nil) }
//            
//            return SignalProducer(value: nil)
//                .concat(imageProducer)
//                .observeOn(UIScheduler())
//        }
//    }
    
//    
//    
//    var uploadCompletionHandler: AWSS3TransferUtilityUploadCompletionHandlerBlock?
//
//    var imageURL:NSURL = NSURL(string:"https://upload.wikimedia.org/wikipedia/commons/e/eb/The_Adicts_2011_SO36_03.jpg")!
//    //This will upload the image to an AWS s3 instance, then send this link to our custom servers. This lets the user handle a lot of bandwith and saves us money and server space.
//    func uploadCoverImage(){
//        
//        //defining bucket and upload file name
//        let S3BucketName: String = "waves.cover.image.bucket.dev"
//        let S3UploadKeyName: String = "public/testImage.jpg"
//        
//        
//        let expression = AWSS3TransferUtilityUploadExpression()
//        
//        
////        expression.progressBlock = {(task: AWSS3TransferUtilityTask, bytesSent: Int64, totalBytesSent: Int64, totalBytesExpectedToSend: Int64) in
////            dispatch_async(dispatch_get_main_queue(), {
////                let progress = Float(totalBytesSent) / Float(totalBytesExpectedToSend)
////                print("Les progrès sont: /(progress)")
////            })
////        }
////        
//        self.uploadCompletionHandler = { (task, error) -> Void in
//            dispatch_async(dispatch_get_main_queue(), {
//                if ((error) != nil){
//                    print("Failed with error")
//                    print("Error: \(error!)");
//                }
//                else{
//                    print("Sucess")
//                }
//            })
//        }
//        
//        let transferUtility = AWSS3TransferUtility.defaultS3TransferUtility()
//        
//        transferUtility.uploadFile(imageURL, bucket: S3BucketName, key: S3UploadKeyName, contentType: "image/jpeg", expression: expression, completionHander: uploadCompletionHandler).continueWithBlock { (task) -> AnyObject! in
//            if let error = task.error {
//                print("Error: \(error.localizedDescription)")
//            }
//            if let exception = task.exception {
//                print("Exception: \(exception.description)")
//            }
//            if let _ = task.result {
//                print("Upload Starting!")
//            }
//            
//            return nil;
//        }
//        
//    }
//    
//    
//    
    
    
    
    func wavePreviewCellForIndex(indexPath:NSIndexPath, cell:WavePreviewCell)->WavePreviewCell{
        
        let wavePreview = self.user.recentWavePreviews![indexPath.row]
        
        let startString = wavePreview.name! + " in "
        
        let attributedString = NSMutableAttributedString(string:startString)
        
        let attrs = [NSFontAttributeName : UIFont.boldSystemFontOfSize(15)]
        let boldString = NSMutableAttributedString(string:wavePreview.cityName!, attributes:attrs)
        
        attributedString.appendAttributedString(boldString)
        
        
        
        cell.waveNameLabel.attributedText = attributedString
        cell.cityImageLink = wavePreview.imageLink
        
        
        return cell
        
    }
}
