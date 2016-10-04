//
//  WavePreviewCell.swift
//  Waves
//
//  Created by Rijul Gupta on 9/13/16.
//  Copyright © 2016 Rijul Gupta. All rights reserved.
//

import UIKit


class WavePreviewCell_old:UICollectionViewCell{
    @IBOutlet weak var coverImageView:UIImageView!
    @IBOutlet weak var waveNameLabel:UILabel!
   // @IBOutlet weak var waveLocationLabel:UILabel!
    
    @IBOutlet weak var usersLabel:UILabel!
    @IBOutlet weak var heartsLabel:UILabel!
    
    var cityImageLink:NSURL?
    
  //  var locationCoordinates:(Float, Float)?
    
    override func awakeFromNib() {
        
        self.contentView.layer.cornerRadius = 10.0;
        self.contentView.layer.masksToBounds = true;
        
        self.layer.cornerRadius = 10.0;
        self.layer.masksToBounds = true;

    }
    

    
}