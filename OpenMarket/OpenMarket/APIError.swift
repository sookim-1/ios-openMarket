//
//  APIError.swift
//  OpenMarket
//
//  Created by sookim on 2021/05/25.
//

import Foundation

enum APIError: LocalizedError {
    case unknownError
    case responseError(Int)
    
    var errorDescription: String? {
        switch self {
        case .unknownError:
            return "unknownError"
        case .responseError(let code):
            return "\(code)Error"
        }
    }
}
