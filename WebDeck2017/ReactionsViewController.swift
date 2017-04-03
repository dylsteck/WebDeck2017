//
//  ReactionsViewController.swift
//  WebDeck2017
//
//  Created by Dylan Steck on 4/2/17.
//  Copyright © 2017 Dylan Steck. All rights reserved.
//

import Foundation
import UIKit
import Parse

class ReactionsViewController: UIViewController {

    override func viewDidLoad(){
        runReactions()

    }

    func runReactions(){
        
        let descriptionLabel = UILabel(frame: CGRect(x: 50, y: 100, width: 200 , height: 200 ))
        descriptionLabel.text = ("Add attachments like work you have done, comment on news, react and more. Experience reactions and post your own to the community.")
        descriptionLabel.font =  UIFont(name: "WeissenhofGrotesk-Medium", size: 14)!
        descriptionLabel.textColor = UIColor(red:0.15, green:0.18, blue:0.22, alpha:1.00)
        descriptionLabel.contentMode = UIViewContentMode.scaleAspectFit
        descriptionLabel.numberOfLines = 6
        self.view.addSubview(descriptionLabel)
        
        let goBackButton = UIButton(frame: CGRect(x: 50, y: 300, width: 200 , height: 200 ))
        goBackButton.backgroundColor = UIColor(red:0.15, green:0.18, blue:0.22, alpha:1.00)
        goBackButton.setTitle("Go Back", for: .normal)
        goBackButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        self.view.addSubview(goBackButton)
        

    
    
    }
    
    func buttonAction(sender: UIButton!) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "HomepageViewController")
        self.present(viewController, animated: true)

    }
}
