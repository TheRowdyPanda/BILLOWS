//
//  User.swift
//  Waves
//
//  Created by Rijul Gupta on 9/13/16.
//  Copyright © 2016 Rijul Gupta. All rights reserved.
//

import Foundation
import ReactiveCocoa


struct User{
    
    var userId = MutableProperty("")
    var firstName = MutableProperty("")
    var lastName = MutableProperty("")
    var homeTown = MutableProperty("")
    
    var homeTownCoordinates = MutableProperty((0.0, 0.0))
   // var homeTownCoordinates:(Float, Float)?
    var homeCityState = MutableProperty("")
    //var coverImageLink:NSURL?
    var coverImageLink = MutableProperty(NSURL(string:""))
    var profileImageLink = MutableProperty(NSURL(string:""))
    
    var numberWaves = MutableProperty(0)
    var numberMiles = MutableProperty(0)
    var numberFriends = MutableProperty(0)
    var friends:[User]?

    
    var recentWavePreviews:[WavePreview]?
    
    var allWavePreviews:[WavePreview]?
    var totalNumberWaves:Int?

    
    
    init(withId:String){
        
        self.userId.value = withId


        self.loadInfo()
//        firstName = "Rijul"
//        lastName = "Gupta"
    }
    
    func loadInfo(){

        self.coverImageLink.producer.startWithNext({
            
            next in
            
        })
        
        
        //simulates server request
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
                
            
            self.coverImageLink.value = NSURL(string: "http://1.bp.blogspot.com/-SmUEFeHmKEQ/UcbZrhICk5I/AAAAAAAAQDk/so64PKEv7Ko/s1600/url444.jpg")

        }
    }
    
    func loadInformationWithId(){
        
    }
//    
//    init(){
//        firstName = ""
//        lastName = ""
//    }
    
    
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