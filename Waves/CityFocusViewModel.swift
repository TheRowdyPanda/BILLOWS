//
//  CityFocusViewModel.swift
//  Waves
//
//  Created by Rijul Gupta on 9/20/16.
//  Copyright © 2016 Rijul Gupta. All rights reserved.
//

import Foundation
import UIKit.UIFont
import ReactiveCocoa

class CityFocusViewModel{
    
    weak var city:City?
    
    var cityName = MutableProperty("")
    
    var cityImage = MutableProperty(UIImage())
    
    var wavePreviewCount = MutableProperty(0)
    
    
    init (withCity:City){
        
        
        city = withCity
        //self.city.loadWavePreview()
        
        
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue(), {

        })
        

        
       // self.city.getWavePreviews()
        self.bindModel()
        
    }
    
    
    func bindModel(){
        
        self.city!.name.producer.startWithNext({
            next in
            self.cityName.value = next
        })
        
        self.city!.coverImage.producer.startWithNext({
            next in
            self.cityImage.value = next
        })
        
        self.city!.numberWavePreviews.producer.startWithNext({
            next in
            
            self.wavePreviewCount.value = next
            
            
        })
        
    }
    
    
    
    func wavePreviewCellForIndex(indexPath:NSIndexPath, cell:WavePreviewCell)->WavePreviewCell{
        
        
        weak var wavePreview = city!.wavePreviews[indexPath.row]
        
        cell.setupWithWavePreview(wavePreview!)
        
        
//        let startString = wavePreview.name! + " in "
//        
//        let attributedString = NSMutableAttributedString(string:startString)
//        
//        
//        
//        let attrs = [NSFontAttributeName : UIFont.boldSystemFontOfSize(15)]
//        let boldString = NSMutableAttributedString(string:wavePreview.cityName!, attributes:attrs)
//        
//        attributedString.appendAttributedString(boldString)
//        
//        
//        
//        cell.waveNameLabel.attributedText = attributedString
//        cell.cityImageLink = wavePreview.imageLink
//        
        
        return cell
        
    }
    
    
    func wavePreviewForIndexPath(indexPath:NSIndexPath)->WavePreview
    {
        
        let wavePreview = city?.wavePreviews[indexPath.row]
        // let cityModel = CityFocusViewModel(withCity: city)
        return wavePreview!
    }

    
    
}
