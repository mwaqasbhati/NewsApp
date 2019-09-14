//
//  NewsTests.swift
//  NewsNewsTests
//
//  Created by macadmin on 7/25/19.
//  Copyright © 2019 Muhammad Waqas. All rights reserved.
//

import UIKit
import XCTest
@testable import NewsArticle

class NewsTests: XCTestCase {

    private var promise: XCTestExpectation!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNewsViewInitializing() {
        XCTAssertNotNil(NewsRouter.createNewsModule(), "Error Initializing News List View")
    }
    func testNewsFetchingService() {
        promise = expectation(description: "News Listing API Test")
        let dispatcher = NetworkDispatcher(configuration: URLSession(configuration: .default))
        let entityGateway = NewsGateway(dispatcher)
        let request = APIRequest.headlineNews("bbc-news")
        entityGateway.fetchNews(request) { [weak self] (news, error) in
            if error == nil {
                XCTAssertTrue(true, "Success")
                self?.promise.fulfill()
            } else {
                XCTAssertThrowsError(error)
                self?.promise.fulfill()
            }
        }
        waitForExpectations(timeout: 60.0) { (error) in
            XCTAssertNil(error, "Error")
        }
    }
    
    func testNewsSectionFetchingService() {
        promise = expectation(description: "News Sources API Test")
        let dispatcher = NetworkDispatcher(configuration: URLSession(configuration: .default))
        let entityGateway = SourcesEntityGateway(dispatcher)
        let request = APIRequest.sources
        entityGateway.fetchSources(request) { [weak self] (sources, error) in
            if error == nil {
                XCTAssertTrue(true, "Success")
                self?.promise.fulfill()
            } else {
                XCTAssertThrowsError(error)
                self?.promise.fulfill()
            }
        }
        waitForExpectations(timeout: 60.0) { (error) in
            XCTAssertNil(error, "Error")
        }
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    
}


