//
//  WavePreviewCell.swift
//  Waves
//
//  Created by Rijul Gupta on 10/2/16.
//  Copyright © 2016 Rijul Gupta. All rights reserved.
//


import UIKit


class WavePreviewCell:UICollectionViewCell{
    @IBOutlet weak var coverImageView:UIImageView!
    @IBOutlet weak var waveNameLabel:UILabel!
  //  @IBOutlet weak var peopleAttendingLabel:UILabel!
    
    @IBOutlet weak var buildingLocationLabel:UILabel!
    @IBOutlet weak var neighborhoodLocationLabel:UILabel!
    @IBOutlet weak var nearbyAirportLabel:UILabel!
    @IBOutlet weak var airlinesLabel:UILabel!
    @IBOutlet weak var datesLabel:UILabel!
    
    // @IBOutlet weak var waveLocationLabel:UILabel!
    
    @IBOutlet weak var usersLabel:UILabel!
  //  @IBOutlet weak var heartsLabel:UILabel!
    
    
    @IBOutlet weak var userPreviewFaceView:UserPreviewFaceView!
    
    
    var cityImageLink:NSURL?
    
    weak var wavePreview:WavePreview?
    
    //  var locationCoordinates:(Float, Float)?
    
    func setupWithWavePreview(wavePreview:WavePreview){
        
        self.wavePreview = wavePreview
        
        self.bindModel()
       // self.cityImageLink = wavePreview.imageLink
        
    }
    

    override func layoutSubviews() {
        dispatch_async(dispatch_get_main_queue(), {
            [weak self] in
            
            self!.userPreviewFaceView.setNeedsLayout()
            self!.userPreviewFaceView.setupUpImages()
            
            
            self!.updateConstraints()
            })
    }
    
    
    func bindModel(){

        self.wavePreview?.cityName.producer.startWithNext({
            next in
        })
        
        self.wavePreview?.name.producer.startWithNext({
            next in
           // self.waveNameLabel.text = next
        })
     
        self.wavePreview?.imageLink.producer.startWithNext({
            next in
           // self.cityImageLink = next
        })
        
        self.wavePreview?.coverImageData.producer.startWithNext({
            [weak self]
            next in
            
            if let image = UIImage(data:next!){
                dispatch_async(dispatch_get_main_queue(), {
                    [weak self] in
                    
                    self?.coverImageView.image = image
                    //self!.coverImageView.image = next
                    
                    })
            }
            
        })
        
        
//
        
//        
//        self.wavePreview?.coverImage.producer.startWithNext({
//            [weak self]
//            next in
//            
//            if(self!.coverImageView.image != next){
// 
//                            dispatch_async(dispatch_get_main_queue(), {
//                                [weak self] in
//                                
//                                self?.coverImageView.image = next
//                                //self!.coverImageView.image = next
//                                
//                                })
//
//            }
//
//        })
//        
        
//        //we need to load all images on the view controller controlling this view because of "dequereusablecell". Greatly improves performance, but very annoying.
//        self.wavePreview?.imageLink.producer.startWithNext({
//            next in
//            if(next != self.cityImageLink){
//                self.cityImageLink = next
//            }
//        })
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        coverImageView.image = nil
    }
    
    //This doesn't work because we're using reusable cells!
//    func loadCoverImage(){
//        
//        
//        
//        let data = NSData(contentsOfURL: self.cityImageLink!)
//        let image = UIImage(data: data!)
//        self.coverImageView.image = image;
//    }
    
    override func awakeFromNib() {
        
//        self.contentView.layer.cornerRadius = 10.0;
//        self.contentView.layer.masksToBounds = true;
//        
//        self.layer.cornerRadius = 10.0;
//        self.layer.masksToBounds = true;
        
    }
    
    
    
    
}