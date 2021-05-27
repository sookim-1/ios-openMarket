//
//  ArticleCollectionViewCell.swift
//  OpenMarket
//
//  Created by sookim on 2021/05/27.
//

import UIKit

class ArticleCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var articleTitle: UILabel!
    @IBOutlet weak var articlePrice: UILabel!
    @IBOutlet weak var articleDiscountedPrice: UILabel!
    @IBOutlet weak var articleImage: UIImageView!
    @IBOutlet weak var articleStock: UILabel!
}
