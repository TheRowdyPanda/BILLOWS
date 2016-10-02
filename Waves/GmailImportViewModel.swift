//
//  GmailImportViewModel.swift
//  Waves
//
//  Created by Rijul Gupta on 9/29/16.
//  Copyright © 2016 Rijul Gupta. All rights reserved.
//

import Foundation

class GmailImportViewModel{
    var gmailScraper:GmailScraper?
    
    
    func setupScraper(completion:(result:Bool)->Void){
        gmailScraper = GmailScraper()
        gmailScraper!.authenticate({
            (result:Bool) in

            completion(result: result)
            return
//            if(result == true){
//                self.authenticateScraper2()
//            }
        })
        
        //completion(result: false)
    }
    
    func authenticateScraper2(completion:(result:Bool)->Void){
        
        gmailScraper?.authenticate2({
            (tag:Int) in
            
            if(tag == 1){
                self.startFetch()
                completion(result: false)
                return
            }
            if(tag == 2){
                completion(result: true)
                return
                //self.presentLogin()
            }
            if(tag == 3){
                completion(result: false)
                return
                
            }
        
        })
        
    }
    
    func startFetch(){
        gmailScraper?.fetchLabels()
    }
    
    func presentLogin(){
        
//        let authCon = gmailScraper?.createAuthController()
//        presentViewController(
//                        authCon(),
//                        animated: true,
//                        completion: nil
//                    )
        
    }
    
    
    
}
