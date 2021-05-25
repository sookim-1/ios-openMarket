//
//  JsonModel.swift
//  OpenMarket
//
//  Created by sookim on 2021/05/25.
//

import Foundation

struct EntireArticle: Decodable {
    let page: Int
    let items: [EssentialArticle]
}

struct EssentialArticle: Decodable {
    let id: Int
    let title: String
    let price: Int
    let currency: String
    let stock: Int
    let discountedPrice: Int?
    let thumbnails: [String]
    let registrationDate: Double
    
    enum CodingKeys : String, CodingKey {
        case id, title, price, currency, stock, thumbnails
        case discountedPrice = "discounted_price"
        case registrationDate = "registration_date"
    }
}

struct DetailArticle: Decodable {
    let id: Int
    let title: String
    let price: Int
    let descriptions: String
    let currency: String
    let stock: Int
    let images: [String]
    let discountedPrice: Int?
    let thumbnails: [String]
    let registrationDate: Double
    
    enum CodingKeys : String, CodingKey {
        case id, title, price, currency, stock, thumbnails, descriptions, images
        case discountedPrice = "discounted_price"
        case registrationDate = "registration_date"
    }
}
