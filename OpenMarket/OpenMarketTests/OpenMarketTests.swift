//
//  OpenMarketTests.swift
//  OpenMarketTests
//
//  Created by sookim on 2021/05/25.
//

import XCTest
@testable import OpenMarket

class OpenMarketTests: XCTestCase {
    
    var sut: APIProvider!
    var expectation: XCTestExpectation!
    let apiURL = MakeURL.viewArticle(1).url
    
    //       override func setUpWithError() throws {
    //           sut = .init(session: MockURLSession())
    //       }
    //
    //       func test_fetchRandomJoke() {
    //           let expectation = XCTestExpectation()
    //           guard let itemsData = NSDataAsset(name: "Item") else { return }
    //           let response = try? JSONDecoder().decode(DetailArticle.self,
    //                                                    from: itemsData.data)
    //
    //        sut.getViewArticleList { (result: Result<DetailArticle, Error>) in
    //               switch result {
    //               case .success(let joke):
    //                XCTAssertEqual(joke.title, response?.title)
    //                XCTAssertEqual(joke.currency, response?.currency)
    //               case .failure:
    //                   XCTFail()
    //               }
    //               expectation.fulfill()
    //           }
    //
    //           wait(for: [expectation], timeout: 2.0)
    //       }
    //
    //       func test_fetchRandomJoke_failure() {
    //           sut = .init(session: MockURLSession(makeRequestFail: true))
    //           let expectation = XCTestExpectation()
    //
    //           sut.getViewArticleList { (result: Result<DetailArticle, Error>) in
    //               switch result {
    //               case .success:
    //                   XCTFail()
    //               case .failure(let error):
    //                   XCTAssertEqual(error.localizedDescription, "15326Error")
    //               }
    //               expectation.fulfill()
    //           }
    //
    //           wait(for: [expectation], timeout: 2.0)
    //       }
    //
    
    override func setUp() {
        let configuration = URLSessionConfiguration.default
        configuration.protocolClasses = [MockURLProtocol.self]
        let urlSession = URLSession.init(configuration: configuration)
        
        sut = APIProvider(session: urlSession)
        
        
        expectation = expectation(description: "Expectation")
    }
    
    func testSuccessfulResponse() {

        
        guard let assetData = NSDataAsset(name: "Item") else { return }
        let resultData: Data = assetData.data
        let apiURL = MakeURL.viewArticle(1).url
        
        
        MockURLProtocol.requestHandler = { request in
            
//            guard let url = request.url, url == self.apiURL else {
//                throw APIError.unknownError
//            }
            
            let response = HTTPURLResponse(url: self.apiURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, assetData.data)
        }
        
        // Call API.
        sut.getViewArticleList { (result: Result<DetailArticle, Error>) in
            switch result {
            case .success(let post):
                XCTAssertEqual(post.id, 5)
                XCTAssertEqual(post.title, "Incorrect title.")
                XCTAssertEqual(post.currency, "Incorrect body.")
            case .failure(let error):
                XCTFail("Error was not expected: \(error.localizedDescription)")
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testParsingFailure() {
        // Prepare response
        let data = Data()
        guard let assetData = NSDataAsset(name: "Item") else { return }
        let apiURL = MakeURL.viewArticle(1).url
        MockURLProtocol.requestHandler = { request in
            let response = HTTPURLResponse(url: apiURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
        // Call API.
        sut.getViewArticleList { (result: Result<DetailArticle, Error>) in
            switch result {
            case .success(_):
                XCTFail("Success response was not expected.")
            case .failure(let error):
                guard let error = error as? APIError else {
                    XCTFail("Incorrect error received.")
                    self.expectation.fulfill()
                    return
                }
                
            //XCTAssertEqual(error, APIError.responseError(5), "Parsing error was expected.")
            }
            self.expectation.fulfill()
        }
        wait(for: [expectation], timeout: 1.0)
    }
    
}
