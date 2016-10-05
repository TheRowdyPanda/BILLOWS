//
//  WaveDashboardViewController.swift
//  Waves
//
//  Created by Rijul Gupta on 9/30/16.
//  Copyright © 2016 Rijul Gupta. All rights reserved.
//

import UIKit

class WaveDashboardViewController:UIViewController{
    
//    @IBOutlet weak var waveNameLabel:UILabel!
//    @IBOutlet weak var waveCoverImageView:UIViewController!
    
    weak var waveDashboardViewModel:WaveDashboardViewModel!
    
    @IBOutlet weak var collectionView:UICollectionView!
    
    func setUpWith(viewModel:WaveDashboardViewModel, completion: (result: Bool) -> Void){
        self.waveDashboardViewModel = viewModel
        
        completion(result: true)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("Loaded City View")
        self.navigationController?.navigationBarHidden = false
        self.navigationItem.backBarButtonItem = nil
        
        
        self.bindModel()
        
  
        
        collectionView.registerNib(UINib(nibName: "WaveFocusHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "WaveFocusHeaderView_ID")
        
        
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        
     
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    

    func bindModel(){
        
    }
    
    
    
}

extension WaveDashboardViewController:UICollectionViewDelegate, UICollectionViewDataSource{
    
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
        return 1
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        print("CLICK")
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
       let cell = UICollectionViewCell()
        
        return cell
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
                            
                let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: "WaveFocusHeaderView_ID", forIndexPath: indexPath) as! WaveFocusHeaderView
                
//                
//                headerView.setUpWith((self.profileViewModel?.user)!, completion: {
//                    (result:Bool) in
//              
//                    headerView.bindModel()
//                    
//                })
                return headerView

            
        case UICollectionElementKindSectionFooter:
            let footerView = UICollectionReusableView()

            ////            
            footerView.backgroundColor = UIColor.greenColor();
            return footerView
            
        default:
            
            assert(false, "Unexpected element kind")
        }
        
        
        return UICollectionReusableView()
    }
}
