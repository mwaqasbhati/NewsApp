//
//  Configuration.swift
//  NewsArticle
//
//  Created by Muhammad Waqas on 7/24/19.
//  Copyright © 2019 Muhammad Waqas. All rights reserved.
//

import Foundation

class Configuration {
    
    private static let basePath = "https://newsapi.org/v2"
    private static let apiKey = "f2239070aa004fb88e364a014db97354"
    //
    /**
     Returns the API Path for Most Viewed items list.
     
     - parameter section: Section to search e.g. all-sections.
     - parameter timePeriod: Time Period e.g. 1, 7, 30.
     - parameter offset: Pagination offset for the request.
     - returns: Full URL string for Most Viewed with api key and offset params inclusive.
     */
    public static func apiPathNews() -> String {
        return basePath + "/top-headlines"
    }
    
    /**
     Returns the API Path for available section names list.
     
     - returns: Full URL string for sections list with api key inclusive.
     */
    public static func apiPathSources() -> String {
        return basePath + "/sources"
    }
    
    /**
     Concatenates the API Key to a given url.
     
     - parameter path: Path to concatenate api key.
     
     - returns: Full URL string for given path with api key inclusive.
     */
    static  func getApiKey() -> String {
        
       // let base64data = Data(base64Encoded: apiKey)
        
       // let apiKeyString = String(data: base64data!, encoding: .utf8)!
        
        return apiKey
    }
}
