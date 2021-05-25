//
//  MockURLSession.swift
//  OpenMarket
//
//  Created by sookim on 2021/05/25.
//

import Foundation
import UIKit

class MockURLSessionDataTask: URLSessionDataTask {
    override init() { }
    var resumeDidCall: () -> Void = {}

    override func resume() {
        resumeDidCall() // 클로저 호출
    }
}

class MockURLSession: URLSessionProtocol {

    var makeRequestFail = false // request 를 실패하도록 만드는 플래그
    init(makeRequestFail: Bool = false) {
        self.makeRequestFail = makeRequestFail
    }

    var sessionDataTask: MockURLSessionDataTask?

    // dataTask 를 구현합니다.
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {

        // 성공시 callback 으로 넘겨줄 response
        let successResponse = HTTPURLResponse(url: MakeURL.viewArticle(1).url,
                                              statusCode: 200,
                                              httpVersion: "2",
                                              headerFields: nil)
        // 실패시 callback 으로 넘겨줄 response
        let failureResponse = HTTPURLResponse(url: MakeURL.viewArticle(1).url,
                                              statusCode: 410,
                                              httpVersion: "2",
                                              headerFields: nil)

        let sessionDataTask = MockURLSessionDataTask()

        // resume() 이 호출되면 completionHandler() 가 호출되도록 합니다.
        sessionDataTask.resumeDidCall = {
            if self.makeRequestFail {
                completionHandler(nil, failureResponse, nil)
            } else {
                guard let itemsData = NSDataAsset(name: "Item") else { return }
                completionHandler(itemsData.data, successResponse, nil)
            }
        }
        self.sessionDataTask = sessionDataTask
        
        return sessionDataTask
    }
}
