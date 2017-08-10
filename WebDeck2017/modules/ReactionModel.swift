//
//  ReactionModel.swift
//  WebDeck2017
//
//  Created by Dylan Steck on 8/10/17.
//  Copyright © 2017 Dylan Steck. All rights reserved.
//

import UIKit
import Firebase

class ReactionModel: NSObject {
    var user: String
    var title: String
    var content: String
    
    init(user: String, title: String, content: String) {
        self.user = user
        self.title = title
        self.content = content
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String: String] else { return nil }
        guard let user  = dict["user"]  else { return nil }
        guard let title = dict["title"] else { return nil }
        guard let content = dict["content"] else { return nil }
        
        self.user = user
        self.title = title
        self.content = content
    }
    
    convenience override init() {
        self.init(user: "", title: "", content:  "")
    }
}
