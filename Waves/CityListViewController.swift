//
//  CityListViewController.swift
//  Waves
//
//  Created by Rijul Gupta on 9/13/16.
//  Copyright © 2016 Rijul Gupta. All rights reserved.
//

import UIKit
import ReactiveCocoa
//import YSSegmentedControl


class CityListViewController: UIViewController {
    
    
    @IBOutlet weak var cityTableView:UITableView!
    @IBOutlet weak var searchBarView:UISearchBar!
    @IBOutlet weak var searchBarTextField:UITextField!
    
    var cityListViewModel:CityListViewModel!
    var imageCache:[NSURL: UIImage] = [NSURL: UIImage]()
    
    var hasLoadedInfoForNextViewModel:Bool = false;
    var hasBoundModel:Bool = false;
    var hasClickedCell:Bool = false;
    var cityIndex:NSIndexPath? = nil;
    
    
    @IBOutlet weak var customSCHolder:UIView!
    @IBOutlet weak var customSCHolderHeight:NSLayoutConstraint!
    var segmented:YSSegmentedControl!
    
    func setUpWith(viewModel:CityListViewModel, completion: (result: Bool) -> Void){
        self.cityListViewModel = viewModel
 
        completion(result: true)
        
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Loaded City View")
        self.navigationController?.navigationBarHidden = false
        self.navigationItem.backBarButtonItem = nil
        
        
        self.bindModel()
        
        
        
       
//        UINavigationBar.appearance().tintColor = UIColor.whiteColor()
//        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
//        
        
        //UINavigationBar.appearance().backgroundColor = UIColor(red: 24.0/255.0, green: 31.0/255.0, blue:41.0/255.0, alpha: 1.0)
        
       // self.navigationController?.navigationBar.backgroundColor = UIColor(red: 24.0/255.0, green: 31.0/255.0, blue:41.0/255.0, alpha: 1.0)
        
        
        //Changes the left hand bar button item. This will open up a side menu
        //Get the height of the navigation bar. Take out padding, subject to change.
        let barHeight = (self.navigationController?.navigationBar.frame.height)! - 8.0;
        
        
        //create the custom button
        let btn1 = UIButton()
        btn1.backgroundColor = UIColor.lightGrayColor()
        //set the image
    //    btn1.setImage(UIImage(named: "profile.png"), forState: .Normal)
        //set the frame
        btn1.frame = CGRectMake(0, 0, barHeight, barHeight)
        //add the selector function
        btn1.addTarget(self, action: #selector(CityListViewController.goToMyProfile), forControlEvents: .TouchUpInside)
        //set the left bar button item of the view's navigation item to our custom button! Looks nice.
        self.navigationItem.setLeftBarButtonItem(UIBarButtonItem(customView:btn1), animated: true);
        
        
        //create the custom button
        let btn2 = UIButton()
        btn2.backgroundColor = UIColor.darkGrayColor()
        //set the image
        //    btn1.setImage(UIImage(named: "profile.png"), forState: .Normal)
        //set the frame
        btn2.frame = CGRectMake(0, 0, barHeight, barHeight)
        //add the selector function
        btn2.addTarget(self, action: #selector(CityListViewController.setupSearchView), forControlEvents: .TouchUpInside)
        //set the left bar button item of the view's navigation item to our custom button! Looks nice.
      //  self.navigationItem.setLeftBarButtonItem(UIBarButtonItem(customView:btn1), animated: true);
        self.navigationItem.setRightBarButtonItem(UIBarButtonItem(customView:btn2), animated: true)
        
        

        self.cityTableView.delegate = self
        self.cityTableView.dataSource = self
        
        
        //This sets up a thread to load the information about waves in each city. We start loading this information before we need it, therefore we can present it as soon as possible.
        self.cityListViewModel.loadWavePreviewsForCities()
        
        
        
        
        
        
        
        let segmentedHeight:CGFloat = 54.0;
        

        let k2:[String] = ["Latest", "Trending", "Featured"]
        let segmented = YSSegmentedControl(
            frame: CGRect(
                x: 0,
                y: segmentedHeight + 20.0,
                width: view.frame.size.width,
                height: segmentedHeight),
            titles:k2,
            action: {
                control, index in
                print("segmented did pressed \(index)")
        })
        
        
        
        //        self.navigationItem.titleView?.frame = CGRect(x:0, y: 0, width: self.navigationItem.titleView!.frame.width, height: 200)
        //        self.navigationItem.titleView?.addSubview(segmented)
        //  self.navigationController?.navigationBar.frame = CGRectMake(0, 0, self.view.frame.width, 200)
        // self.navigationController?.navigationBar.addSubview(segmented)
        // self.view.addSubview(segmented)
        //   self.view.addSubview(segmented)
//        
//        var navBar = self.navigationController?.navigationBar
//        var navBarHeight = navBar?.frame.height
//        var ProgressFrame = segmented.frame
//        var pSetX = ProgressFrame.origin.x
//        var pSetY = CGFloat(navBarHeight!)
//        var pSetWidth = self.view.frame.width
//        
//        
        
        segmented.frame = CGRectMake(0, 0, self.view.frame.width, segmentedHeight)
        
        
        //add a custom appearance to our segmented controller
        let appearance = YSSegmentedControlAppearance(
            backgroundColor: UIColor(red: 24.0/255.0, green: 31.0/255.0, blue:41.0/255.0, alpha: 1.0),
            selectedBackgroundColor: UIColor(red: 38.0/255.0, green: 45.0/255.0, blue:55.0/255.0, alpha: 1.0),
            
            textColor: UIColor.grayColor(),
            font: UIFont.systemFontOfSize(15),
            
            selectedTextColor: UIColor.grayColor(),
            selectedFont: UIFont.systemFontOfSize(15),
            
            bottomLineColor: UIColor.lightGrayColor(),
            selectorColor: UIColor.lightGrayColor(),
            
            bottomLineHeight: 0.5,
            selectorHeight: 2)
        
        segmented.appearance = appearance
        
        //how to add custom images to our custom segmented controller
        
        let viewWidth:CGFloat = 20.0;
        let middlex:CGFloat = (((self.view.frame.width/3.0) - viewWidth)/2.0)
        
        let segmentedButton1 = UIView(frame: CGRect(x: middlex, y: -5.0, width: viewWidth, height: viewWidth))
        segmentedButton1.backgroundColor = UIColor.lightGrayColor()
        segmented.items[0].label.addSubview(segmentedButton1)
        
        let lFrame1 = segmented.items[0].label.frame;
        
        segmented.items[0].label.frame = CGRectMake((lFrame1.origin.x), (lFrame1.origin.y) + 10.0, (lFrame1.width), (lFrame1.height));
        
        
        
        let segmentedButton2 = UIView(frame: CGRect(x: middlex, y: -5.0, width: viewWidth, height: viewWidth))
        segmentedButton2.backgroundColor = UIColor.lightGrayColor()
        segmented.items[1].label.addSubview(segmentedButton2)
        
        let lFrame2 = segmented.items[1].label.frame;
        
        segmented.items[1].label.frame = CGRectMake((lFrame2.origin.x), (lFrame2.origin.y) + 10.0, (lFrame2.width), (lFrame2.height));
        
        
        
        let segmentedButton3 = UIView(frame: CGRect(x: middlex, y: -5.0, width: viewWidth, height: viewWidth))
        segmentedButton3.backgroundColor = UIColor.lightGrayColor()
        segmented.items[2].label.addSubview(segmentedButton3)
        
        let lFrame3 = segmented.items[2].label.frame;
        
        segmented.items[2].label.frame = CGRectMake((lFrame3.origin.x), (lFrame3.origin.y) + 10.0, (lFrame3.width), (lFrame3.height));
        
        
        
       // self.view.addSubview(segmented)
        self.customSCHolderHeight.constant = segmentedHeight
        self.customSCHolder.addSubview(segmented);

        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
 
        
    }
    
    func bindModel(){
        self.cityListViewModel!.hasLoadedPreviewsForSelectedWave
            .producer
            .startWithNext({
                [weak self]
                next in
                if(next == true){
                    self?.hasLoadedInfoForNextViewModel = true
                    self!.showCityFocusView()
                }
                else{
                    self?.hasLoadedInfoForNextViewModel = false
                }
                print("Has Loaded Info:\(self?.hasLoadedInfoForNextViewModel)")
                })
        
        
//        self.cityListViewModel!.searchString <~ self.searchBarTextField.rac_textSignal()
//            .toSignalProducer()
//            .map { ($0 as? String) ?? "" }
//            .flatMapError { _ in SignalProducer<String, NoError>.empty }
        
      //  self.cityListViewModel!.searchString <~ self.searchBarView.text
        self.hasBoundModel = true
        
    }
    
    func showCityFocusView(){
        
//        if(self.hasBoundModel == false){
//            return
//        }
        if(self.hasLoadedInfoForNextViewModel == false){
            //return
        }
        if(cityIndex == nil){
            return
        }
        
        let city = self.cityListViewModel.cityToSend!
                let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC)))
                dispatch_after(delayTime, dispatch_get_main_queue()) {

        }
       // let city = self.cityListViewModel.cityForIndexPath(cityIndex!)

