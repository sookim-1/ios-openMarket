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

       override func setUpWithError() throws {
           sut = .init(session: MockURLSession())
       }

       func test_fetchRandomJoke() {
           let expectation = XCTestExpectation()
           guard let itemsData = NSDataAsset(name: "Items") else { return }
           let response = try? JSONDecoder().decode(EntireArticle.self,
                                                    from: itemsData.data)

        sut.getViewArticleList { (result: Result<EntireArticle, Error>) in
               switch result {
               case .success(let joke):
                XCTAssertEqual(joke.page, response?.page)
                XCTAssertEqual(joke.items.first?.title, response?.items.first?.title)
               case .failure:
                   XCTFail()
               }
               expectation.fulfill()
           }

           wait(for: [expectation], timeout: 2.0)
       }

       func test_fetchRandomJoke_failure() {
           sut = .init(session: MockURLSession(makeRequestFail: true))
           let expectation = XCTestExpectation()

           sut.getViewArticleList { (result: Result<EntireArticle, Error>) in
               switch result {
               case .success:
                   XCTFail()
               case .failure(let error):
                   XCTAssertEqual(error.localizedDescription, "15326Error")
               }
               expectation.fulfill()
           }

           wait(for: [expectation], timeout: 2.0)
       }

}
