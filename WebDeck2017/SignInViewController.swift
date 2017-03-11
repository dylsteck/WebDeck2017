//
//  ViewController.swift
//  WebDeck2017
//
//  Created by Dylan Steck on 3/8/17.
//  Copyright © 2017 Dylan Steck. All rights reserved.
//

import Foundation
import UIKit
import DigitsKit
import Parse

class SignInViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Digits.sharedInstance().logOut()
        animateLogo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signIn(_ sender: UIButton) {
        // Calls on the log in function.
        logIn()

    }
    
    @IBAction func saveUser(_ sender: Any) {
        var user = PFUser()
        user["username"] = usernameField.text
        user["email"] = emailField.text
    }
    func animateLogo(){
            logo.alpha = 0.0
        UIView.animate(withDuration: 3.0){
            self.logo.alpha = 1.0
        }
    }
    
    func logIn(){
        var user = PFUser()
        // Initializing Digits and Digits theming
        let configuration = DGTAuthenticationConfiguration(accountFields: .defaultOptionMask)
        configuration?.appearance = DGTAppearance()
        
        // Changes the font and logo of this instance of Digits
        configuration?.appearance.logoImage = UIImage(named: "WDSlogan-Large.png")
        configuration?.appearance.labelFont = UIFont(name: "WeissenhofGrotesk-Bold", size: 16)
        configuration?.appearance.bodyFont = UIFont(name: "WeissenhofGrotesk-Regular", size: 16)
        
        // Triggers the Digits on the click of the button
        Digits.sharedInstance().authenticate(with: self, configuration: configuration!) { (session, error) -> Void in
            if (session != nil) {
               // self.button.setTitle("Your Digits User ID is " + (session?.userID)!, for: UIControlState.normal)
                user["userID"] = session?.userID
                self.button.isHidden = true
                user.signUpInBackground { (succeeded, error) -> Void in
                    
                }

            }
            
        }
    }
}

