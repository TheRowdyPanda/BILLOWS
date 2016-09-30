//
//  Wave.swift
//  Waves
//
//  Created by Rijul Gupta on 9/13/16.
//  Copyright © 2016 Rijul Gupta. All rights reserved.
//

import Foundation
import ReactiveCocoa

struct Wave{
    
    var waveId = MutableProperty("")
    var destinationCityString = MutableProperty("")
    
    
    
    var userPreviews:[UserPreview]?
    //var comments
    //var likers
    
    
    //We want to get the full wave information from a wave preview. That will mean we'll need to load more json from the info in your wavepreview object.
    init(preview:WavePreview, completion:(result:Wave, error:NSError)->Void){
        
        self.waveId.value = preview.waveId
        self.destinationCityString.value = ""
        self.userPreviews = [UserPreview]()
        //load info from object with completion handler
        loadDataFromWavePreview(preview){
            (result:NSDictionary, error:NSError) in
            //when the method is done, we set all the objects from our data
            
            
            
            print(result)
            
            
            //we can then return the self in our completion handler, and use this object in our view models
             completion(result:self, error: error)
            
        }
        
        
      //  super.init()
        
       
    }
    
    init(withId:String, completion:(result:Bool)->Void){
        
        self.waveId.value = withId;
        
        
        //load the rest of the important information
        //only return the completion handler when the info is loaded
        
        
        //the completion handler is unnecessary because we're using two-way binding
        completion(result: true);
        
        
        //load the less important information in the background. This should get called even though we already gave the completion
        
    }
    
    func loadInfoWithId(){
        //simulates server request
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            
            
        }
        
    }
    
    
    
    
    //Here, we load more info from the preview. We load info from our api. We use a completion handler to load the info asyncronously, and push the information when we're done.
    func loadDataFromWavePreview(preview:WavePreview, completion:(result:NSDictionary, error:NSError)->Void){
        
        
        //load data from api on background thread
    
        completion(result:NSDictionary(), error:NSError(coder: NSCoder())!)
    }
}