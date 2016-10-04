//
//  City.swift
//  Waves
//
//  Created by Rijul Gupta on 9/13/16.
//  Copyright © 2016 Rijul Gupta. All rights reserved.
//

import Foundation
import ReactiveCocoa

class City{
    
    var name = MutableProperty("")
    var countryName = MutableProperty("")
    var stateName = MutableProperty("")
    var location = MutableProperty((0.0, 0.0))
    var coverImageLink = MutableProperty(NSURL(string: ""))
    var coverImage = MutableProperty(UIImage())
    var coverImageData = MutableProperty(NSData(base64EncodedString: "", options: []))
    
    var wavePreviews:[WavePreview] = []
    var numberWavePreviews = MutableProperty(0)
    // var hasFinishedLoadingWavePreviews:Bool
    var hasFinishedLoadingWavePreviews = MutableProperty(false)
    
    
    //write a init func that only takes an id value. We can load the rest of the information from our servers on a background thread.
    
    
    init(withName:String, Location:(Double, Double), coverImageLink:NSURL, countryName:String, stateName:String?){
        
        //init all the properties!
        self.name.value = withName;
        self.location.value = Location
        self.coverImageLink.value = coverImageLink
        self.countryName.value = countryName
        self.stateName.value = stateName ?? ""
        
        self.hasFinishedLoadingWavePreviews.value = false
        
        
        //load the stuff on background threads
        dispatch_async(dispatch_get_global_queue (DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
            self.loadRecentWavePreviews()
            self.loadCoverImage();
        })
    }
    
    
    
    
    
    //this loads the most recent 10 waves for a city. This is called on init, even though this info may only be presented after a while. This may be unnecessary requests, but it speeds up UI interactions a lot - we load info before the user knows they want it!
    //Our City model has to be a class. Using a struct type with a mutating function works, but we can't pass the model as reference from View model to view model. We'll have to load everything, then pass it, which means we'll have to use loading screens before transitions. This really pisses me off when apps do this, so I think it's worth having this model be a class. If it becomes a memory issue, I'll rewrite the code.
    func loadRecentWavePreviews(){
        //write an alamofire request!
        //this is fake data
        
        //add a timeout request to simulate actual requests
        
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(2 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            
            
            weak var waveP1 = WavePreview()
            waveP1!.name.value = "Coool party"
            waveP1!.imageLink.value = NSURL(string: "https://upload.wikimedia.org/wikipedia/commons/e/eb/The_Adicts_2011_SO36_03.jpg")
            
            weak var waveP2 = WavePreview()
            waveP2!.name.value = "Fun times, good times"
            waveP2!.imageLink.value = NSURL(string: "https://upload.wikimedia.org/wikipedia/commons/c/cb/BackyardParty.jpg")
            
            weak var waveP3 = WavePreview()
            waveP3!.name.value = "New york fun times"
            waveP3!.imageLink.value = NSURL(string: "http://previews.123rf.com/images/somatuscani/somatuscani1506/somatuscani150600004/41952081-NEW-YORK-CITY-JUNE-11-People-having-fun-with-the-Screen-Shows-in-Times-Square-one-of-the-most-visite-Stock-Photo.jpg")
            
            weak var waveP4 = WavePreview()
            waveP4!.name.value = "Bachelor Party!"
            waveP4!.imageLink.value = NSURL(string: "http://www.partybusdetroit.com/assets/img/bachelor-party.jpg")
            
            weak var waveP5 = WavePreview()
            waveP5!.name.value = "Coool party"
            waveP5!.imageLink.value = NSURL(string: "http://www.partybusdetroit.com/assets/img/bachelor-party.jpg")
            
            weak var waveP6 = WavePreview()
            waveP6!.name.value = "Coool party"
            waveP6!.imageLink.value = NSURL(string: "http://www.partybusdetroit.com/assets/img/bachelor-party.jpg")
            
            
            weak var waveP7 = WavePreview()
            waveP7!.name.value = "Coool party"
            waveP7!.imageLink.value = NSURL(string: "http://www.partybusdetroit.com/assets/img/bachelor-party.jpg")
            
            
            self.wavePreviews.append(waveP1!)
            self.wavePreviews.append(waveP2!)
            self.wavePreviews.append(waveP3!)
            self.wavePreviews.append(waveP4!)
            self.wavePreviews.append(waveP5!)
            self.wavePreviews.append(waveP6!)
            self.wavePreviews.append(waveP7!)
            
            self.updateNumberOfWaves()
            
            
        }
    }
    
    
    //a utility function to update the stored value mutable property. You can call this on a city instance to propogate the number of waves value, which will in-turn call a function on our view model/controller.
    func updateNumberOfWaves(){
        self.numberWavePreviews.value = self.wavePreviews.count ?? 0
    }
    
    
    //this loads a UIImage from an NSURL in the background thread. It then updates the UIImage value on the main thread. This propogates due to RAC.
    func loadCoverImage(){
        
        let url = self.coverImageLink.value
        let imgURL:NSURL = url!
        // Download an NSData representation of the image at the URL
        let request: NSURLRequest = NSURLRequest(URL: imgURL)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {[weak self]
            (response: NSURLResponse?,data: NSData?,error: NSError?) -> Void in
            if error == nil {
                dispatch_async(dispatch_get_main_queue(), {
                    self!.coverImageData.value = data
                })
                
            }
            else {
                print("Error: \(error!.localizedDescription)")
                //  Crashlytics.sharedInstance().recordError(error!)
            }
            })
        
        
    }
    
}
