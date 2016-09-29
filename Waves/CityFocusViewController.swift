//
//  CityFocusViewController.swift
//  Waves
//
//  Created by Rijul Gupta on 9/21/16.
//  Copyright © 2016 Rijul Gupta. All rights reserved.
//

import UIKit

class CityFocusViewController:UIViewController{
    
    var hasBoundModel:Bool = false
    var cityFocusViewModel:CityFocusViewModel!
    @IBOutlet weak var wavePreviewCollectionView:UICollectionView!
    
    func setUpWith(viewModel:CityFocusViewModel, completion: (result: Bool) -> Void){
        self.cityFocusViewModel = viewModel
        completion(result: true)
        
    }

    
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    
        
        //Changes the left hand bar button item. This will open up a side menu
        //Get the height of the navigation bar. Take out padding, subject to change.
        let barHeight = (self.navigationController?.navigationBar.frame.height)! - 8.0;
        
        //create the custom button
        let btn2 = UIButton()
        btn2.backgroundColor = UIColor.darkGrayColor()
        //set the image
        //    btn1.setImage(UIImage(named: "profile.png"), forState: .Normal)
        //set the frame
        btn2.frame = CGRectMake(0, 0, barHeight, barHeight)
        //add the selector function
        btn2.addTarget(self, action: Selector("setupSearchView"), forControlEvents: .TouchUpInside)
        //set the left bar button item of the view's navigation item to our custom button! Looks nice.
        //  self.navigationItem.setLeftBarButtonItem(UIBarButtonItem(customView:btn1), animated: true);
        self.navigationItem.setRightBarButtonItem(UIBarButtonItem(customView:btn2), animated: true)
        
        
        self.bindModel()
        print("Loaded Sign Up View")
    }
    
    func bindModel(){
        
        
       
        hasBoundModel = true;
        
        
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
}
