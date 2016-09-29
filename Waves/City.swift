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
    
    var name:String
    var countryName:String
    var stateName:String?
    var location:(Float, Float)
    var coverImageLink:NSURL
    
    var wavePreviews:[WavePreview]?
   // var hasFinishedLoadingWavePreviews:Bool
    var hasFinishedLoadingWavePreviews = MutableProperty(false)
    
    init(withName:String, Location:(Float, Float), coverImageLink:NSURL, countryName:String, stateName:String?){
        self.name = withName;
        self.location = Location
        self.coverImageLink = coverImageLink
        self.countryName = countryName
        self.stateName = stateName
        
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