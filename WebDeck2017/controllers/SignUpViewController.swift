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

class SignUpViewController: UIViewController {

    @IBOutlet weak var logo: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        animateLogo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }



//    @IBAction func saveUser(_ sender: Any) {
//        var user = PFUser()
//        user["username"] = usernameField.text
//        user["email"] = emailField.text
//        user["password"] = pinField.text
//        user.signUpInBackground { (succeeded, error) -> Void in
//
//        }
//    }
    func animateLogo() {
        logo.alpha = 0.0
        UIView.animate(withDuration: 3.0) {
            self.logo.alpha = 1.0
        }
    }


}

