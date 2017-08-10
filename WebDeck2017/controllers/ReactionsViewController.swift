//
//  ReactionsViewController.swift
//  WebDeck2017
//
//  Created by Dylan Steck on 5/25/17.
//  Copyright © 2017 Dylan Steck. All rights reserved.
//

import Foundation
import UIKit

import Firebase
import FBSDKLoginKit


class ReactionsViewController: UIViewController {
    private var reaction = Reaction()
    
    @IBOutlet weak var yourDayButton: UIButton!
    @IBOutlet weak var reactionsButton: UIButton!
    @IBOutlet weak var logoutButton: UIButton!
    
    func showPresentVC(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "HomeViewController")
        self.present(viewController, animated: true)
    }
    
    @IBOutlet weak var reactionContent: UITextField!
    @IBOutlet weak var reactionTitle: UITextField!
    
    @IBOutlet weak var composeLabel: UILabel!

    
    
    override func viewDidLoad(){
        super.viewDidLoad()
       composeLabel.font =  UIFont(name: "NouvelleVague-Black", size: 17)!
       reactionTitle.font =  UIFont(name: "NouvelleVague-Black", size: 14)!
        
        navBar()
        
        
    }
    

    func navBar(){
        self.yourDayButton.titleLabel?.font = UIFont(name: "Montserrat-Regular", size: 15)
        self.reactionsButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 15)
        self.logoutButton.titleLabel?.font = UIFont(name: "Montserrat-Bold", size: 15)
    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        try! Auth.auth().signOut()
        let manager = FBSDKLoginManager()
        manager.logOut()
        self.performSegue(withIdentifier: "logoutSegue", sender: self)
        print("User logged out via FB")
    }
    
    @IBAction func sendReaction(_ sender: UIButton) {

        reaction.sendReaction(reactionTitle: reactionTitle, reactionContent: reactionContent, showPresent:showPresentVC())
        
    }
}
