//
//  ViewController.swift
//  WebDeck2017
//
//  Created by Dylan Steck on 3/8/17.
//  Copyright © 2017 Dylan Steck. All rights reserved.
//

import UIKit
import DigitsKit

class SignInViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let digitsButton = DGTAuthenticateButton(authenticationCompletion: { (session, error) in
            // Inspect session/error objects
        })
        self.view.addSubview(digitsButton!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

