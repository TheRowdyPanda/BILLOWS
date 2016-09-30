//
//  WaveDashboardViewModel.swift
//  Waves
//
//  Created by Rijul Gupta on 9/29/16.
//  Copyright © 2016 Rijul Gupta. All rights reserved.
//

import Foundation

class WaveDashboardViewModel{
    
    var waveId:String!
    
    var wave:Wave?
    var wavePreview:WavePreview?
    
    init(withId:String, completion:(result:Bool)->Void){
        
        self.waveId = withId
        
        //load the wave from our servers
        wave = Wave(withId: withId, completion: {
            (result:Bool) in
            
            //we return when all the important stuff is loaded. We can then load the rest on the background, but still present the information to the user.
            completion(result: result)
        })
        
        
        
    }
    
    init(withPreview:WavePreview){
        self.waveId = withPreview.waveId
    }
    
}