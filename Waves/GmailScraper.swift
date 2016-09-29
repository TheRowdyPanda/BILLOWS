//
//  GmailScraper.swift
//  Waves
//
//  Created by Rijul Gupta on 9/27/16.
//  Copyright © 2016 Rijul Gupta. All rights reserved.
//

import Foundation
import GoogleAPIClientForREST
import GTMOAuth2

class GmailScraper: UIViewController{
    private let kKeychainItemName = "Gmail API"
    private let kClientID = "134050187459-p3ekcrrjr5d8u0222q1mml423f7s0r74.apps.googleusercontent.com"
    
    // If modifying these scopes, delete your previously saved credentials by
    // resetting the iOS simulator or uninstall the app.
    private let scopes = [kGTLRAuthScopeGmailReadonly]
    
    
    private let service = GTLRGmailService()
    let output = UITextView()
    
    override func viewDidLoad() {
        
        output.frame = view.bounds
        output.editable = false
        output.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        output.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
        
        view.addSubview(output);
        
        
        self.authenticate()
    }
    
    override func viewDidAppear(animated: Bool) {
        self.authenticate2()
    }
    func authenticate(){
        
        if let auth = GTMOAuth2ViewControllerTouch.authForGoogleFromKeychainForName(
            kKeychainItemName,
            clientID: kClientID,
            clientSecret: nil) {
            service.authorizer = auth
        }
    }
    
    func authenticate2(){
        
        if let authorizer = service.authorizer,
            canAuth = authorizer.canAuthorize where canAuth {
            fetchLabels()
        } else {
            presentViewController(
                createAuthController(),
                animated: true,
                completion: nil
            )
        }
        

    }
    
        // Construct a query and get a list of upcoming labels from the gmail API
        func fetchLabels() {
            output.text = "Getting labels..."
            
            //let query = GTLRGmailQuery_UsersMessagesList.queryWithUserId("me")
            
            
          //  let query = GTLRGmailQuery_UsersGetProfile.queryWithUserId("me")
            
            let query = GTLRGmailQuery_UsersMessagesList.queryWithUserId("me")
            
            
           // let query = GTLRGmailQuery_UsersThreadsList.queryWithUserId("me")
            //query.pageToken = "02760003637517959449"
            //let query = GTLRGmailQuery_UsersLabelsList.queryWithUserId("me")
//            service.setValue("03731952486502015387", forKey: "pageToken")
            
            
             dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
            self.service.executeQuery(query,
                                 delegate: self,
                                 didFinishSelector: "displayResultWithTicket:finishedWithObject:error:"
            )
            })
            
        }
    
//    // When the view loads, create necessary subviews
//    // and initialize the Gmail API service
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        output.frame = view.bounds
//        output.editable = false
//        output.contentInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
//        output.autoresizingMask = [.FlexibleHeight, .FlexibleWidth]
//        
//        view.addSubview(output);
//        
//        if let auth = GTMOAuth2ViewControllerTouch.authForGoogleFromKeychainForName(
//            kKeychainItemName,
//            clientID: kClientID,
//            clientSecret: nil) {
//            service.authorizer = auth
//        }
//        
//    }
    
//    // When the view appears, ensure that the Gmail API service is authorized
//    // and perform API calls
//    override func viewDidAppear(animated: Bool) {
//        if let authorizer = service.authorizer,
//            canAuth = authorizer.canAuthorize where canAuth {
//            fetchLabels()
//        } else {
//            presentViewController(
//                createAuthController(),
//                animated: true,
//                completion: nil
//            )
//        }
//    }
    
