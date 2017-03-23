//
//  HomepageViewController.swift
//  WebDeck2017
//
//  Created by Dylan Steck on 3/12/17.
//  Copyright © 2017 Dylan Steck. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
import Parse
import TwicketSegmentedControl
import Alamofire
import EventKit
import EventKitUI
import CoreLocation


class HomepageViewController: UIViewController, CLLocationManagerDelegate {
    //IBOutlet
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var topView: UIView!
    //News
     var myArticles = [JSON]()
    var myArray = [String]()
    var weatherData = [JSON]()
     var weatherString = [String]()
    
    //Calendar
     var calendar = EKCalendar(for: .event, eventStore: EKEventStore())
    var events: [EKEvent]?
    var eventStore = EKEventStore()
    //Location
      var locationManager:CLLocationManager!
    var startLocation: CLLocation!
    var myLocation: CLLocationCoordinate2D!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        let tableView: UITableView = UITableView()
//        tableView.frame = CGRect(x: 10, y: 10, width: 100, height: 500)
//        self.view.addSubview(tableView)
        
        if PFUser.current() != nil{
        let username = PFUser.current()!["username"] as! String
        self.usernameLabel.font = UIFont(name: "WeissenhofGrotesk-Bold", size: 16)!
        self.usernameLabel.text = ("Hello, " + username + "!")
        }
        else{
            // nothing
            print("user not logged in?")
        }
        
        //        changes the color of the top table view
        topView.backgroundColor = UIColor(red:0.96, green:0.98, blue:0.99, alpha:1.00)
        
         //Calling on the function that gets events from the user
        loadEvents()
        
        //adds the segmented control
        
        addSegmentedControl()
        
        //Sets date standards and formats for the calendar
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, y"
        let dateObj = formatter.string(from: currentDate)
        
