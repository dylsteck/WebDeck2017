
//
//  NewsModule.swift
//  WebDeck2017
//
//  Created by Dylan Steck on 5/25/17.
//  Copyright © 2017 Dylan Steck. All rights reserved.
//
import UIKit
import Foundation
import SwiftyJSON
import Kingfisher
import Alamofire

extension HomeViewController {

    
    func getNews() {
        Alamofire.request("https://newsapi.org/v1/articles?source=the-wall-street-journal&sortBy=top&apiKey=88729f588b05434099e6bcbbba4ab167").validate().responseJSON
            { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    self.newsArray = json["articles"].arrayValue
                    for article in self.newsArray {
                        //Pulls the title and Image from the JSON and appends each title to the string
                        let title = article["title"]
                        var imageLink = article["urlToImage"].stringValue
                        var imageURL = URL(string: imageLink)
                        let url = article["url"].stringValue
                        //                        print("title \(title)")
                        //                        print(image)
                        //                        print(url)
                        print (title.stringValue)
                        ImageDownloader.default.downloadImage(with: imageURL!, options: [], progressBlock: nil) {
                            (image, error, url, data) in
                            print("Downloaded Image: \(image)")
                          //  let image = NewsCell().newsImage
                        }
                        self.newsTitles.append(title)
                        let newsTitles = NewsCell().newsTitles
                    }
                    print (self.newsTitles)
                case .failure(let error):
                    print(error)
                }
        }
        
    }
    
}
