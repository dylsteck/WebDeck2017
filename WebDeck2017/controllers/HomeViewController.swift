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
    
    @IBOutlet weak var yourDayButton: UIButton!
    @IBOutlet weak var reactionsButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    @IBOutlet weak var facebookImageView: UIImageView!
    @IBOutlet weak var usernameString: UILabel!
    
    var calendar = CalendarModule()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendar.checkCalendarAuthorizationStatus()
        calendar.requestAccessToCalendar()
        calendar.loadEvents()
        
        
        self.getNews()
        self.navBar()
   
        
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
    
    func navBar(){
        self.yourDayButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 15)
        self.reactionsButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 15)
        self.logoutButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 15)
    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        try! Auth.auth().signOut()
        let manager = FBSDKLoginManager()
        manager.logOut()
        self.performSegue(withIdentifier: "logoutSegue", sender: self)
        print("User logged out via FB")
    }
} //end of Class
