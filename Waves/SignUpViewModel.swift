//
//  SignUpViewModel.swift
//  Waves
//
//  Created by Rijul Gupta on 9/13/16.
//  Copyright © 2016 Rijul Gupta. All rights reserved.
//

import Foundation
import ReactiveCocoa


class SignUpViewModel{

    var fakeEmail = "Erlich.Bachman@piedpiper.com"
    var fakePassword = "ThisGuyFucks88"
    

    var userEmailString = MutableProperty("")
    var userPasswordString = MutableProperty("")
    
    var userPhoneNumber:String?
    var userHomeTown:String?
    var userLocation:(Float, Float)?
    
    
    var hasCompletedFields = MutableProperty(true)
    
    
    var hasSentData = MutableProperty(false)
   
    
//
    init(){
        userEmailString.signal.observeNext({[weak self] next in
            print("User edited email text field:\(next)")
            print(next.characters.count)
            if(next.characters.count > 0){
                
                self!.hasCompletedFields.value = false
                
            }
        })
        
        userPasswordString.signal.observeNext({[weak self] next in
            print("User edited password text field:\(next)")
            if(next.characters.count > 0){
                
                self!.hasCompletedFields.value = true
                
            }
            })
        
    }
    
    
    func submitInformationToServers(){
        fakeEmail = "1"
        fakePassword = "2"
        if(userEmailString.value == fakeEmail && userPasswordString.value == fakePassword){
            self.hasSentData.value = true
        }
        else{
            self.hasSentData.value = false
        }
        
        //self.showNextView()
    }

    
}