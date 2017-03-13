//
//  SignInViewController.swift
//  WebDeck2017
//
//  Created by Dylan Steck on 3/11/17.
//  Copyright © 2017 Dylan Steck. All rights reserved.
//

import UIKit
import Parse

class SignInViewController: UIViewController {

    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var pinField: UITextField!
    @IBOutlet weak var usernameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func signIn(_ sender: UIButton) {
        let username = self.usernameTextField.text
        let password = self.pinField.text
        if (username?.length)! < 3 {
            let alert = UIAlertView(title: "Invalid", message: "Username must be greater than 3 characters", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        } else if (password?.length)! > 4  {
            let alert = UIAlertView(title: "Invalid", message: "Password must be 4 characters", delegate: self, cancelButtonTitle: "OK")
            alert.show()
            
        }
        
        PFUser.logInWithUsername(inBackground: username!, password: password!, block: { (user, error) -> Void in
            if ((user) != nil) {
                let alert = UIAlertView(title: "Success", message: "Logged In", delegate: self, cancelButtonTitle: "OK")
                alert.show()
                
                DispatchQueue.main.async(execute: { () -> Void in
                    self.performSegue(withIdentifier: "signInSegue", sender:self )
                })
                
            } else {
                let alert = UIAlertView(title: "Error", message: "\(error)", delegate: self, cancelButtonTitle: "OK")
                alert.show()
            }
        })
    }
}

extension String {
    var length: Int {
        return (self as NSString).length
    }
}
