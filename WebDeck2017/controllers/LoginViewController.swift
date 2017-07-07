//
//  LoginViewController.swift
//  WebDeck2017
//
//  Created by Dylan Steck on 3/8/17.
//  Copyright © 2017 Dylan Steck. All rights reserved.
//

import Foundation
import UIKit

import Firebase
import FirebaseAuth

import FBSDKLoginKit


class LoginViewController: UIViewController, FBSDKLoginButtonDelegate {

    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    @IBOutlet weak var facebookLoginButton: FBSDKLoginButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //styling
        titleLabel.font = UIFont(name: "Montserrat-Bold", size: 15)
        titleLabel.textColor = UIColor(red:0.87, green:0.87, blue:0.87, alpha:1.0)
        
        facebookLoginButton.delegate = self
    }
    
       
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error!.localizedDescription)
            return
        }
        let credential = FacebookAuthProvider.credential(withAccessToken: FBSDKAccessToken.current().tokenString)
        Auth.auth().signIn(with: credential, completion:{ (user , error) in
            if error != nil {
                print(error!.localizedDescription)
                return
            }
            print("user logged in via fb")
            let userID = FBSDKAccessToken.current().userID
            let facebookProfileUrl = "http://graph.facebook.com/\(userID as! String)/picture?type=large"
            print(facebookProfileUrl)
            
            self.performSegue(withIdentifier: "signInSegue", sender: self)
        })
    }

    func loginButtonWillLogin(_ loginButton: FBSDKLoginButton!) -> Bool {
          return true
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        try! Auth.auth().signOut()
        self.performSegue(withIdentifier: "signInSegue", sender: self)
        print("User logged out via FB")
    }
    
//    func animateLogo() {
//        logo.alpha = 0.0
//        UIView.animate(withDuration: 3.0) {
//            self.logo.alpha = 1.0
//        }
//    }


 
}

