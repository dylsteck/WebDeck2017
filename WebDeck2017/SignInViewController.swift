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

class SignInViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var logo: UIImageView!
    
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
    
    func animateLogo(){
            logo.alpha = 0.0
        UIView.animate(withDuration: 3.0){
            self.logo.alpha = 1.0
        }
    }
    
    func logIn(){
        // Initializing Digits and Digits theming
        let digits = Digits.sharedInstance()
        let configuration = DGTAuthenticationConfiguration(accountFields: .defaultOptionMask)
        configuration?.appearance = DGTAppearance()
        
        // Changes the font and logo of this instance of Digits
        configuration?.appearance.logoImage = UIImage(named: "WDSlogan-Large.png")
        configuration?.appearance.labelFont = UIFont(name: "WeissenhofGrotesk-Bold", size: 16)
        configuration?.appearance.bodyFont = UIFont(name: "WeissenhofGrotesk-Regular", size: 16)
        
        // Triggers the Digits on the click of the button
        Digits.sharedInstance().authenticate(with: self, configuration: configuration!) { (session, error) -> Void in
            if (session != nil) {
                self.button.setTitle("Your Digits User ID is " + (session?.userID)!, for: UIControlState.normal)
            }
            else {
                print(error?.localizedDescription as Any)
            }
            
        }
    }
    

}

