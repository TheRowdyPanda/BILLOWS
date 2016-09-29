//
//  MessageViewModel.swift
//  Waves
//
//  Created by Rijul Gupta on 9/27/16.
//  Copyright © 2016 Rijul Gupta. All rights reserved.
//

import Foundation

class MessageViewModel{
    
    var messages:[Message]?
    var waveId:String!
    
    init(waveId:String){
        
        self.waveId = waveId
    }
    
    
    func loadMessages(){
        
        let m1 = Message(withId: self.waveId);
        let m2 = Message(withId:self.waveId);
        let m3 = Message(withId:self.waveId);
        let m4 = Message(withId:self.waveId);
        let m5 = Message(withId:self.waveId);
        let m6 = Message(withId:self.waveId);
        
        let ms = [m1, m2, m3, m4, m5, m6];
    
        self.messages = ms;
        
        
        
        
    }
    
}