        //weather
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
    } //end of viewDidLoad()
    
   
    // adds the segmented control
        func addSegmentedControl(){
        let titles = ["Home", "Featured", "Your Day", "Sign Out"]
        //x is where it is on the x axis, y is where it is on the y axis, width is width, and height is height. Higher numbers in the y column get closer to the top of the frame, and smaller get it closer to the bottom.
        let frame = CGRect(x: 2, y: view.frame.height / 7, width: view.frame.width - 10, height: 40)
        let segmentedControl = TwicketSegmentedControl(frame: frame)
        segmentedControl.setSegmentItems(titles)
        segmentedControl.setSegmentItems(titles)
        segmentedControl.delegate = self
        view.addSubview(segmentedControl)
        //        let button = UIButton(frame: frame)
        //        self.view.addSubview(button)
    }
    
        //checks calendar authorizazion
    func checkCalendarAuthorizationStatus() {
        let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
        
        switch (status) {
        case EKAuthorizationStatus.notDetermined:
            // This happens on first-run
            requestAccessToCalendar()
        case EKAuthorizationStatus.authorized:
            // Things are in line with being able to show the calendars in the table view
            print("authorized")
        case EKAuthorizationStatus.restricted, EKAuthorizationStatus.denied:
            // We need to help them give us permission
            print("access deinid")
        }
    }
    //requests access to the calendar
    func requestAccessToCalendar() {
        EKEventStore().requestAccess(to: .event, completion: {
            (accessGranted: Bool, error: Error?) in
            
            if accessGranted == true {
                DispatchQueue.main.async(execute: {
                    print("access granted")
                })
            } else {
                DispatchQueue.main.async(execute: {
                   print("not granted")
                })
            }
        })
    }
     //Loads the user's events within one day.
    func loadEvents() {
        let calendar: Calendar = Calendar.current
        var todayComponents: DateComponents = DateComponents()
        todayComponents.day = 0
        let today: Date! = (calendar as NSCalendar).date(byAdding: todayComponents, to: Date(), options: [])
        var tomorrowComponents: DateComponents = DateComponents()
        tomorrowComponents.day = 1
        let oneMonthAfter = Date(timeIntervalSinceNow: +86400)
        var tomorrow: Date! = (calendar as NSCalendar).date(byAdding: todayComponents, to: oneMonthAfter, options: [])
        
        let predicate: NSPredicate = eventStore.predicateForEvents(withStart: today, end: oneMonthAfter, calendars: nil)
        // Fetch all events that match the predicate
        let events: [AnyObject] = eventStore.events(matching: predicate)
        //Gets those events
        if events.isEmpty == true {
            print("You have no events today.")
        }
        else {
//            print(events)
            // Querrys through the events, prints them to the console, and logs it in Answers if there are events.
            for event in events {
                //Answers
                let formatter = DateFormatter()
                formatter.dateFormat = "MMM d h:mm a"
                let dateObj = formatter.string(from: event.startDate)
                let textToAppend = (" \(dateObj) - \(event.title!)") + "\r\n"
                print(textToAppend)
            }
            
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
                getCurrentLocation()
        Alamofire.request("https://newsapi.org/v1/articles?source=the-wall-street-journal&sortBy=top&apiKey=88729f588b05434099e6bcbbba4ab167").validate().responseJSON
            { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    self.myArticles = json["articles"].arrayValue
                    for article in self.myArticles {
                        //Pulls the title and Image from the JSON and appends each title to the array
                        let title = article["title"].stringValue
                        let image = article["urlToImage"].stringValue
                        let url = article["url"].stringValue
//                        print("title \(title)")
//                        print(image)
//                        print(url)
                        //my array is actualy a string
                        self.myArray.append(title)
                   
                    }
                         print (self.myArray)
                case .failure(let error):
                    print(error)
                }
        }
        

    }
    
    //weather
    
    func getCurrentLocation(){
        if CLLocationManager.locationServicesEnabled(){
            locationManager.startUpdatingLocation()
    
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let newLocation = locations.last
        
        //check accuracy and timestamp of location to make sure its not a cached/old location (if you don't care about accuracy or time, you can remove this check)
        
        if (newLocation?.horizontalAccuracy)!<=(newLocation?.horizontalAccuracy)!{
            
            //stop updating location
            self.locationManager.stopUpdatingLocation()
            
            //set currentUserLocation
             self.myLocation = newLocation?.coordinate
            
            
            //call function to get weather
            getWeatherFunc()
            
            //remove delegate
            self.locationManager.delegate = nil
            
        }
        
    }
    func getWeatherFunc(){
        let requestLink = "http://forecast.weather.gov/MapClick.php?lat=\(myLocation.latitude)&lon=\(myLocation.longitude)&FcstType=json"
        print(requestLink)
        Alamofire.request(requestLink).responseJSON{ response in
//            .responseString { response in
//                print("Response String: \(response.result.value)")
//            }
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                print("Response JSON: \(json)")
//                print(json["location"]["areaDescription"])
                print("\(json["time"]["startPeriodName"][1]): \(json["data"]["weather"][1])")
                print("\(json["time"]["startPeriodName"][2]): \(json["data"]["weather"][2])")
                
                let weatherView = UIView(frame: CGRect(x: 0, y: 500, width: 1000 , height: 100 ))
                weatherView.backgroundColor = UIColor(red:0.95, green:0.98, blue:0.99, alpha:1.00)
                self.view.addSubview(weatherView)
                //label zero is for data set 0 of weather
                let labelZero = UILabel(frame: CGRect(x: 50, y: 500, width: 800 , height: 15 ))
                    // the 4 params for the cgrect is x, y, width, height
                labelZero.text = ("\(json["time"]["startPeriodName"][0]): \(json["data"]["weather"][0])")
                labelZero.font =  UIFont(name: "WeissenhofGrotesk-Regular", size: 16)!
                self.view.addSubview(labelZero)
                
                
            case .failure(let error):
            print(error)
            }
        }

    }





    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
    {
        print("Error \(error)")
    }
    
    //end of location and weather
    
    
}
//Extension for the segmented control
extension HomepageViewController: TwicketSegmentedControlDelegate {
    func didSelect(_ segmentIndex: Int) {
        print("Selected index: \(segmentIndex)")
        if segmentIndex == 3 {
            PFUser.logOut()
            let currentUser = PFUser.current()
            if currentUser == nil {
                print("user is nil")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier :"SignUpViewController") 
                self.present(viewController, animated: true)
                
            }
            else{
                print("user is not nil")
            };
        }
    }
}

//would work for a uitableview
//extension HomepageViewController: UITableViewDataSource, UITableViewDelegate{
//    
//    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        NSLog("sections")
//        return 2
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        NSLog("rows")
//        return 3
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        NSLog("get cell")
//        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "Cell")
//        cell.textLabel!.text = "foo"
//        return cell
//    }
//
//
//}

