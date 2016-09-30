//
//  GmailImportViewController.swift
//  Waves
//
//  Created by Rijul Gupta on 9/29/16.
//  Copyright © 2016 Rijul Gupta. All rights reserved.
//

import UIKit

class GmailImportViewController:UIViewController{
    
    
    @IBOutlet weak var updateLabel1:UILabel!
    @IBOutlet weak var updateLabel2:UILabel!
    
    @IBOutlet weak var searchButton:UIButton!
    @IBOutlet weak var responseView:UITextView!
    
    override func viewDidLoad() {
        
        responseView.userInteractionEnabled = false;
        
    }
    
    
}
