//
//  Reaction.swift
//  WebDeck2017
//
//  Created by Dylan Steck on 5/25/17.
//  Copyright © 2017 Dylan Steck. All rights reserved.
//
import Foundation
import UIKit
import Parse

class Reaction {


    func sendReaction(reactionTitle: UITextField!, reactionContent: UITextField!, showPresent: ()) {
        let reaction = PFObject(className: "Reactions")
        reaction["title"] = reactionTitle.text
        reaction["content"] = reactionContent.text
        reaction["parent"] = PFUser.current()
        reaction.saveInBackground { (succeeded, error) -> Void in
            if succeeded {
                print("Success with Parse yyyaboi")
                print(reaction)
                self.showPresent()
            }
                else {
                let alert = UIAlertView(title: "Error", message: "There has been a server error.", delegate: self, cancelButtonTitle: "OK")
                alert.show()
                    print("parse failure :(")
            }
        }
    }

    func showPresent(){
    }

}
