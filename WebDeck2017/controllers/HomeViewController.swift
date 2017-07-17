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
import Kingfisher

class HomeViewController: UIViewController {
    
    var newsArray = [JSON]()
    var newsTitles = [JSON]()
    
    @IBOutlet weak var facebookImageView: UIImageView!
    @IBOutlet weak var usernameString: UILabel!
    
    var calendar = CalendarModule()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar.checkCalendarAuthorizationStatus()
        calendar.requestAccessToCalendar()
        calendar.loadEvents()
        
        
        self.getNews()
        
        addSegmentedControl()
   
        
    } // end of viewDidLoad
    
    override func viewDidAppear(_ animated: Bool) {
        getFacebookPicture()
    
    }
    
    func getFacebookPicture(){
        let userID = FBSDKAccessToken.current().userID
        let facebookProfileUrl = "http://graph.facebook.com/\(userID as! String)/picture?type=large"
        print (facebookProfileUrl)
        ImageDownloader.default.downloadImage(with: NSURL(string: facebookProfileUrl) as! URL, options: [], progressBlock: nil) {
       (image, error, url, data) in
            self.facebookImageView.image = image
        }
        let username = Auth.auth().currentUser?.displayName!
        let welcomeString = "Welcome, \(username as! String)!"
        usernameString.text = welcomeString
        usernameString.font = UIFont(name: "NouvelleVague-Black", size: 17)!
    }
    
    func addSegmentedControl(){
        let titles = ["Home", "Reactions", "Sign Out"]
        //x is where it is on the x axis, y is where it is on the y axis, width is width, and height is height. Higher numbers in the y column get closer to the top of the frame, and smaller get it closer to the bottom.
        let frame = CGRect(x: 2, y: view.frame.height / 9, width: view.frame.width - 10, height: 40)
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