//    // Construct a query and get a list of upcoming labels from the gmail API
//    func fetchLabels() {
//        output.text = "Getting labels..."
//        
//        let query = GTLRGmailQuery_UsersLabelsList.queryWithUserId("me")
//        service.executeQuery(query,
//                             delegate: self,
//                             didFinishSelector: "displayResultWithTicket:finishedWithObject:error:"
//        )
//    }
    
    func displayResultWithTicket2(ticket : GTLRServiceTicket,
                                 finishedWithObject labelsResponse : GTLRGmail_Message,
                                                    error : NSError?) {
        
        
        
        if let error = error {
            showAlert("Error", message: error.localizedDescription)
            return
        }
        
        print("Message")
        let snippet = labelsResponse.snippet
        print(labelsResponse.payload)
        let since = (labelsResponse.internalDate?.doubleValue)!/1000.0;
        print("DATE")
        
        print(NSDate(timeIntervalSince1970: since))
       
        
        let wordChecker = ["Delta", "Airlines", "Flight"]
        
        for w in wordChecker{
            if((snippet?.lowercaseString.rangeOfString(w.lowercaseString)) != nil){
                print(snippet)
                
                
                
            }
        }
        
    }
    // Display the labels in the UITextView
    func displayResultWithTicket(ticket : GTLRServiceTicket,
                                 finishedWithObject labelsResponse : GTLRGmail_ListMessagesResponse,
                                                    error : NSError?) {
        
        if let error = error {
            showAlert("Error", message: error.localizedDescription)
            return
        }
        
      //  print(labelsResponse)
        
        let np = labelsResponse.nextPageToken;
        let query = GTLRGmailQuery_UsersMessagesList.queryWithUserId("me")
        
        query.pageToken = np
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
        self.service.executeQuery(query,
                             delegate: self,
                             didFinishSelector: "displayResultWithTicket:finishedWithObject:error:"
        )
        })
        
        
        let m = labelsResponse.messages
      //  print(m)
        for m2 in m!{
         //   print(m2)
//            let snippet = m2.snippet
//            print(snippet)
            let m3 = m2.identifier
            
            let query = GTLRGmailQuery_UsersMessagesGet.queryWithUserId("me", identifier: m3!)

            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
                
            self.service.executeQuery(query, delegate: self,
                didFinishSelector: "displayResultWithTicket2:finishedWithObject:error:"
            )
            })
        }
        var labelString = ""
        output.text = labelString
    }
    

    
//    // Display the labels in the UITextView
//    func displayResultWithTicket(ticket : GTLRServiceTicket,
//                                 finishedWithObject labelsResponse : GTLRGmail_ListThreadsResponse,
//                                                    error : NSError?) {
//        
//        if let error = error {
//            showAlert("Error", message: error.localizedDescription)
//            return
//        }
//        
//        print(labelsResponse)
//        let t = labelsResponse.threads?.first?.messages
//        print(labelsResponse.threads)
//        for t in labelsResponse.threads!{
//            print("new thread")
//            print("\n")
//            print(t.snippet)
//        }
//        
//        
//        var labelString = ""
//        output.text = labelString
//    }
//    
    
//    
    // Creates the auth controller for authorizing access to Gmail API
    private func createAuthController() -> GTMOAuth2ViewControllerTouch {
        let scopeString = scopes.joinWithSeparator(" ")
        return GTMOAuth2ViewControllerTouch(
            scope: scopeString,
            clientID: kClientID,
            clientSecret: nil,
            keychainItemName: kKeychainItemName,
            delegate: self,
            finishedSelector: "viewController:finishedWithAuth:error:"
        )
    }
    
    // Handle completion of the authorization process, and update the Gmail API
    // with the new credentials.
    func viewController(vc : UIViewController,
                        finishedWithAuth authResult : GTMOAuth2Authentication, error : NSError?) {
        
        if let error = error {
            service.authorizer = nil
            showAlert("Authentication Error", message: error.localizedDescription)
            return
        }
        
        service.authorizer = authResult
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // Helper for showing an alert
    func showAlert(title : String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: UIAlertControllerStyle.Alert
        )
        let ok = UIAlertAction(
            title: "OK",
            style: UIAlertActionStyle.Default,
            handler: nil
        )
        alert.addAction(ok)
        presentViewController(alert, animated: true, completion: nil)
    }
    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    

}