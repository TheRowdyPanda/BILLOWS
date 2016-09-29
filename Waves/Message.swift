//
//  Message.swift
//  Waves
//
//  Created by Rijul Gupta on 9/13/16.
//  Copyright © 2016 Rijul Gupta. All rights reserved.
//

import Foundation
import ReactiveCocoa

struct Message{
    
    var uniqueMessageId:String
    var waveId:String?
    var authorUserPreview:UserPreview?
    var messageBody:String?
    var messageDate:NSDate?
    var messageId:String?
    
    var location:(Float, Float)?
    
    var wavePreview:WavePreview?
    var wave:Wave?
    
    var hasFinishedLoadingData = MutableProperty(false)
//
    
    init(withId:String){
        
        self.uniqueMessageId = withId
        //self.waveId = withId
//        self.loadData(self.messageId!, completion: {
//            (result:NSDictionary) in
//            
//            let authorUserPreviewJson = result["userPreview"] as! NSDictionary
//            let authorUserPreview = UserPreview(withJson: authorUserPreviewJson)
//            
//            self.authorUserPreview = authorUserPreview
//        })
//        
        
    }
    
    
    
    func loadData(withId:String, completion:(result:NSDictionary)->Void){
        
        
        completion(result:NSDictionary())
    }
    
    
    func getMessageTime()->String{
        return "NOW"
    }
    
    
//    init(withJSON:NSDictionary){
//        waveId = ""
//        authorUserPreview = UserPreview()
//        messageBody = ""
//        messageDate = NSDate()
//    }
    
}