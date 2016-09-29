//
//  User.swift
//  Waves
//
//  Created by Rijul Gupta on 9/13/16.
//  Copyright © 2016 Rijul Gupta. All rights reserved.
//

import Foundation


struct User{
    
    var firstName:String
    var lastName:String
    var homeTown:String?
    var homeTownCoordinates:(Float, Float)?
    var homeCityState:String?
    var coverImageLink:NSURL?
    var profileImageLink:NSURL?
    
    var numberWaves:Int?
    var numberMiles:Int?
    var numberFriends:Int?
    
    
    var friends:[User]?

    
    var recentWavePreviews:[WavePreview]?
    
    var allWavePreviews:[WavePreview]?
    var totalNumberWaves:Int?

    
    
    init(withId:String){
        
        firstName = "Rijul"
        lastName = "Gupta"
    }
    
    init(){
        firstName = ""
        lastName = ""
    }
    
    
    func loadMoreWavePreviews(completion:(result:Bool)->Void){
        
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            
        
        var otherWavePreview = WavePreview()
        otherWavePreview.cityName = "Test City Name"
        otherWavePreview.name = "Test Name"
        otherWavePreview.imageLink = NSURL(string: "")
        
        let otherPreviews = [otherWavePreview, otherWavePreview, otherWavePreview, otherWavePreview, otherWavePreview];
        
            
            completion(result: true)
        }
    }
}