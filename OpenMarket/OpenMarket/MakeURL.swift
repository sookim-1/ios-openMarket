//
//  MakeURL.swift
//  OpenMarket
//
//  Created by sookim on 2021/05/25.
//

import Foundation

enum MakeURL {
    case viewArticleList(Int)
    case viewArticle(Int)
    
    static let baseURL = "https://camp-open-market-2.herokuapp.com"
    
    var path: String {
        switch self {
        case .viewArticleList(let page):
            return "/items/\(page)"
        case .viewArticle(let id):
            return "/item/\(id)"
        }
    }
    
    var url: URL {
        URL(string: MakeURL.baseURL + path)!
    }
}
