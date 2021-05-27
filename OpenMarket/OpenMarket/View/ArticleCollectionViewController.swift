//
//  ArticleCollectionViewController.swift
//  OpenMarket
//
//  Created by sookim on 2021/05/27.
//

import UIKit

class ArticleCollectionViewController: UIViewController {
    let getEssentialArticle = GetEssentialArticle(urlProcess: URLProcess())
    let urlProcess = URLProcess()
    
    override func viewDidLoad() {


    }
}

extension ArticleCollectionViewController: UICollectionViewDelegate {
    
}

extension ArticleCollectionViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 19
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ArticleCollectionViewCell", for: indexPath) as? ArticleCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let baseURL = urlProcess.setBaseURL(urlString: "https://camp-open-market-2.herokuapp.com/")!
        let url = urlProcess.setUserActionURL(baseURL: baseURL, userAction: .viewArticleList, index: "1")!
        
        getEssentialArticle.getParsing(url: url) { (param: Result<EntireArticle, Error>) in
            switch param {
            case .success(let entire):
                DispatchQueue.main.async {
                                       
                    cell.articleTitle.text = entire.items[indexPath.row].title
                    cell.articlePrice.text = "\(entire.items[indexPath.row].currency) \(entire.items[indexPath.row].price)"
                    cell.articleStock.text = "\(entire.items[indexPath.row].stock)"
                    cell.articleDiscountedPrice.text = "\(entire.items[indexPath.row].currency) \(entire.items[indexPath.row].discountedPrice)"
                    
                    let url = URL(string: entire.items[indexPath.row].thumbnails[0] ?? "")
                    do {
                        let data = try Data(contentsOf: url!)
                        cell.articleImage.image = UIImage(data: data)
                        
                    } catch { }

                }
                
                
            case .failure(let error):
                print("error")
            }
            
        }
        
        return cell
    }
    
    
}

extension ArticleCollectionViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSpacing: CGFloat = 10
        let textAreaHeight: CGFloat = 65
        
        let width: CGFloat = (collectionView.bounds.width - itemSpacing)/2
        let height: CGFloat = width * 10/7 + textAreaHeight
        
        return CGSize(width: width, height: height)
    }
    
}
