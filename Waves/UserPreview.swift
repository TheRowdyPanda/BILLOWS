//
//  UserPreview.swift
//  Waves
//
//  Created by Rijul Gupta on 9/13/16.
//  Copyright © 2016 Rijul Gupta. All rights reserved.
//

import Foundation

struct UserPreview{
    
    var userFirstName:String
    
    //do optional unchaining
    init(withJson:NSDictionary){
        self.userFirstName = (withJson["firstName"]?.string)!
    }
    
}