//
//  WavePreview.swift
//  Waves
//
//  Created by Rijul Gupta on 9/13/16.
//  Copyright © 2016 Rijul Gupta. All rights reserved.
//

import Foundation


struct WavePreview{
    
    var name:String
    var cityName:String
    var imageLink:NSURL?
    
    init(wave:Wave){
        self.name = ""
        self.cityName = ""
    }
    
    init(json:NSDictionary){
        self.name = ""
        self.cityName = ""
    }
    
    init(){
        self.name = ""
        self.cityName = ""
    }
}