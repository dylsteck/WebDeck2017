//
//  LoginViewController.swift
//  WebDeck2017
//
//  Created by Dylan Steck on 3/8/17.
//  Copyright © 2017 Dylan Steck. All rights reserved.
//

import Foundation
import UIKit
import FacebookCore
import FacebookLogin

class LoginViewController: UIViewController {

    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        //animateLogo()
        
        titleLabel.font = UIFont(name: "Montserrat-Bold", size: 15)
        titleLabel.textColor = UIColor(red:0.87, green:0.87, blue:0.87, alpha:1.0)
        
        let loginButton = LoginButton(readPermissions: [ .publicProfile, .email])
        loginButton.center = view.center
        
        view.addSubview(loginButton)
        
        if let accessToken = AccessToken.current {
            print("signed in")
        }
        
    }
    
    func loginButtonDidLogOut(_ loginButton: LoginButton){
        print("logged out of fb")
        
    }
    
    func loginButton(_ loginButton: LoginButton!, didCompleteWith result: LoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        
        print("Successfully logged in with facebook...")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    
    func animateLogo() {
        logo.alpha = 0.0
        UIView.animate(withDuration: 3.0) {
            self.logo.alpha = 1.0
        }
    }


 
}

