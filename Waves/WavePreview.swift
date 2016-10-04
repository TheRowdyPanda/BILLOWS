//
//  WavePreview.swift
//  Waves
//
//  Created by Rijul Gupta on 9/13/16.
//  Copyright © 2016 Rijul Gupta. All rights reserved.
//

import Foundation
import ReactiveCocoa


class WavePreview{
    
    var waveId = MutableProperty("")
    var name = MutableProperty("")
    var cityName = MutableProperty("")
    var imageLink = MutableProperty(NSURL(string:""))
    var coverImage = MutableProperty(UIImage())
    var coverImageData = MutableProperty(NSData(base64EncodedString: "", options: []))
    
    
    
    init(wave:Wave){
        self.name.value = ""
        self.cityName.value = ""
        self.waveId.value = wave.waveId.value;
    }
    
    init(json:NSDictionary){
        self.waveId.value = ""
        self.name.value = ""
        self.cityName.value = ""
    }
    
    init(){
        self.waveId.value = ""
        self.name.value = ""
        self.cityName.value = ""
        self.coverImage = MutableProperty(UIImage())
        self.imageLink.producer.startWithNext({
            next in
            if(next != ""){
            //load the stuff on background threads
            dispatch_async(dispatch_get_global_queue (DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                self.loadCoverImage();
            })
            }
        })
        
    }
    
    
    //this loads a UIImage from an NSURL in the background thread. It then updates the UIImage value on the main thread. This propogates due to RAC.
    func loadCoverImage(){
        
        let url = self.imageLink.value
        let imgURL:NSURL = url!
        // Download an NSData representation of the image at the URL
        let request: NSURLRequest = NSURLRequest(URL: imgURL)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {[weak self]
            (response: NSURLResponse?,data: NSData?,error: NSError?) -> Void in
            if error == nil {
                dispatch_async(dispatch_get_main_queue(), {
                    [weak self] in
                   //  let image = UIImage(data: data!)

//                    if let test = self.coverImage{
                    
                    self!.coverImageData.value = data
//                    }
                    
                })
            }
            else {
                print("Error: \(error!.localizedDescription)")
                //  Crashlytics.sharedInstance().recordError(error!)
            }
        })
        
        
    }

}
