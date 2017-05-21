//
//  CalendarModule.swift
//  WebDeck2017
//
//  Created by Dylan Steck on 5/20/17.
//  Copyright © 2017 Dylan Steck. All rights reserved.
//

import Foundation
import UIKit

import Alamofire
import SwiftyJSON

import EventKit
import EventKitUI

class CalendarModule {
    
    var calendar = EKCalendar(for: .event, eventStore: EKEventStore())
    var events: [EKEvent]?
    var eventStore = EKEventStore()
    var calendarCollectionView: UICollectionView!
    var label: UILabel!
    
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
            print("access denied")
        }
    } // end of authorization
    
    
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
        
        let predicate: NSPredicate = eventStore.predicateForEvents(withStart: today, end: oneMonthAfter, calendars: nil)
        // Fetch all events that match the predicate
        let events: [AnyObject] = eventStore.events(matching: predicate)
        //Gets those events
        DispatchQueue.main.async(execute: {
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
        })
    }

    
    
}
