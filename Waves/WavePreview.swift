//
//  WavePreview.swift
//  Waves
//
//  Created by Rijul Gupta on 9/13/16.
//  Copyright © 2016 Rijul Gupta. All rights reserved.
//

import Foundation


struct WavePreview{
    
    var waveId:String
    var name:String?
    var cityName:String?
    var imageLink:NSURL?
    
    init(wave:Wave){
        self.name = ""
        self.cityName = ""
        self.waveId = wave.waveId.value;
    }
    
    init(json:NSDictionary){
        self.waveId = ""
        self.name = ""
        self.cityName = ""
    }
    
    init(){
        self.waveId = ""
        self.name = ""
        self.cityName = ""
    }
}