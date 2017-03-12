//
//  ContinueSignupViewController.swift
//  WebDeck2017
//
//  Created by Dylan Steck on 3/11/17.
//  Copyright © 2017 Dylan Steck. All rights reserved.
//

import UIKit
import Foundation
import Parse

class ContinueSignupViewController: UIViewController {

        var userID = ""
        var phoneNumber = ""
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var pinFIeld: UITextField!
    @IBOutlet weak var button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

      @IBAction func saveUser(_ sender: UIButton) {
            var user = PFUser()
            user["dgtsUserID"] = userID
            user["username"] = usernameField.text
            user["email"] = emailField.text
            user["password"] = pinFIeld.text
            user["phonenumber"] = phoneNumber
            user.signUpInBackground { (succeeded, error) -> Void in
                if succeeded{
                    print("Success with Parse yyyaboi")
                }
                else{
                    print("parse failure :(")
                }
        }
    }

}
