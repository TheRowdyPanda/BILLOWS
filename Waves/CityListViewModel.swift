//
//  CityListViewModel.swift
//  Waves
//
//  Created by Rijul Gupta on 9/13/16.
//  Copyright © 2016 Rijul Gupta. All rights reserved.
//

import Foundation
import ReactiveCocoa

class CityListViewModel{
    
    
    var cities:[City]
    
    var citiesLatest:[City]
    var citiesTrending:[City]?
    
    var hasLoadedWavePreviews:[String:Bool]?
    var cityToSend:City?
   // var hasLoadedPreviewsForSelectedWave:Bool = false;
    var hasLoadedPreviewsForSelectedWave = MutableProperty(false)
    
    
    var searchString = MutableProperty("")
    var isLoadingSearchResults = MutableProperty(false)
    var searchResults:NSDictionary?
    
    init (cities:[City]){
        self.cities = cities;
        self.citiesLatest = cities
        
    }
    
    func cityCellForIndexPath(indexPath:NSIndexPath, cell:CityTableCell)->CityTableCell{
        
        //let cell = CityTableCell()
        let city = cities[indexPath.row]
        
        
        cell.setupWithCity(city)
//        cell.cityNameLabel.text = city.name.value
//        cell.coverImage.image = nil
//        cell.cityImageLink = city.coverImageLink.value
//        
//        if(city.countryName.value == "USA"){
//            cell.countryNameLabel.text = city.stateName.value
//        }
//        else{
//            cell.countryNameLabel.text = city.countryName.value
//        }
//        
        
        //  cell.eventProfileImage.contentMode = .ScaleAspectFit
        //downloadImage(checkedUrl, imageView: cell.eventProfileImage)
        
        
        
        
        
        return cell
        
    }
    
    
    func cityForIndexPath(indexPath:NSIndexPath)->City{
        
        let city = cities[indexPath.row]
       // let cityModel = CityFocusViewModel(withCity: city)
        print(city.hasFinishedLoadingWavePreviews.value)
        
        self.cityToSend = self.cities[indexPath.row]
        
//        self.hasLoadedPreviewsForSelectedWave <~ city.hasFinishedLoadingWavePreviews
//            .producer
//            .map{$0 as Bool}
        
       
        
//        city.hasFinishedLoadingWavePreviews
//            .producer
//            .startWithNext({
//                [weak self]
//                next in
//                if(next == true){
//                    if(self?.hasLoadedPreviewsForSelectedWave.value == true){
//                        return
//                    }
//                    self?.cityToSend = self?.cities[indexPath.row]
//                    
//                    self?.hasLoadedPreviewsForSelectedWave.value = true
//                    
//                    
//                   // self!.presentCityFocusWithCity(city)
//                }
//                else{
//                    self?.hasLoadedPreviewsForSelectedWave.value = false
//                }
//                print("Model Has Loaded Info:\(self?.hasLoadedPreviewsForSelectedWave.value)")
//                })
//        
//        
       // let oldIndex = self.cities.indexOf{$0.name == city.name}
        //self.cities[oldIndex!] = city
        self.cities[indexPath.row] = city
        
        
        return city
    }
    
    
    ////
    func loadWavePreviewsForCities(){
        
        for var oldCity in cities{
            self.loadWavePreviewsForCity(oldCity){
                (result:[WavePreview]) in
                oldCity.name = MutableProperty("FUCK")
                oldCity.name.value = "JI"
               // oldCity.wavePreviews.append(result.first!)
                oldCity.wavePreviews.append(result.first!))
                
                
                //oldCity.wavePreviews = result
                oldCity.updateNumberOfWaves()
                
            }
           // oldCity.getWavePreviews()
            
        }
        
        
    }
    
    func loadWavePreviewsForCity(city:City, completion:(result:[WavePreview])->Void){
        
        let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(3 * Double(NSEC_PER_SEC)))
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            
           
            var waveP1 = WavePreview()
            waveP1.name = "Coool party"
            waveP1.imageLink = NSURL(string: "https://upload.wikimedia.org/wikipedia/commons/e/eb/The_Adicts_2011_SO36_03.jpg")
            
            var waveP2 = WavePreview()
            waveP2.name = "Fun times, good times"
            waveP2.imageLink = NSURL(string: "https://upload.wikimedia.org/wikipedia/commons/c/cb/BackyardParty.jpg")
            
            var waveP3 = WavePreview()
            waveP3.name = "New york fun times"
            waveP3.imageLink = NSURL(string: "http://previews.123rf.com/images/somatuscani/somatuscani1506/somatuscani150600004/41952081-NEW-YORK-CITY-JUNE-11-People-having-fun-with-the-Screen-Shows-in-Times-Square-one-of-the-most-visite-Stock-Photo.jpg")
            
            var waveP4 = WavePreview()
            waveP4.name = "Bachelor Party!"
            waveP4.imageLink = NSURL(string: "http://www.partybusdetroit.com/assets/img/bachelor-party.jpg")
            
            var waveP5 = WavePreview()
            waveP5.name = "Coool party"
            waveP5.imageLink = NSURL(string: "http://www.partybusdetroit.com/assets/img/bachelor-party.jpg")
            
            var waveP6 = WavePreview()
            waveP6.name = "Coool party"
            waveP6.imageLink = NSURL(string: "http://www.partybusdetroit.com/assets/img/bachelor-party.jpg")
            
            
            var waveP7 = WavePreview()
            waveP7.name = "Coool party"
            waveP7.imageLink = NSURL(string: "http://www.partybusdetroit.com/assets/img/bachelor-party.jpg")
            
            
            
            
          //  city.wavePreviews?.append(waveP1)
            
        //    city.loadWavePreview(waveP1)
            
            
            let wavePs = [waveP1, waveP2, waveP3, waveP4, waveP5, waveP6, waveP7, ]
            
            completion(result: wavePs)
            
//            
//            let oldIndex = self.cities.indexOf{$0.name.value == city.name.value}
//            
//            self.cities[oldIndex!].loadWavePreview(waveP1)
//            self.cities[oldIndex!].loadWavePreview(waveP2)
//            self.cities[oldIndex!].loadWavePreview(waveP3)
//            self.cities[oldIndex!].loadWavePreview(waveP4)
//            self.cities[oldIndex!].loadWavePreview(waveP5)
//            self.cities[oldIndex!].loadWavePreview(waveP6)
//            self.cities[oldIndex!].loadWavePreview(waveP7)
//            
            //self.cities[oldIndex!].hasFinishedLoadingWavePreviews.value = true
          //  print("ME")
            
            //        return c
        }
//
//        
    }
    
    
    func presentCityFocusWithCity(city:City){
        let cityFocusViewModel = CityFocusViewModel(withCity: city)
        
    }
    
    
    
    
    func loadSearchResult(){
        
        let searchText = self.searchString.value
        self.isLoadingSearchResults.value = true
        
        //load the results
        self.searchResults = NSDictionary()
        //set the loading bool to false
        self.isLoadingSearchResults.value = false
    }
}