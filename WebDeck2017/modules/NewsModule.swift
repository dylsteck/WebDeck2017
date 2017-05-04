//
//  NewsModule.swift
//  WebDeck2017
//
//  Created by Dylan Steck on 5/3/17.
//  Copyright © 2017 Dylan Steck. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
import Kingfisher
import Alamofire

class NewsModule {

    var newsArray = [JSON]()
    var newsString = [String]()
    var hvc = HomeViewController()

    func getNews() {
        Alamofire.request("https://newsapi.org/v1/articles?source=the-wall-street-journal&sortBy=top&apiKey=88729f588b05434099e6bcbbba4ab167").validate().responseJSON
        { response in
            switch response.result {
            case .success(let data):
                let json = JSON(data)
                self.newsArray = json["articles"].arrayValue
                for article in self.newsArray {
                    //Pulls the title and Image from the JSON and appends each title to the array
                    let title = article["title"].stringValue
                    let image = article["urlToImage"].stringValue
                    let url = article["url"].stringValue
                    //                        print("title \(title)")
                    //                        print(image)
                    //                        print(url)
                    //my array is actualy a string
                    self.newsString.append(title)
                    self.hvc.pageControl.numberOfPages = self.newsArray.count
                }
                print (self.newsString)
            case .failure(let error):
                print(error)
            }
        }

    }

}
