//
//  HomepageViewController.swift
//  WebDeck2017
//
//  Created by Dylan Steck on 3/12/17.
//  Copyright © 2017 Dylan Steck. All rights reserved.
//

import UIKit
import Foundation
import SwiftyJSON
import Parse
import TwicketSegmentedControl
import Alamofire

class HomepageViewController: UIViewController {
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var topView: UIView!
     var myArticles = [JSON]()
    var myArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topView.backgroundColor = UIColor(red:0.96, green:0.98, blue:0.99, alpha:1.00)
        
        let tableView: UITableView = UITableView()
        tableView.frame = CGRect(x: 10, y: 10, width: 100, height: 500)
        self.view.addSubview(tableView)
        
        if PFUser.current() != nil{
        let username = PFUser.current()!["username"] as! String
        self.usernameLabel.font = UIFont(name: "WeissenhofGrotesk-Bold", size: 16)!
        self.usernameLabel.text = ("Hello, " + username + "!")
        }
        else{
            // nothing
            print("user not logged in?")
        }
    
        let titles = ["Home", "Featured", "Your Day", "Sign Out"]
        //x is where it is on the x axis, y is where it is on the y axis, width is width, and height is height. Higher numbers in the y column get closer to the top of the frame, and smaller get it closer to the bottom.
        let frame = CGRect(x: 2, y: view.frame.height / 7, width: view.frame.width - 10, height: 40)
        let segmentedControl = TwicketSegmentedControl(frame: frame)
        segmentedControl.setSegmentItems(titles)
        segmentedControl.setSegmentItems(titles)
        segmentedControl.delegate = self
        view.addSubview(segmentedControl)
//        let button = UIButton(frame: frame)
//        self.view.addSubview(button)
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
}
    
    //    This is a function that is not in use, but lets you pull a image from JSON and have it be the image of an image view. Will come in handy
    func loadImageFromUrl(_ url: String, view: UIImageView){
        
        // Create Url from string
        let url = URL(string: url)!
        
        // Download task:
        // - sharedSession = global NSURLCache, NSHTTPCookieStorage and NSURLCredentialStorage objects.
        let task = URLSession.shared.dataTask(with: url, completionHandler: { (responseData, responseUrl, error) -> Void in
            // if responseData is not null...
            if let data = responseData{
                
                // execute in UI thread
                DispatchQueue.main.async(execute: { () -> Void in
                    view.image = UIImage(data: data)
                })
            }
        })
        
        // Run task
        task.resume()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
//        let url = "https://newsapi.org/v1/articles"
//        let params = [ "source" : "the-wall-street-journal" ,
//                       "sortBy" : "top" ,
//                       "apiKey" : "88729f588b05434099e6bcbbba4ab167"]
        
        Alamofire.request("https://newsapi.org/v1/articles?source=the-wall-street-journal&sortBy=top&apiKey=88729f588b05434099e6bcbbba4ab167").validate().responseJSON
            { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    self.myArticles = json["articles"].arrayValue
                    for article in self.myArticles {
                        //Pulls the title and Image from the JSON and appends each title to the array
                        let title = article["title"].stringValue
                        let image = article["urlToImage"].stringValue
                        let url = article["url"].stringValue
                        print("title \(title)")
                        print(image)
                        print(url)
                        self.myArray.append(title)
                        print (self.myArray)
                    //loadImageFromUrl(self.myImages[(indexPath as NSIndexPath).row], view: cell.tableViewImageView)
                    }
                case .failure(let error):
                    print(error)
                }
        }
        

    }
    
    
}

extension HomepageViewController: TwicketSegmentedControlDelegate {
    func didSelect(_ segmentIndex: Int) {
        print("Selected index: \(segmentIndex)")
        if segmentIndex == 3 {
            PFUser.logOut()
            let currentUser = PFUser.current()
            if currentUser == nil {
                print("user is nil")
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let viewController = storyboard.instantiateViewController(withIdentifier :"SignUpViewController") 
                self.present(viewController, animated: true)
                
            }
            else{
                print("user is not nil")
            };
        }
    }
}

extension HomepageViewController: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        NSLog("sections")
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        NSLog("rows")
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        NSLog("get cell")
        let cell = UITableViewCell(style: UITableViewCellStyle.value1, reuseIdentifier: "Cell")
        cell.textLabel!.text = "foo"
        return cell
    }


}

