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
    
    var wavePreviews:[WavePreview]?
   // var hasFinishedLoadingWavePreviews:Bool
    var hasFinishedLoadingWavePreviews = MutableProperty(false)
    
    init(withName:String, Location:(Double, Double), coverImageLink:NSURL, countryName:String, stateName:String?){
        self.name.value = withName;
        self.location.value = Location
        self.coverImageLink.value = coverImageLink
        self.countryName.value = countryName
        self.stateName.value = stateName ?? ""
        
        self.hasFinishedLoadingWavePreviews.value = false
//        dispatch_async(dispatch_get_main_queue(), {
//        self.loadWavePreviews(){
//            (result:Bool) in
//            
//            self.hasFinishedLoadingWavePreviews = true
//            
//            
//            
//        }
//            })
    }
    
//    
//    mutating func loadWavePreviews(completion:(result:Bool)->Void){
//        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(0.01 * Double(NSEC_PER_SEC)))
//        dispatch_after(delayTime, dispatch_get_main_queue()) {
//            
//            self.hasFinishedLoadingWavePreviews = true
//                completion(result: true)
//            
//            
//        }
//      // self.hasFinishedLoadingWavePreviews = true
//        //completion(result: true)
//    }
    

//    func loadWavePreviews()->Bool{
//        
//                let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2.0 * Double(NSEC_PER_SEC)))
//                dispatch_after(delayTime, dispatch_get_main_queue()) {
//                    
//                    var c:City = self
//                    let wavePs = [WavePreview(), WavePreview(), WavePreview()]
//                    c.wavePreviews = wavePs
//        
//                    c.hasFinishedLoadingWavePreviews = true
//                    print(self.hasFinishedLoadingWavePreviews)
//                    return c
//                }
//        return true
//        
//    }

}