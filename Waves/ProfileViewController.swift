//
//  ProfileViewController.swift
//  Waves
//
//  Created by Rijul Gupta on 9/13/16.
//  Copyright © 2016 Rijul Gupta. All rights reserved.
//

import UIKit
import ReactiveCocoa


class ProfileViewController:UIViewController{

    //We instantiate the provile view model
    var profileViewModel:ProfileViewModel?
    
    var profileHeaderView:ProfileHeaderView?
    var hasLoadedProfileHeadView:Bool = false
    
    
    
    @IBOutlet weak var profileCollectionView:UICollectionView!
    
    @IBOutlet weak var customBackButton:UIButton!
    
    var headerHeight:CGFloat = 100.0;
    var imageCache:[NSURL: UIImage] = [NSURL: UIImage]()
    
    
    func setUpWith(profileViewModel:ProfileViewModel, completion: (result: Bool) -> Void){
        self.profileViewModel = profileViewModel
        
        
//        let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "ProfileHeaderView_ID", forIndexPath: NSIndexPath(forItem: 0, inSection: 0)) as! ProfileHeaderView
//        
//        headerView.bindModel()
//        
//        headerView.userCoverImageViewProperty <~ (self.profileViewModel?.userCoverImageProperty.signal.toRACSignal()
//            .toSignalProducer()
//            .map{($0 as? UIImage) ?? UIImage()}
//            .flatMapError{ _ in SignalProducer<UIImage, NoError>.empty })!
//        
//        headerView.userImageViewProperty <~ (self.profileViewModel?.userProfileImageProperty
//            .signal
//            .toRACSignal()
//            .toSignalProducer()
//            .map{($0 as? UIImage) ?? UIImage()}
//            .flatMapError{ _ in SignalProducer<UIImage, NoError>.empty })!
      
        
        let headerView = ProfileHeaderView()
        
        headerView.setUpWith((self.profileViewModel?.user)!, completion: {_ in 
            self.profileHeaderView = headerView
            
            
        })
        
        completion(result: true)

    }
    
    override func viewDidLoad() {
        
        
        //We hide the navigation bar.
        self.navigationController?.navigationBarHidden = true
        
        
        //We need to register to the header view. This view holds the user name, photos, social buttons, etc.
        profileCollectionView.registerNib(UINib(nibName: "ProfileHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "ProfileHeaderView_ID")
        
        
        profileCollectionView.registerNib(UINib(nibName: "WavePreviewHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "WavePreviewHeaderView_ID")
        
        
        //We also need to register the wave preview cell. This will hold all the wave info, and load the rest of the wave info in the background.
        profileCollectionView.registerNib(UINib(nibName: "WavePreviewCell", bundle: nil), forCellWithReuseIdentifier: "WavePreviewCell_ID")

        
        //We set the delegate and datasource of the collection view to our view controller.
        self.profileCollectionView.delegate = self
        self.profileCollectionView.dataSource = self
        
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        
        let leftPadding:CGFloat = 8.0;
        let width = (self.view.frame.width - leftPadding*2.0);
        let height = width*(2.5/4.0)
        layout.sectionInset = UIEdgeInsets(top: 0, left: leftPadding, bottom: 0, right: leftPadding)
        layout.itemSize = CGSize(width: width, height: height)
        
        
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 25
        self.profileCollectionView.collectionViewLayout = layout
        
        
        //self.bindModel()
        
    }
    
    func bindModel(){
        
//        self.profileViewModel?.user.coverImageLink.signal.observeNext({
//            
//            next in
//            
//            
//            
//        })
        
        
//        self.profileViewModel?.userCoverImageProperty
//        .producer
//            .startWithNext({
//                [weak self]
//                next in
//                dispatch_async(dispatch_get_main_queue(), {
//                    if let imageView = self!.profileHeaderView!.coverImageView{
//                        imageView.image = next
//                       // self!.profileCollectionView.layout
//                        ///self!.profileCollectionView.reloadInputViews()
//                    }
//                    //self!.profileHeaderView!.coverImageView.image = next
//                })
//                
//            })
        
        
        
//        self.cityListViewModel!.hasLoadedPreviewsForSelectedWave
//            .producer
//            .startWithNext({
//                [weak self]
//                next in
//                if(next == true){
//                    self?.hasLoadedInfoForNextViewModel = true
//                    self!.showCityFocusView()
//                }
//                else{
//                    self?.hasLoadedInfoForNextViewModel = false
//                }
//                print("Has Loaded Info:\(self?.hasLoadedInfoForNextViewModel)")
//                })
        
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        self.navigationController?.navigationBarHidden = false
    }
    
    
    @IBAction func removeProfileView(){
        
        self.navigationController?.popViewControllerAnimated(true)
    }
}


extension ProfileViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        switch section{
            case 0:
                return 0
            case 1:
                return 7
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
     
        let cell = self.profileViewModel?.wavePreviewCellForIndex(indexPath, cell: preCell)
        
        
        let url = cell!.cityImageLink
        
        
        var image = self.imageCache[url!]
        if( image == nil ) {
            
            // If the image does not exist, we testImage to download it
            let imgURL:NSURL = url!
            
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
            
            let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "ProfileHeaderView_ID", forIndexPath: indexPath) as! ProfileHeaderView
            
                
            headerView.setUpWith((self.profileViewModel?.user)!, completion: {
                (result:Bool) in
               
                 //   headerView.userCoverImageViewProperty = (self.profileViewModel?.userCoverImageProperty)!
                
         
//                
//                headerView.userCoverImageViewProperty <~ (self.profileViewModel?.userCoverImageProperty.signal.toRACSignal()
//                    .toSignalProducer()
//                    .map{($0 as? UIImage) ?? UIImage()}
//                    .flatMapError{ _ in SignalProducer<UIImage, NoError>.empty })!
//                
//                headerView.userImageViewProperty <~ (self.profileViewModel?.userProfileImageProperty
//                    .signal
//                    .toRACSignal()
//                    .toSignalProducer()
//                    .map{($0 as? UIImage) ?? UIImage()}
//                    .flatMapError{ _ in SignalProducer<UIImage, NoError>.empty })!
                
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
//            let footerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "Footer", forIndexPath: indexPath) as! UICollectionReusableView
////            
            footerView.backgroundColor = UIColor.greenColor();
            return footerView
            
        default:
            
            assert(false, "Unexpected element kind")
        }
        
        
        return UICollectionReusableView()
    }
}
