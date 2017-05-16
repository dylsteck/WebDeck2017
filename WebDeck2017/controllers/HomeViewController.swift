//
//  HomeViewController.swift
//  WebDeck2017
//
//  Created by Dylan Steck on 4/20/17.
//  Copyright © 2017 Dylan Steck. All rights reserved.
//
import Foundation
import UIKit
import TwicketSegmentedControl
import MaterialComponents.MaterialPageControl
import SwiftyJSON
import Kingfisher
import Alamofire

class HomeViewController: UIViewController, UIScrollViewDelegate {

    var logoImageView = UIImageView(image: UIImage(named: "WebDeckLogo"))
    let pageControl = MDCPageControl()
    let scrollView = UIScrollView()
    let pages = NSMutableArray()
    var newsArray = [JSON]()
    var newsString = [String]()



    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        scrollView.frame = self.view.bounds
        scrollView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        scrollView.delegate = self
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        view.addSubview(scrollView)
        
        

        // getnews
        Alamofire.request("https://newsapi.org/v1/articles?source=the-wall-street-journal&sortBy=top&apiKey=88729f588b05434099e6bcbbba4ab167").validate().responseJSON
            { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    self.newsArray = json["articles"].arrayValue
                    self.scrollView.contentSize = CGSize(width: self.view.bounds.width * CGFloat(self.newsArray.count),
                                                    height: self.view.bounds.height)
                        // Add pages to scrollView.
                        for (i, article) in self.newsArray.enumerated() {
                            let pageFrame: CGRect = self.view.bounds.offsetBy(dx: CGFloat(i) * self.view.bounds.width, dy: 0)
                            let page = UILabel.init(frame:pageFrame)
                            page.text = String(format: "\(article["title"].stringValue)")
                            page.font = page.font.withSize(50)
                            page.textColor = UIColor.init(white: 0, alpha: 0.8)
                            page.backgroundColor = UIColor.red
                            page.textAlignment = NSTextAlignment.center
                            page.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin]
                            self.scrollView.addSubview(page)
                            self.pages.add(page)
                    }
                        self.pageControl.numberOfPages = self.newsArray.count

                case .failure(let error):
                    print(error)
                }
        }
        //end of news
        

        
    
      
        let pageControlSize = pageControl.sizeThatFits(view.bounds.size)
        pageControl.frame = CGRect(x: 0,
                                   y: view.bounds.height - pageControlSize.height,
                                   width: view.bounds.width,
                                   height: pageControlSize.height)
        pageControl.addTarget(self, action: #selector(didChangePage), for: .valueChanged)
        pageControl.autoresizingMask = [.flexibleTopMargin, .flexibleWidth]
        view.addSubview(pageControl)
    }

    // MARK: - Frame changes
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        let pageBeforeFrameChange = pageControl.currentPage
        for (i, page) in pages.enumerated() {
            let pageLabel: UILabel = page as! UILabel
            pageLabel.frame = view.bounds.offsetBy(dx: CGFloat(i) * view.bounds.width, dy: 0)
        }
        scrollView.contentSize = CGSize(width: view.bounds.width * CGFloat(pages.count),
                                        height: view.bounds.height)
        var offset = scrollView.contentOffset
        offset.x = CGFloat(pageBeforeFrameChange) * view.bounds.width
        // This non-anmiated change of offset ensures we keep the same page
        scrollView.contentOffset = offset
    }

    // MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        pageControl.scrollViewDidScroll(scrollView)
    }

    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        pageControl.scrollViewDidEndDecelerating(scrollView)
    }

    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        pageControl.scrollViewDidEndScrollingAnimation(scrollView)
    }

    // MARK: - User events
    func didChangePage(_ sender: MDCPageControl) {
        var offset = scrollView.contentOffset
        offset.x = CGFloat(sender.currentPage) * scrollView.bounds.size.width
        scrollView.setContentOffset(offset, animated: true)
    }

    // MARK: CatalogByConvention
    class func catalogBreadcrumbs() -> [String] {
        return [ "Page Control", "Swift example"]
    }

    // Creates a UIColor from a 24-bit RGB color encoded as an integer.
    // Pass in hex color values like so: ColorFromRGB(0x1EAAF1).
    class func ColorFromRGB(_ rgbValue: UInt32) -> UIColor {
        return UIColor.init(red: ((CGFloat)((rgbValue & 0xFF0000) >> 16)) / 255,
                            green: ((CGFloat)((rgbValue & 0x00FF00) >> 8)) / 255,
                            blue: ((CGFloat)((rgbValue & 0x0000FF) >> 0)) / 255,
                            alpha: 1)
    }
}
