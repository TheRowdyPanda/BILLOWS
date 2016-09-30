//
//  CityFocusViewModel.swift
//  Waves
//
//  Created by Rijul Gupta on 9/20/16.
//  Copyright © 2016 Rijul Gupta. All rights reserved.
//

import Foundation
import UIKit.UIFont

class CityFocusViewModel{
    
    var city:City
    
    init (withCity:City){
        self.city = withCity
        
        
    }
    
    func wavePreviewCellForIndex(indexPath:NSIndexPath, cell:WavePreviewCell)->WavePreviewCell{
        
        let wavePreview = self.city.wavePreviews![indexPath.row]
        
        let startString = wavePreview.name! + " in "
        
        let attributedString = NSMutableAttributedString(string:startString)
        
        
        
        let attrs = [NSFontAttributeName : UIFont.boldSystemFontOfSize(15)]
        let boldString = NSMutableAttributedString(string:wavePreview.cityName!, attributes:attrs)
        
        attributedString.appendAttributedString(boldString)
        
        
        
        cell.waveNameLabel.attributedText = attributedString
        cell.cityImageLink = wavePreview.imageLink
        
        
        return cell
        
    }
    
    
}