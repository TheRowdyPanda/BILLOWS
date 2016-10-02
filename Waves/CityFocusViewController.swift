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
    
    var imageCache:[NSURL: UIImage] = [NSURL: UIImage]()
    
    var wavePreviewCount = 0;
    
    
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
        
        
        wavePreviewCollectionView.registerNib(UINib(nibName: "CityFocusHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CityFocusHeaderView_ID")
        
        
        wavePreviewCollectionView.registerNib(UINib(nibName: "WavePreviewHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "WavePreviewHeaderView_ID")
        
        
        
        //We also need to register the wave preview cell. This will hold all the wave info, and load the rest of the wave info in the background.
        wavePreviewCollectionView.registerNib(UINib(nibName: "WavePreviewCell", bundle: nil), forCellWithReuseIdentifier: "WavePreviewCell_ID")
        
        
        
        self.wavePreviewCollectionView.delegate = self
        self.wavePreviewCollectionView.dataSource = self
        
        self.bindModel()
        print("Loaded Sign Up View")
    }
    
    func bindModel(){
        
        self.cityFocusViewModel.wavePreviewCount.producer.startWithNext({
            next in
            
            if(next == self.wavePreviewCount){
                
            }
            else{
                self.wavePreviewCount = next
                
               /// dispatch_async(dispatch_get_main_queue(), {
                    
                        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC)))
                        dispatch_after(delayTime, dispatch_get_main_queue()) {
                
                            dispatch_async(dispatch_get_main_queue(), {
                                
                                
                    self.wavePreviewCollectionView.reloadData()
                            })
                            
                }
               // })
            }
        })
        
       
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


extension CityFocusViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section{
        case 0:
            return 0
        case 1:
            return wavePreviewCount
        default:
            return 0
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("CLICK")
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let preCell = collectionView.dequeueReusableCellWithReuseIdentifier("WavePreviewCell_ID", forIndexPath: indexPath) as! WavePreviewCell
        
        let cell = self.cityFocusViewModel?.wavePreviewCellForIndex(indexPath, cell: preCell)
        
       // let cell = self.profileViewModel?.wavePreviewCellForIndex(indexPath, cell: preCell)
        
        let url = cell!.cityImageLink
        
        
        var image = self.imageCache[url!]
        if( image == nil ) {
            
            // If the image does not exist, we testImage to download it
            var imgURL:NSURL = url!
            
            // Download an NSData representation of the image at the URL
            let request: NSURLRequest = NSURLRequest(URL: imgURL)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?) -> Void in
                if error == nil {
                    image = UIImage(data: data!)
                    
                    // Store the image in to our cache
                    self.imageCache[url!] = image
                    dispatch_async(dispatch_get_main_queue(), {
                        if let cellToUpdate = collectionView.cellForItemAtIndexPath(indexPath) as? WavePreviewCell{
                            cellToUpdate.coverImageView?.image = image
                            
                        }
                    })
                }
                else {
                    print("Error: \(error!.localizedDescription)")
                    //  Crashlytics.sharedInstance().recordError(error!)
                }
            })
            
        }
        else {
            dispatch_async(dispatch_get_main_queue(), {
                if let cellToUpdate = collectionView.cellForItemAtIndexPath(indexPath) as? WavePreviewCell{
                    cellToUpdate.coverImageView?.image = image
                    
                }
            })
        }
        
        
        
        //     cell.heartsLabel.text = "12"
        
        return cell!
    }
    //
    //    func collectionView(collectionView:UICollectionView, layout:UICollectionViewLayout:UICollectionViewLayout, )
    //
    //    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize{
    //
    //        let padding:CGFloat = 5.0
    //        let width = (self.view.frame.width)/2.0
    //        let height = width*(5.0/4.0)
    //        return CGSizeMake(width, height)
    //    }
    //
    func collectionView(collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
        referenceSizeForHeaderInSection section: Int) -> CGSize {
        
        if(section == 1){
            let width = self.view.frame.width
            let height:CGFloat = 40.0;
            return CGSizeMake(width, height)
        }
        
        let width = self.view.frame.width
        let height = width*(4.2/4.0)
        return CGSizeMake(width, height)
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionElementKindSectionHeader:
            
            if (indexPath.section == 0){
                
                let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "CityFocusHeaderView_ID", forIndexPath: indexPath) as! CityFocusHeaderView
                

                headerView.setUpWith(self.cityFocusViewModel.city, completion: {
                    (result:Bool) in
                    headerView.bindModel()
                })
                return headerView
            }
            else{
                let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "WavePreviewHeaderView_ID", forIndexPath: indexPath) as! WavePreviewHeaderView
                
                return headerView
                
            }
            
        case UICollectionElementKindSectionFooter:
            let footerView = UICollectionReusableView()
            footerView.backgroundColor = UIColor.greenColor();
            return footerView
            
        default:
            
            assert(false, "Unexpected element kind")
        }
        
        
    }
}

