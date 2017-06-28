//
//  NewsCell.swift
//  WebDeck2017
//
//  Created by Dylan Steck on 5/27/17.
//  Copyright © 2017 Dylan Steck. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class NewsCell: UITableViewCell {
    var newsImage: UIImage!
    var newsTitles = [JSON]()
}

extension NewsCell: UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cnCell", for: indexPath) as! UICollectionViewCell
       //cell.backgroundColor = UIColor(patternImage: newsImage)
        var title = UILabel(frame: CGRect(x:0, y:0, width: cell.bounds.size.width, height:40))
       // title.text = self.newsTitles[(indexPath as NSIndexPath).row].stringValue
        cell.contentView.addSubview(title)
        return cell
    }

}

extension NewsCell : UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let itemsPerRow:CGFloat = 4
        let hardCodedPadding:CGFloat = 5
        let itemWidth = (collectionView.bounds.width / itemsPerRow) - hardCodedPadding
        let itemHeight = collectionView.bounds.height - (2 * hardCodedPadding)
        return CGSize(width: itemWidth, height: itemHeight)
    }
    
}
