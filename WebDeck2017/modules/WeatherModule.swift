//
//  WeatherModule.swift
//  WebDeck2017
//
//  Created by Dylan Steck on 5/24/17.
//  Copyright © 2017 Dylan Steck. All rights reserved.
//

//import Foundation
//import UIKit
//import CoreLocation
//import Alamofire
//import SwiftyJSON
//
//class WeatherModule {
//    
//    var locationManager:CLLocationManager!
//    var startLocation: CLLocation!
//    var myLocation: CLLocationCoordinate2D!
//    var weatherView: UIView!
//    
//    func setWeatherDelegates(){
//        
//  
//
//    locationManager = CLLocationManager()
//    locationManager.delegate = self as! CLLocationManagerDelegate
//    locationManager.desiredAccuracy = kCLLocationAccuracyBest
//    locationManager.requestAlwaysAuthorization()
//        
//    }
//    func getCurrentLocation(){
//        if CLLocationManager.locationServicesEnabled(){
//            locationManager.startUpdatingLocation()
//            
//        }
//    }
//    
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        
//        let newLocation = locations.last
//        
//        //check accuracy and timestamp of location to make sure its not a cached/old location (if you don't care about accuracy or time, you can remove this check)
//        
//        if (newLocation?.horizontalAccuracy)!<=(newLocation?.horizontalAccuracy)!{
//            
//            //stop updating location
//            self.locationManager.stopUpdatingLocation()
//            
//            //set currentUserLocation
//            self.myLocation = newLocation?.coordinate
//            
//            
//            //call function to get weather
//            getWeatherFunc()
//            
//            //remove delegate
//            self.locationManager.delegate = nil
//            
//        }
//        
//    }
//    func getWeatherFunc(){
//        let requestLink = "http://forecast.weather.gov/MapClick.php?lat=\(myLocation.latitude)&lon=\(myLocation.longitude)&FcstType=json"
//        print(requestLink)
//        Alamofire.request(requestLink).responseJSON{ response in
//            //            .responseString { response in
//            //                print("Response String: \(response.result.value)")
//            //            }
//            switch response.result {
//            case .success(let data):
//                let json = JSON(data)
//                print("Response JSON: \(json)")
//                //                print(json["location"]["areaDescription"])
//                
//                let weatherView = UIView(frame: CGRect(x: 0, y: 500, width: 1000 , height: 100 ))
//                weatherView.backgroundColor = UIColor(red:0.95, green:0.98, blue:0.99, alpha:1.00)
//                self.view.addSubview(weatherView)
//                
//            case .failure(let error):
//                print(error)
//            }
//        }
//        
//    }
//    
//    
//    
//    
//    
//    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
//    {
//        print("Error \(error)")
//    }
//    
//    
//}
