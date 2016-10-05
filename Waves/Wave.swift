//
//  Wave.swift
//  Waves
//
//  Created by Rijul Gupta on 9/13/16.
//  Copyright © 2016 Rijul Gupta. All rights reserved.
//

import Foundation
import ReactiveCocoa

class Wave{
    
    //this is a unique Id from our servers. We can load all the info from this one tag
    var waveId = MutableProperty("")
    //The city most of the actions are happening in
    var destinationCityString = MutableProperty("")
    
    //the average rating, pulled from servers
    var avgStarRating = MutableProperty(4)
    
    // the total number of ratings for the wave
    var numStarRatings = MutableProperty(110)
    
    // the total number of comments on the wave
    var numComments = MutableProperty(10)
    
    //A list of users associated with this wave. We only load wave previews (profile pic and name), and load the full user model if we need it.
    var userPreviews:[UserPreview]?
    
    //a couple of boolean tags to alert the view model to when this model struct has loaded more info. We'll program what to do in the view model and view controllers
    var hasLoadedAllInfo = MutableProperty(false)
    var hasLoadedBasicInfo = MutableProperty(false)
    
    //This is the location information of a struct model type
    var locationInformation:Location?
    
    //This is the information stored in the Social Explorer class
    var socialExplorer:SocialExplorer?
    
    
    //We want to get the full wave information from a wave preview. That will mean we'll need to load more json from the info in your wavepreview object.
    init(preview:WavePreview, completion:(result:Bool)->Void){
        
        
        self.waveId.value = preview.waveId.value
        
//        if preview.waveId.value != ""{
//            self.waveId.value = preview.waveId.value
//        }
//        else{
//            print("ERROR!")
//        }
//        
        self.destinationCityString.value = ""
        
        
        if let previewUser = preview.userPreviews{
            self.userPreviews = previewUser
        }
        
        
        //after we've set all the info, we check the overall wave status. We'll load additional information from there if necessary.
        
        completion(result: true);
//        //load info from object with completion handler
//        loadDataFromWavePreview(preview){
//            (result:NSDictionary, error:NSError) in
//            //when the method is done, we set all the objects from our data
//            
//            
//            
//            print(result)
//            
//            
//            //we can then return the self in our completion handler, and use this object in our view models
//             completion(result:self, error: error)
//            
//        }
        
        
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
    
    //here we check all the information stored in this wave. If any pieces are missing, we load the information from our servers in other functions.
    //We also check for the information in batches. If a basic piece of info is missing, we load all basic pieces of info. If just the cover image is missing, we just load the cover image.
    func checkWaveStatus(){
        
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
