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
import TwicketSegmentedControl

class HomepageViewController: UIViewController {
    @IBOutlet weak var usernameLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(PFUser.current())
//        
        if let user = PFUser.current(){
        var username = PFUser.current()!["username"] as! String
        self.usernameLabel.font = UIFont(name: "WeissenhofGrotesk-Bold", size: 16)!
        self.usernameLabel.text = ("Hello, " + username + "!")
        }
        else{
            // nothing
            print("user not logged in?")
        }
    
        let titles = ["Home", "Featured", "Your Day", "Sign Out"]
        let frame = CGRect(x: 2, y: view.frame.height / 2 - 20, width: view.frame.width - 10, height: 40)
        let segmentedControl = TwicketSegmentedControl(frame: frame)
        segmentedControl.setSegmentItems(titles)
        segmentedControl.setSegmentItems(titles)
        segmentedControl.delegate = self
        
        view.addSubview(segmentedControl)
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
}

extension HomepageViewController: TwicketSegmentedControlDelegate {
    func didSelect(_ segmentIndex: Int) {
        print("Selected index: \(segmentIndex)")
    }
}