        weak var cityFocusViewModel = CityFocusViewModel(withCity: city)
        
        
        
        /*weak var*/let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        weak var cityFocusViewController = mainStoryboard.instantiateViewControllerWithIdentifier("CityFocusViewController_ID") as! CityFocusViewController
        
        cityFocusViewController!.setUpWith(cityFocusViewModel!){
             [weak self]
            (result:Bool) in
            self!.navigationController?.pushViewController(cityFocusViewController!, animated: true)
            
        }

    }
    
    func goToMyProfile(){
        
        
        let waveP1 = WavePreview()
        waveP1.name.value = "Coool party"
        waveP1.cityName.value = "Las Vegas, NV"
        waveP1.imageLink.value = NSURL(string: "https://upload.wikimedia.org/wikipedia/commons/e/eb/The_Adicts_2011_SO36_03.jpg")
        
        let waveP2 = WavePreview()
        waveP2.name.value = "Fun times, good times"
        waveP2.imageLink.value = NSURL(string: "https://upload.wikimedia.org/wikipedia/commons/c/cb/BackyardParty.jpg")
        
        let waveP3 = WavePreview()
        waveP3.name.value = "New york fun times"
        waveP3.imageLink.value = NSURL(string: "http://previews.123rf.com/images/somatuscani/somatuscani1506/somatuscani150600004/41952081-NEW-YORK-CITY-JUNE-11-People-having-fun-with-the-Screen-Shows-in-Times-Square-one-of-the-most-visite-Stock-Photo.jpg")
        
        let waveP4 = WavePreview()
        waveP4.name.value = "Bachelor Party!"
        waveP4.imageLink.value = NSURL(string: "http://www.partybusdetroit.com/assets/img/bachelor-party.jpg")
        
        let waveP5 = WavePreview()
        waveP5.name.value = "Coool party"
        waveP5.imageLink.value = NSURL(string: "http://www.partybusdetroit.com/assets/img/bachelor-party.jpg")
        
        let waveP6 = WavePreview()
        waveP6.name.value = "Coool party"
        waveP6.imageLink.value = NSURL(string: "http://www.partybusdetroit.com/assets/img/bachelor-party.jpg")
        
        
        let waveP7 = WavePreview()
        waveP7.name.value = "Coool party"
        waveP7.imageLink.value = NSURL(string: "http://www.partybusdetroit.com/assets/img/bachelor-party.jpg")
        
        
        let wavePs = [waveP1, waveP2, waveP3, waveP4, waveP5, waveP6, waveP7, ]
        
        
       // let city = self.cityListViewModel.cityToSend!
        var user = User(withId: "289192");
        user.firstName.value = "Rijul"
        user.lastName.value = "Gupta"
        user.homeTown.value = "San Francisco"
        user.homeCityState.value = "CA"
        user.numberFriends.value = 23
        user.numberMiles.value = 5002
        user.numberWaves.value = wavePs.count
        
        user.recentWavePreviews = wavePs
        
        // let city = self.cityListViewModel.cityForIndexPath(cityIndex!)
        
        let profileViewModel = ProfileViewModel(user: user)
        
        profileViewModel.bindUser()

       
        
        /*weak var*/let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        /*weak var*/let profileViewController = mainStoryboard.instantiateViewControllerWithIdentifier("ProfileViewController_ID") as! ProfileViewController
        
        profileViewController.setUpWith(profileViewModel, completion: {
            (result:Bool) in
            (self.navigationController?.pushViewController(profileViewController, animated: true))!
            
        })
        

    }
    
    func setupSearchView(){
        
        
        switch self.searchBarView.alpha {
            case 0.0:
                UIView.animateWithDuration(0.2, animations: {
                    self.searchBarView.alpha = 1.0
                    self.searchBarView.userInteractionEnabled = true
                })
            case 1.0:
                UIView.animateWithDuration(0.2, animations: {
                    self.searchBarView.alpha = 0.0
                    self.resignFirstResponder()
                    self.searchBarView.userInteractionEnabled = false
                })
            default:
                print("DID CLICK SEARCH VIEW")
        }
//        UIView.animateWithDuration(0.2, animations: {
//            self.searchBarView.alpha = 1.0
//            self.searchBarView.userInteractionEnabled = true
//        })
    }
    
}


