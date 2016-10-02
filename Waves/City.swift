//
//  City.swift
//  Waves
//
//  Created by Rijul Gupta on 9/13/16.
//  Copyright © 2016 Rijul Gupta. All rights reserved.
//

import Foundation
import ReactiveCocoa

struct City{
    
    var name = MutableProperty("")
    var countryName = MutableProperty("")
    var stateName = MutableProperty("")
    var location = MutableProperty((0.0, 0.0))
    var coverImageLink = MutableProperty(NSURL(string: ""))
    var coverImage = MutableProperty(UIImage())
    
    var wavePreviews:[WavePreview] = []
    var numberWavePreviews = MutableProperty(0)
   // var hasFinishedLoadingWavePreviews:Bool
    var hasFinishedLoadingWavePreviews = MutableProperty(false)
    
    init(withName:String, Location:(Double, Double), coverImageLink:NSURL, countryName:String, stateName:String?){
        self.name.value = withName;
        self.location.value = Location
        self.coverImageLink.value = coverImageLink
        self.countryName.value = countryName
        self.stateName.value = stateName ?? ""
        
        self.hasFinishedLoadingWavePreviews.value = false
        
        
        dispatch_async(dispatch_get_global_queue (DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
                self.loadCoverImage();
        })
    }

//    mutating func loadWavePreview(wavePreview:WavePreview){
//        
//        self.wavePreviews.append(wavePreview)
//        
//      //  dispatch_async(dispatch_get_main_queue(), {
//        
//        
//       // })
//    }
//        
    
    mutating func loadWavePreview(){
        var waveP = WavePreview()
        waveP.cityName = self.name.value
        waveP.name = "Poop"
        
        self.wavePreviews.append(waveP)
        
        self.updateNumberOfWaves()
        if(self.numberWavePreviews.value < 10){
            
        }
        else{
            
        }
    }
    mutating func updateNumberOfWaves(){
        self.numberWavePreviews.value = self.wavePreviews.count ?? 0
    }
    
    func loadCoverImage(){
        
                let url = self.coverImageLink.value
                 var imgURL:NSURL = url!
                    // Download an NSData representation of the image at the URL
                    let request: NSURLRequest = NSURLRequest(URL: imgURL)
                    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?) -> Void in
                        if error == nil {
                            let image = UIImage(data: data!)
                           self.coverImage.value = image!
                        }
                        else {
                            print("Error: \(error!.localizedDescription)")
                          //  Crashlytics.sharedInstance().recordError(error!)
                        }
                    })
        

    }

}