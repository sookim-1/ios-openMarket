//
//  ArticleTableViewController.swift
//  OpenMarket
//
//  Created by sookim on 2021/05/27.
//

import UIKit

class ArticleTableViewController: UIViewController {
    
    let getEssentialArticle = GetEssentialArticle(urlProcess: URLProcess())
    let urlProcess = URLProcess()
    
    override func viewDidLoad() {


    }
    
}

extension ArticleTableViewController: UITableViewDelegate {
    
}

extension ArticleTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ArticleTableViewCell", for: indexPath) as? ArticleTableViewCell else {
            return UITableViewCell()
        }
        
        let baseURL = urlProcess.setBaseURL(urlString: "https://camp-open-market-2.herokuapp.com/")!
        let url = urlProcess.setUserActionURL(baseURL: baseURL, userAction: .viewArticleList, index: "1")!
        
        getEssentialArticle.getParsing(url: url) { (param: Result<EntireArticle, Error>) in
            switch param {
            case .success(let entire):
                DispatchQueue.main.async {
                    
                    for i in 0..<entire.items.count {
                        cell.articleTitle.text = entire.items[i].title
                        cell.articlePrice.text = "\(entire.items[i].currency) \(entire.items[i].price)"
                        cell.articleStock.text = "\(entire.items[i].stock)"
                        cell.articleDiscountedPrice.text = "\(entire.items[i].currency) \(entire.items[i].discountedPrice)"
                        cell.articleImage.image = UIImage(named: entire.items[i].thumbnails[0] ?? "")
                    }
                }
                
                
            case .failure(let error):
                print("error")
            }
            
        }
        
        return cell
    }
    
    
}