extension CityListViewController:UITableViewDelegate, UITableViewDataSource{
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cityListViewModel.cities.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! CityTableCell
        
        //self.cityListViewModel.cityForIndexPath(indexPath)
        
        let city = self.cityListViewModel.cityForIndexPath(indexPath)
        
        self.cityIndex = indexPath
        
        self.showCityFocusView()
        print("CLICKED ROW")
        print(city.hasFinishedLoadingWavePreviews.value)
      //  print(city.hasFinishedLoadingWavePreviews)
    }
    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        1
//    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let preCell = tableView.dequeueReusableCellWithIdentifier("CityTableCell_ID", forIndexPath: indexPath) as! CityTableCell
        
        
        let cell = self.cityListViewModel.cityCellForIndexPath(indexPath, cell:preCell)
//        
//        let url = cell.cityImageLink
//        var image = self.imageCache[url]
//        if( image == nil ) {
// 
//            // If the image does not exist, we testImage to download it
//            var imgURL:NSURL = url
//            
//            // Download an NSData representation of the image at the URL
//            let request: NSURLRequest = NSURLRequest(URL: imgURL)
//            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?) -> Void in
//                if error == nil {
//                    image = UIImage(data: data!)
//                    
//                    // Store the image in to our cache
//                    self.imageCache[url] = image
//                    dispatch_async(dispatch_get_main_queue(), {
//                        if let cellToUpdate = tableView.cellForRowAtIndexPath(indexPath) as? CityTableCell{
//                            cellToUpdate.coverImage?.image = image
//                            
//                        }
//                    })
//                }
//                else {
//                    print("Error: \(error!.localizedDescription)")
//                  //  Crashlytics.sharedInstance().recordError(error!)
//                }
//            })
//            
//        }
//        else {
//            dispatch_async(dispatch_get_main_queue(), {
//                if let cellToUpdate = tableView.cellForRowAtIndexPath(indexPath) as? CityTableCell{
//                    cellToUpdate.coverImage?.image = image
//                    
//                }
//            })
//        }
        
        
        
//
//        
//        
//        
        return cell
    }
    

}


extension NSCoder {
    class func empty() -> NSCoder {
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.finishEncoding()
        return NSKeyedUnarchiver(forReadingWithData: data)
    }
}


