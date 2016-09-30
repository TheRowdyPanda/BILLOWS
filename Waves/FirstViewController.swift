//
//  FirstViewController.swift
//  Waves
//
//  Created by Rijul Gupta on 9/19/16.
//  Copyright © 2016 Rijul Gupta. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {
    
    var cities:[City] = [
        City(withName: "New York",
            Location: (38.000, 14.000),
            coverImageLink: NSURL(string: "http://www.hilton.com/top-destinations/assets/uploads/hero-images/Destinations_Header_NewYork.jpg")!,
            countryName:"USA",
            stateName:"New York"),
        City(withName: "Barcelona",
            Location: (38.000, 14.000),
            coverImageLink: NSURL(string: "http://i160.photobucket.com/albums/t162/hotlyts24/fb-covers/places/spain/salamanca-spain.png")!,
            countryName:"Spain",
            stateName:nil),
        City(withName: "San Francisco",
            Location: (38.000, 14.000),
            coverImageLink: NSURL(string: "https://usastudenttour.com/wp-content/uploads/2011/04/Banner-SF-DMC-Baybridge.jpg")!,
            countryName:"USA",
            stateName:"California"),
        City(withName: "Miami Beach",
            Location: (38.000, 14.000),
            coverImageLink: NSURL(string: "http://www.pagecovers.com/covers/scenic/aerial_view_miami_beach.jpg")!,
            countryName:"USA",
            stateName:"Florida"),
        City(withName: "Cleveland",
            Location: (38.000, 14.000),
            coverImageLink: NSURL(string: "https://s-media-cache-ak0.pinimg.com/736x/91/cc/33/91cc3317bfd14d42cdddceb451ccc7af.jpg")!,
            countryName:"USA",
            stateName:"Ohio")
    ]
    
    var hasSignedIn = false;
    
//
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        print("Loaded First View")
    }
    
    override func viewDidAppear(animated: Bool) {
        print("Appeared First View")
        
//        /*weak var*/let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//        let gvc = mainStoryboard.instantiateViewControllerWithIdentifier("GmailScraper_ID") as! GmailScraper
//        
//        
//        self.navigationController?.pushViewController(gvc, animated: false)
        
//        usleep(500)
        
        
        let k = 3;
        
        switch k{
        case 1:
            self.goToScraperView()
            return
        case 2:
             self.goToSignInView()
            return
        case 3:
            self.goToCityListView()
            return
        case 4:
            self.goToWaveDashboardView()
            return
        default:
            print("IFJIFJ")
        }

        
    }
    
    func goToWaveDashboardView(){
        
//        let w = Wave(withId: "id1", completion: {
//            (result:Bool) in
//        })
        
        let waveDModel = WaveDashboardViewModel(withId:"id1", completion: {
            (result:Bool) in
        })
        
        
    }
    
    func goToMessageView(){
    }
    
    func goToScraperView(){
        
        
                /*weak var*/let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let gvc = mainStoryboard.instantiateViewControllerWithIdentifier("GmailImportViewController_ID") as! GmailImportViewController
        
        
                self.navigationController?.pushViewController(gvc, animated: false)
        
    }
    
    func goToCityListView(){
        
//        dispatch_async(dispatch_get_main_queue(), {
//            self.navigationController?.navigationItem.title = "WAVES"
//        })
//        
        
        let cityListViewModel = CityListViewModel(cities: cities)
        /*weak var*/let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        /*weak var*/let cityListViewController = mainStoryboard.instantiateViewControllerWithIdentifier("CityListViewController_ID") as! CityListViewController
        
        cityListViewController.setUpWith(cityListViewModel){
            // [weak self]
            (result:Bool) in
            
            
            (self.navigationController?.pushViewController(cityListViewController, animated: false))!
            
        }

        
    }
    
    func goToSignInView(){
        
        
        let signInViewModel = SignInViewModel()
        
        
        signInViewModel.userHomeTown = ""
        
        /*weak var*/let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        
        /*weak var*/let signInViewController = mainStoryboard.instantiateViewControllerWithIdentifier("SignInViewController_ID") as! SignInViewController
        signInViewController.firstViewDelegate = self
        signInViewController.setUpWith(signInViewModel){
            // [weak self]
            (result:Bool) in
            
            
            (self.navigationController?.pushViewController(signInViewController, animated: false))!
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

