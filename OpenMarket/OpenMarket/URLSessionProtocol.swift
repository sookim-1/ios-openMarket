//
//  URLSessionProtocol.swift
//  OpenMarket
//
//  Created by sookim on 2021/05/25.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }
