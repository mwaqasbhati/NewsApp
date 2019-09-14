//
//  NewsNewsTests.swift
//  NewsNewsTests
//
//  Created by Muhammad Waqas on 7/24/19.
//  Copyright © 2019 Muhammad Waqas. All rights reserved.
//

import XCTest
@testable import NewsArticle

class NewsDetailTests: XCTestCase {

    private let news = Data("""
                                {
                                "author": "Cole Petersen",
                                "title": "Bitcoin Pushes Higher as Bulls Target $10,800",
                                "description": "After facing a sudden influx of selling pressure yesterday, Bitcoin’s bulls have been able to defend its position within the mid-$10,000 region and are now pushing BTC up towards its next key resistance level around $10,400. Assuming that this level is broken…",
                                "url": "https://www.newsbtc.com/2019/09/14/bitcoin-pushes-higher-as-bulls-target-10800/",
                                "urlToImage": "https://www.newsbtc.com/wp-content/uploads/2019/09/shutterstock_1029670141-1200x780.jpg",
                                "publishedAt": "2019-09-14T19:30:44Z",
                                "content": "After facing a sudden influx of selling pressure yesterday, Bitcoins bulls have been able to defend its position within the mid-$10,000 region and are now pushing BTC up towards its next key resistance level around $10,400.\r\nAssuming that this level is broken… [+2647 chars]"
                                }
                            """.utf8)
    
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testNewsModel() throws {
        let result = parseNews()
        if (result.0 != nil) {
            XCTAssertTrue(true)
        } else if let error = result.1 {
            XCTFail("Error while converting to model \(error.localizedDescription)")
        }
    }
    func testNewsDetailViewInitializing() {
        let result = parseNews()
        if let news = result.0 {
            XCTAssertNotNil(NewsDetailRouter.createNewsDetailModule(news), "Error Initializing News Detail View")
        }
    }

    private func parseNews()->(News?, Error?) {
        do {
            let result = try JSONDecoder().decode(News.self, from: news)
            return (result,nil)
        } catch let error {
            return (nil,error)
        }
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    

}
