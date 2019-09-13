//
//  NewsTests.swift
//  NewsNewsTests
//
//  Created by macadmin on 7/25/19.
//  Copyright © 2019 Muhammad Waqas. All rights reserved.
//

import UIKit
import XCTest
@testable import NewsNews

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
        let dataManager = NewsNetworkClient(dispatcher)
        dataManager.remoteRequestHandler = self
        let request = APIRequest.news(section: "all-sections", timePeriod: TimePeriod.Week.rawValue, offset:20)
        dataManager.loadNews(request, section: "all-sections", timePeriod: TimePeriod.Week, offset: 20)
        waitForExpectations(timeout: 60.0) { (error) in
            XCTAssertNil(error, "Error")
        }

    }
    
    func testNewsSectionFetchingService() {
        promise = expectation(description: "News Sections API Test")
        let dispatcher = NetworkDispatcher(configuration: URLSession(configuration: .default))
        let dataManager = NewsNetworkClient(dispatcher)
        dataManager.remoteRequestHandler = self
        let request = APIRequest.newsSections
        dataManager.loadNewsSections(request)
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

extension NewsTests: NewsDataManagerOutputProtocol {
    
    func onNewsSectionRetrieved(_ news: NewsSectionBase) {
        XCTAssertTrue(true, "Success")
        promise.fulfill()
    }
    func onNewsRetrieved(_ news: NewsBase) {
        XCTAssertTrue(true, "Success")
        promise.fulfill()
    }
    func onError(_ error: Error) {
        XCTAssertThrowsError(error)
        promise.fulfill()
    }
    
}

