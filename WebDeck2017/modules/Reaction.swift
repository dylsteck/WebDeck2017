//
//  Reaction.swift
//  WebDeck2017
//
//  Created by Dylan Steck on 5/25/17.
//  Copyright © 2017 Dylan Steck. All rights reserved.
//
import Foundation
import UIKit
import Firebase

class Reaction {

    func sendReaction(reactionTitle: UITextField!, reactionContent: UITextField!, showPresent: ()) {

        let name = reactionTitle.text
        let content = reactionContent.text
        let user = Auth.auth().currentUser?.displayName
        
//        let reaction:[String : AnyObject] = [
//            "title" : text as AnyObject,
//            "content": content as AnyObject,
//            "belongs_to": user! as AnyObject
//        ]
        let reaction = ReactionModel(user: user!, name: name!, content: content!)
        
        let firebaseRef = Database.database().reference()
        firebaseRef.child("Reactions").childByAutoId().setValue(reaction.toAnyObject())
        
    }

    func showPresent(){
    }

}
