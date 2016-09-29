//
//  SignUpViewController.swift
//  Waves
//
//  Created by Rijul Gupta on 9/13/16.
//  Copyright © 2016 Rijul Gupta. All rights reserved.
//

import UIKit
import ReactiveCocoa

class SignUpViewController:UIViewController{
    
    //This text field allows the user to input their email
    @IBOutlet weak var userEmailTextField:UITextField?
    
    //This text field allows the user to input their password
    @IBOutlet weak var userPassWordTextField:UITextField?
    
    //This button allows the user to submit their information for login
    @IBOutlet weak var signupButton:UIButton?
    
    //This button allows the user to login through facebook
    @IBOutlet weak var signupFacebookButton:UIButton?
    
    //This label allows the user to create an account. Will initiate the create account flow
    @IBOutlet weak var createAccountLabel:UILabel?
    
    //This label allows the user to ask for a password reminder. It will probably be sent to their email.
    @IBOutlet weak var forgotPasswordLabel:UILabel?
    
    
    //A boolean to store whether we have completed binding the model. This prevents some initial values from calling functions.
    var hasBoundModel = false
    
    var signUpViewModel:SignUpViewModel?
    
    weak var firstViewDelegate:FirstViewController?
    
    func setUpWith(viewModel:SignUpViewModel, completion: (result: Bool) -> Void){
        self.signUpViewModel = viewModel
        completion(result: true)
        
    }

    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        

        self.navigationController?.navigationBarHidden = true
        
        //This function sets up all the two-way data binding
       self.bindModel()
        
        
        
        
        print("Loaded Sign Up View")
    }
    
    func bindModel(){
        
        
        //This binds the string that stores the user email in our view model to the text of our user email text field on the view controller.
        self.signUpViewModel!.userEmailString <~ (self.userEmailTextField?.rac_textSignal()
            .toSignalProducer()
            .map { ($0 as? String) ?? "" }
            .flatMapError { _ in SignalProducer<String, NoError>.empty })!
        
        //This binds the string that stores the user password in our view model to the text of our user password text field on the view controller.
        self.signUpViewModel!.userPasswordString <~ (self.userPassWordTextField?.rac_textSignal()
            .toSignalProducer()
            .map { ($0 as? String) ?? "" }
            .flatMapError { _ in SignalProducer<String, NoError>.empty })!
        
        
        
        
        
        //This binds the status of the sign up button to a value on our view model that represents whether the entered data is acceptable.
        //       DynamicProperty(object: self.signupButton, keyPath: "hidden") <~ self.signUpViewModel!.hasCompletedFields.producer.map{$0 as Bool}
        
        //        This is another way of doing the same thing. It sets up an event listener to detect changes in the boolean stored in our view model. When that changes, then we edit the status of our sign in button.
        //        self.signUpViewModel!.hasCompletedFields
        //            .producer
        //            .startWithNext({
        //                [weak self]
        //                next in
        //                self!.signupButton?.enabled = next
        //        })
        
        
        //We call a function when the sign up button is pressed.
         self.signupButton!.addTarget(self, action: #selector(SignUpViewController.sendInfoToServer), forControlEvents: .TouchUpInside)
        
        //We listen for changes in a boolean on our view model that represents whether the information has been successfully sent to our servers.
        self.signUpViewModel!.hasSentData
            .producer
            .startWithNext({
                [weak self]
                next in
                if(next == true){
                    
                    
                    self?.hasCompletedEverything()
                }
                else{
                    self?.couldNotFindUser()
                }
                })
        
        
        
       
        

        
//        self.signupButton?.targetForAction(Selector(self.sendInfoToServer()), withSender: nil)
        

        hasBoundModel = true;

        
    }
   
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            print("test")
        }
        
        
//            usleep(200)
//            dispatch_async(dispatch_get_main_queue()) {
//                self.navigationController?.popViewControllerAnimated(false)
//            }

    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func sendInfoToServer(){
        //We want to send the information stored in our view model to servers. This is best done on the view model itself.
        self.signUpViewModel!.submitInformationToServers()
    }
    
    func hasCompletedEverything(){
        //We call this when everything on this view controller is completed. We alter the state of our root view controller (to reflect the fact the we now have an user with an active account), and then push back to this root view controller.
        dispatch_async(dispatch_get_main_queue()) {
            //we tell our first view that the user has signed in
            self.firstViewDelegate!.hasSignedIn = true
            //we pass the user object so it can be pushed through our app
            //self.firstViewDelegate!.user = self.signUpViewModel.user
            //finally, we push to our root view controller
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
    func couldNotFindUser(){
        
        if(hasBoundModel == false){
            return
        }
        
        let alert = UIAlertController(title: "Couldn't find user", message:"Are you sure you have the right credentials?", preferredStyle: .Alert)
        let action = UIAlertAction(title: "Damnit", style: .Default) { _ in
            

            
        }
        alert.addAction(action)
        self.presentViewController(alert, animated: true){}
        

        
    }
    
}
