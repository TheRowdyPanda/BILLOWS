//
//  GmailImportViewController.swift
//  Waves
//
//  Created by Rijul Gupta on 9/29/16.
//  Copyright © 2016 Rijul Gupta. All rights reserved.
//

import UIKit
import GTMOAuth2
import GoogleAPIClientForREST

class GmailImportViewController:UIViewController{
    
    
    var gmailImportModel:GmailImportViewModel?
    @IBOutlet weak var updateLabel1:UILabel!
    @IBOutlet weak var updateLabel2:UILabel!
    
    @IBOutlet weak var searchButton:UIButton!
    @IBOutlet weak var responseView:UITextView!
    
    override func viewDidLoad() {
        
       // responseView.userInteractionEnabled = false;
        
        
        gmailImportModel?.setupScraper({
            (result:Bool) in
            
            if(result == true){
                self.authenticateGmailScraper()
            }
            
        })
        
        
    }
    
    func authenticateGmailScraper(){
        
        gmailImportModel?.authenticateScraper2({
            (result:Bool) in
            
            self.bindModel()

            if(result == true){
                
                
                
                self.presentLoginController()
            }
        })
        
        
        
    }
    
    func bindModel(){
        self.gmailImportModel?.scraperString.producer.startWithNext({
            [weak self]
            next in
            self?.responseView.text = next
        })
        
        gmailImportModel?.dateString.producer.startWithNext({
            [weak self]
            next in
            self?.updateLabel1.text = next
        })
        
    }
    
    
    func presentLoginController(){
        let authCon = gmailImportModel?.gmailScraper?.createAuthController()
        presentViewController(authCon!, animated: true, completion: nil)
    }
    
    // Handle completion of the authorization process, and update the Gmail API
    // with the new credentials.
    func viewController(vc : UIViewController,
                        finishedWithAuth authResult : GTMOAuth2Authentication, error : NSError?) {
        
        if let error = error {
            
            gmailImportModel?.gmailScraper!.service.authorizer = nil
           // service.authorizer = nil
           // showAlert("Authentication Error", message: error.localizedDescription)
            return
        }
        
        gmailImportModel?.gmailScraper!.service.authorizer = nil
        //service.authorizer = authResult
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
   
    
    
}
