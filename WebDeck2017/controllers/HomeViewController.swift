//
//  HomeViewController.swift
//  WebDeck2017
//
//  Created by Dylan Steck on 4/20/17.
//  Copyright © 2017 Dylan Steck. All rights reserved.
//
import UIKit
import Foundation

import TwicketSegmentedControl

import SwiftyJSON
import Alamofire

class HomeViewController: UIViewController, UIScrollViewDelegate {

    var logoImageView = UIImageView(image: UIImage(named: "WebDeckLogo"))
    var newsArray = [JSON]()
    var newsString = [String]()
    var calendar = CalendarModule()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar.checkCalendarAuthorizationStatus()
        calendar.requestAccessToCalendar()
        calendar.loadEvents()
        
        logoImageView.center = view.center
        view.addSubview(logoImageView)
        
        
    } // end of viewDidLoad
} //end of Class
