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

import Firebase
import FBSDKLoginKit

import SwiftyJSON
import Alamofire

class HomeViewController: UIViewController, UIScrollViewDelegate, UITableViewDataSource {

    var logoImageView = UIImageView(image: UIImage(named: "WebDeckLogo"))
    
    var newsArray = [JSON]()
    var newsTitles = [JSON]()
    
    var calendar = CalendarModule()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar.checkCalendarAuthorizationStatus()
        calendar.requestAccessToCalendar()
        calendar.loadEvents()
        
        self.getNews()
        
        addSegmentedControl()
        
        //logoImageView.center = view.center
        //view.addSubview(logoImageView)
        
        
    } // end of viewDidLoad
    
    //table view try
    var categories = ["News"]
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! NewsCell
        return cell
    }
// tv end
    
    
    func addSegmentedControl(){
        let titles = ["Home", "Reactions", "Sign Out"]
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
} //end of Class

//Extension for the segmented control
extension HomeViewController: TwicketSegmentedControlDelegate {
    func didSelect(_ segmentIndex: Int) {
        print("Selected index: \(segmentIndex)")
        if segmentIndex == 2 {
            try! Auth.auth().signOut()
            print("User logged out via FB")
            let loginManager = FBSDKLoginManager()
            loginManager.logOut()
            performSegue(withIdentifier: "signOutSegue", sender: self)
        }
        if segmentIndex == 1 {
            performSegue(withIdentifier: "reactionTriggerSegue", sender: self)
        }
    }
}

