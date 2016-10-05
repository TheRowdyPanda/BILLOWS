//
//  CityFocusViewController.swift
//  Waves
//
//  Created by Rijul Gupta on 9/21/16.
//  Copyright © 2016 Rijul Gupta. All rights reserved.
//

import UIKit

class CityFocusViewController:UIViewController{
    
    deinit{
        print("HELLO")
        
        
        print("GOODBYE")
    }
    
    var hasBoundModel:Bool = false
    weak var cityFocusViewModel:CityFocusViewModel!
    
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
    
        
        //We hide the navigation bar.
        
//        
        self.navigationController?.navigationBarHidden = true
        
        
        wavePreviewCollectionView.registerNib(UINib(nibName: "CityFocusHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "CityFocusHeaderView_ID")
        
        
        wavePreviewCollectionView.registerNib(UINib(nibName: "WavePreviewHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "WavePreviewHeaderView_ID")
        
        
        
        //We also need to register the wave preview cell. This will hold all the wave info, and load the rest of the wave info in the background.
        wavePreviewCollectionView.registerNib(UINib(nibName: "WavePreviewCell", bundle: nil), forCellWithReuseIdentifier: "WavePreviewCell_ID")
        
        
        
        self.wavePreviewCollectionView.delegate = self
        self.wavePreviewCollectionView.dataSource = self
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let leftPadding:CGFloat = 8.0;
        let width = (self.view.frame.width - leftPadding*2.0);
        let height = width*(2.5/4.0)
        layout.sectionInset = UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: leftPadding)
        layout.itemSize = CGSize(width: width, height: height)
        
        
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 25
        self.wavePreviewCollectionView.collectionViewLayout = layout
        
        
        self.bindModel()
        
//        self.testit({
//            [weak self]
//            (result:Bool) in
//            print("DONE")
////            
////            sleep(2)
//////            
////            dispatch_async(dispatch_get_main_queue(), {
////            [weak self] in
////                self!.navigationController?.popViewControllerAnimated(true)
////            })
//        })
//
//        
        
        print("Loaded Sign Up View")
    }
    
    func testit(completion:(result:Bool)->Void){
        dispatch_async(dispatch_get_global_queue (DISPATCH_QUEUE_PRIORITY_HIGH, 0), {
            for index in 0...20{
                let x:CGFloat = 10.0*CGFloat(index) + 40.0
                let width:CGFloat = 200.0;
                let imageView = UIImageView(frame: CGRectMake(x, x, width, width))
                
                let url = NSURL(string: "http://www.partybusdetroit.com/assets/img/bachelor-party.jpg")
                let image = UIImage(data: NSData(contentsOfURL: url!)!)
                imageView.image = image
                imageView.backgroundColor = UIColor.redColor()
                dispatch_async(dispatch_get_main_queue(), {
                    self.view.addSubview(imageView)
                })
            }
            completion(result: true)
        })
        
    }
    func bindModel(){
//        
        self.cityFocusViewModel.wavePreviewCount.producer.startWithNext({
            [weak self]
            next in
            
            if(next == self!.wavePreviewCount){
                
            }
            else{
                self!.wavePreviewCount = next
                
               /// dispatch_async(dispatch_get_main_queue(), {
                
                            dispatch_async(dispatch_get_main_queue(), {
                                [weak self] in
                                
                                
                                    self!.wavePreviewCollectionView.reloadData()
                            })
                            
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
    
    override func viewDidLayoutSubviews() {
       // sleep(5)
        
    }

    
    func didSelectBackButton(){
        
        dispatch_async(dispatch_get_main_queue(), {
            [weak self] in
            self!.navigationController?.popViewControllerAnimated(true)
        })
//
        //  self.removeFromParentViewController()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
         self.navigationController?.navigationBarHidden = false
    }
    
    
}

//
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
        
        
        let waveP = cityFocusViewModel.wavePreviewForIndexPath(indexPath)
        
        
        var waveDashboardViewModel = WaveDashboardViewModel()
        waveDashboardViewModel.setupWithWavePreview(waveP)
        
        
        
        
        
        /*weak var*/let mainStoryboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        weak var waveDashboardViewController = mainStoryboard.instantiateViewControllerWithIdentifier("WaveDashboardViewController_ID") as! WaveDashboardViewController
        
        waveDashboardViewController!.setUpWith(waveDashboardViewModel){
            [weak self]
            (result:Bool) in
            self!.navigationController?.pushViewController(waveDashboardViewController!, animated: true)
            
        }
        
        
        print("CLICK")
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        weak var preCell = collectionView.dequeueReusableCellWithReuseIdentifier("WavePreviewCell_ID", forIndexPath: indexPath) as! WavePreviewCell
        
        weak var cell = cityFocusViewModel?.wavePreviewCellForIndex(indexPath, cell: preCell!)
////        
////        
//        let url = cell!.cityImageLink
//        
////        
//        var image = self.imageCache[url!]
//        if( image == nil ) {
//            
//            // If the image does not exist, we testImage to download it
//            var imgURL:NSURL = url!
//            
//            // Download an NSData representation of the image at the URL
//            let request: NSURLRequest = NSURLRequest(URL: imgURL)
//            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {(response: NSURLResponse?,data: NSData?,error: NSError?) -> Void in
//                if error == nil {
//                    image = UIImage(data: data!)
//                    
//                    // Store the image in to our cache
//                    self.imageCache[url!] = image
//                    dispatch_async(dispatch_get_main_queue(), {
//                        if let cellToUpdate = collectionView.cellForItemAtIndexPath(indexPath) as? WavePreviewCell{
//                            cellToUpdate.coverImageView?.image = image
//                            
//                        }
//                    })
//                }
//                else {
//                    print("Error: \(error!.localizedDescription)")
//                    //  Crashlytics.sharedInstance().recordError(error!)
//                }
//            })
//            
//        }
//        else {
//            dispatch_async(dispatch_get_main_queue(), {
//                if let cellToUpdate = collectionView.cellForItemAtIndexPath(indexPath) as? WavePreviewCell{
//                    cellToUpdate.coverImageView?.image = image
//                    
//                }
//            })
//        }
//        
//        
        

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
        let height = width*(2.8/4.0)
        return CGSizeMake(width, height)
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        switch kind {
            
        case UICollectionElementKindSectionHeader:
            
            if (indexPath.section == 0){
                
                let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "CityFocusHeaderView_ID", forIndexPath: indexPath) as! CityFocusHeaderView
                

                headerView.setUpWith(self.cityFocusViewModel.city!, completion: {
                    [weak self]
                    (result:Bool) in
                    headerView.backButton.addTarget(self!, action: #selector(CityFocusViewController.didSelectBackButton), forControlEvents: .TouchUpInside)
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
        
        return UICollectionReusableView()
        
    }
    

}

