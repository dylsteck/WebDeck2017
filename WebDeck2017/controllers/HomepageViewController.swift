//
//  HomepageViewController.swift
//  WebDeck2017
//
//  Created by Dylan Steck on 3/12/17.
//  Copyright © 2017 Dylan Steck. All rights reserved.
//

import UIKit
import Foundation
import Parse
import EventKit
import EventKitUI

class HomepageViewController: UIViewController {
    var calendar = EKCalendar(for: .event, eventStore: EKEventStore())
    var events: [EKEvent]?
    var eventStore = EKEventStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(PFUser.current())
        print(PFUser.current()?["username"])
        
        //Calling on the function that gets events from the user
        loadEvents()
        
        //Sets date standards and formats for the calendar
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, MMM d, y"
        let dateObj = formatter.string(from: currentDate)
        
        //Asking the phone for permission to EventStore, which is the place where the calendar and reminder data is stored(WebDeck would like to access your Calendar)
        var eventStore = EKEventStore()
        eventStore.requestAccess(to: EKEntityType.event,
                                 completion: {(granted: Bool, error:NSError!) in
                                    if !granted {
                                        print("Access to store not granted")
                                    }
                                    } as! EKEventStoreRequestAccessCompletionHandler)
    
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
//            myCoolLabel.text = "No events"
            print("You have no events today.")
        }
        else {
            print(events)
            // Querrys through the events, prints them to the console, and logs it in Answers if there are events.
            for event in events {
                let formatter = DateFormatter()
                formatter.dateFormat = "MMM d h:mm a"
                let dateObj = formatter.string(from: event.startDate)
                let textToAppend = (" \(dateObj) - \(event.title!)") + "\r\n"
//                self.myCoolLabel.text = self.myCoolLabel.text + textToAppend
            }
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func signOut(_ sender: UIButton) {
        PFUser.logOut()
        let currentUser = PFUser.current()
        if currentUser == nil {
            print("user is nil")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier :"SignUpViewController") as! UIViewController
            self.present(viewController, animated: true)

        }
        else{
            print("user is not nil")
        }
    }

}
