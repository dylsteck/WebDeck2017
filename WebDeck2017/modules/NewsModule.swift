//
//  NewsModule.swift
//  WebDeck2017
//
//  Created by Dylan Steck on 5/25/17.
//  Copyright © 2017 Dylan Steck. All rights reserved.
//

import Foundation
import UIKit

class NewsModule: UITableViewDataSource{

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Weather"
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CategoryRow
    }
}
