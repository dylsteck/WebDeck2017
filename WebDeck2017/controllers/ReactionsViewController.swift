//
//  ReactionsViewController.swift
//  WebDeck2017
//
//  Created by Dylan Steck on 5/25/17.
//  Copyright © 2017 Dylan Steck. All rights reserved.
//

import Foundation
import UIKit
import Parse

class ReactionsViewController: UIViewController {
    private var reaction = Reaction()
    
    @IBOutlet weak var reactionContent: UITextField!
    @IBOutlet weak var reactionTitle: UITextField!
    
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    override func viewDidLoad(){
        super.viewDidLoad()
      //  headerLabel.font =  UIFont(name: "Nouvelle-Vague.ttf", size: 17)!
      //  descriptionLabel.font =  UIFont(name: "Nouvelle-Vague.ttf", size: 14)!
        
    }
    
    
    
    @IBAction func sendReaction(_ sender: UIButton) {
        reaction.sendReaction(reactionTitle: reactionTitle, reactionContent: reactionContent)
    
        
    }
}
