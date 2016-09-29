//
//  Wave.swift
//  Waves
//
//  Created by Rijul Gupta on 9/13/16.
//  Copyright © 2016 Rijul Gupta. All rights reserved.
//

import Foundation

struct Wave{
    
    var destinationCityString:String
    var userPreviews:[UserPreview]
    //var comments
    //var likers
    
    
    //We want to get the full wave information from a wave preview. That will mean we'll need to load more json from the info in your wavepreview object.
    init(preview:WavePreview, completion:(result:Wave, error:NSError)->Void){
        
        self.destinationCityString = ""
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
    
    
    
    //Here, we load more info from the preview. We load info from our api. We use a completion handler to load the info asyncronously, and push the information when we're done.
    func loadDataFromWavePreview(preview:WavePreview, completion:(result:NSDictionary, error:NSError)->Void){
        
        
        //load data from api on background thread
    
        completion(result:NSDictionary(), error:NSError(coder: NSCoder())!)
    }
}