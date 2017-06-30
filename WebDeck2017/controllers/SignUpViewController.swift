//
//  ViewController.swift
//  WebDeck2017
//
//  Created by Dylan Steck on 3/8/17.
//  Copyright © 2017 Dylan Steck. All rights reserved.
//

import Foundation
import UIKit
import Parse
import FacebookLogin

class SignUpViewController: UIViewController {

    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        //animateLogo()
        
        titleLabel.font = UIFont(name: "Montserrat-Bold", size: 15)
        titleLabel.textColor = UIColor(red:0.87, green:0.87, blue:0.87, alpha:1.0)
        animateLogo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



    @IBAction func signInButtonClicked(_ sender: UIButton) {
        let loginManager = LoginManager()
        loginManager.logIn([ .PublicProfile ], viewController: self) { loginResult in
            switch loginResult {
            case .Failed(let error):
                print(error)
            case .Cancelled:
                print("User cancelled login.")
            case .Success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("Logged in!")
            }
        
    }
    
    
    func animateLogo() {
        logo.alpha = 0.0
        UIView.animate(withDuration: 3.0) {
            self.logo.alpha = 1.0
        }
    }


}

