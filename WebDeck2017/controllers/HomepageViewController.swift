//
//  HomepageViewController.swift
//  WebDeck2017
//
//  Created by Dylan Steck on 3/12/17.
//  Copyright © 2017 Dylan Steck. All rights reserved.
//

import UIKit
import Foundation
import Parse

class HomepageViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(PFUser.current())
        print(PFUser.current()?["username"])
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
    @IBAction func signOut(_ sender: UIButton) {
        PFUser.logOut()
        let currentUser = PFUser.current()
        if currentUser == nil {
            print("user is nil")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = storyboard.instantiateViewController(withIdentifier :"SignUpViewController") as! UIViewController
            self.present(viewController, animated: true)

        }
        else{
            print("user is not nil")
        }
    }

}
