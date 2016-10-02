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
    
    var city:City
    
    var cityName = MutableProperty("")
    
    var cityImage = MutableProperty(UIImage())
    
    var wavePreviewCount = MutableProperty(0)
    
    
    init (withCity:City){
        
        
        self.city = withCity
        
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(5 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue(), {
            
            print(self.city)
            
            
        })
        
        //self.city.getWavePreviews()
        //self.loadShit()
        
       // self.city.getWavePreviews()
        self.bindModel()
        
    }
    
    func loadShit(){
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(3 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            
        var waveP1 = WavePreview()
        waveP1.name = "Coool party"
        waveP1.imageLink = NSURL(string: "https://upload.wikimedia.org/wikipedia/commons/e/eb/The_Adicts_2011_SO36_03.jpg")
        
        var waveP2 = WavePreview()
        waveP2.name = "Fun times, good times"
        waveP2.imageLink = NSURL(string: "https://upload.wikimedia.org/wikipedia/commons/c/cb/BackyardParty.jpg")
           // self.city.loadWavePreview(waveP1)
       // self.city.wavePreviews.append(waveP1)
       // self.city.wavePreviews.append(waveP2)
       // self.city.numberWavePreviews.value = 2
        }
    }
    
    func bindModel(){
        
        self.city.name.producer.startWithNext({
            next in
            self.cityName.value = next
        })
        
        self.city.coverImage.producer.startWithNext({
            next in
            self.cityImage.value = next
        })
        
        self.city.numberWavePreviews.producer.startWithNext({
            next in
            
            self.wavePreviewCount.value = next
            
            
        })
        
    }
    
    
    
    func wavePreviewCellForIndex(indexPath:NSIndexPath, cell:WavePreviewCell)->WavePreviewCell{
        
        
//        let wavePreview = self.city.wavePreviews[indexPath.row]
//        
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
    
    
}