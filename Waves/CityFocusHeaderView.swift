//
//  CityFocusHeaderView.swift
//  Waves
//
//  Created by Rijul Gupta on 9/29/16.
//  Copyright © 2016 Rijul Gupta. All rights reserved.
//

import UIKit
import ReactiveCocoa

class CityFocusHeaderView:UICollectionReusableView{
    
    
    var city:City!
    @IBOutlet weak var cityNameLabel:UILabel!
    @IBOutlet weak var cityStateCountryNameLabel:UILabel!
    
    @IBOutlet weak var searchButton:UIButton!
    @IBOutlet weak var backButton:UIButton!
    
    @IBOutlet weak var numberFriendsVisited:UILabel!
    @IBOutlet weak var viewWavesButton:UIButton!
        
    @IBOutlet weak var cityCoverImageView:UIImageView!
    
    @IBOutlet weak var userPreviewFaceView:UserPreviewFaceView!
    
    
    @IBOutlet weak var customSCHolder:UIView!
    @IBOutlet weak var customSCHolderHeight:NSLayoutConstraint!
    var segmented:YSSegmentedControl!
    
    
    
    //this city may be fully loaded, or it may be in the process of loading thing
    func setUpWith(city:City, completion:(result:Bool)->Void){
        self.city = city
        completion(result: true)
    }
    
    override func awakeFromNib() {
        
        dispatch_async(dispatch_get_main_queue(), {
            [weak self] in
        
        self!.viewWavesButton.layer.borderWidth = 1
        self!.viewWavesButton.layer.masksToBounds = false
        self!.viewWavesButton.layer.borderColor = UIColor.whiteColor().CGColor
        self!.viewWavesButton.layer.cornerRadius = 4.0;
        self!.viewWavesButton.clipsToBounds = true
        })
        
        
        
        
        
       // self.bindModel()
        
    }
    
    override func layoutSubviews() {
        
        
        
        
        
        
        
        let segmentedHeight:CGFloat = 54.0;
        
        
        let k2:[String] = ["Latest", "Trending", "Featured"]
        let segmented = YSSegmentedControl(
            frame: CGRect(
                x: 0,
                y: segmentedHeight + 20.0,
                width: self.frame.size.width,
                height: segmentedHeight),
            titles:k2,
            action: {
                control, index in
                print("segmented did pressed \(index)")
        })
        
        
        segmented.frame = CGRectMake(0, 0, self.frame.width, segmentedHeight)
        
        
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
        let middlex:CGFloat = (((self.frame.width/3.0) - viewWidth)/2.0)
        
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
        
        
        
        //   self.view.addSubview(segmented)
        self.customSCHolderHeight.constant = segmentedHeight
        self.customSCHolder.addSubview(segmented);
        
        
        dispatch_async(dispatch_get_main_queue(), {
            [weak self] in
            
            self!.cityNameLabel.sizeToFit()
            self!.cityNameLabel.layoutIfNeeded()
            
            self!.cityStateCountryNameLabel.sizeToFit()
            self!.cityStateCountryNameLabel.layoutIfNeeded()
            
            
            self!.numberFriendsVisited.sizeToFit()
            // self!.numberFriendsVisited.layoutIfNeeded()
            self!.numberFriendsVisited.setNeedsLayout()
            
            self!.userPreviewFaceView.setNeedsLayout()
            self!.userPreviewFaceView.setupUpImages()
            
            
             self!.updateConstraints()
            })

    }
    
    
    
    
    func bindModel(){
        self.city.name.producer.startWithNext({
            next in
            
            self.cityNameLabel.text = next
        })
        
        self.city.countryName.producer.combineLatestWith(self.city.stateName.producer).startWithNext({
            next in
            //next.0 is the country
            //next.1 is the state if available
            
            //if we're in the usa, we set the lable to the text
            if(next.0 == "USA"){
                self.cityStateCountryNameLabel.text = next.1
            }
            else{//else, we show the country
                self.cityStateCountryNameLabel.text = next.0
            }
            
        })
        
        self.city.coverImageData.producer.startWithNext({
            [weak self]
            next in
            
            if let image = UIImage(data: next!){
                dispatch_async(dispatch_get_main_queue(), {
                    self?.cityCoverImageView.image = image
                })
            }
        })
        
//        self.city.coverImage.producer.startWithNext({
//            next in
//            
//            self.cityCoverImageView.image = next
//        })
    }
    
//    func setUpUserPreviews(previews:[UserPreview]){
//        
//        userPreviewFaceView.setUpWithPreviews(previews)
//    }
    
    
}
