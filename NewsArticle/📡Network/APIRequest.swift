//
//  APIRequest.swift
//  NewsNews
//
//  Created by Muhammad Waqas on 7/24/19.
//  Copyright © 2019 Muhammad Waqas. All rights reserved.
//

import Foundation

public enum APIRequest {
    case sources
    case headlineNews(_ source: String)
}

extension APIRequest: Request {
    
    public var path: String {
        switch self {
        case .sources:
            return Configuration.apiPathSources()
        case .headlineNews:
            return Configuration.apiPathNews()
        }
    }
    
    public var parameters: RequestParams {
        let key = Configuration.getApiKey()
        switch self {
        case .sources:
            return .url(["apiKey": key])
        case .headlineNews(let source):
            return .url(["apiKey": key, "sources": source])
        }
    }
    
    public var headers: [String : Any]? {
        return [:]
    }
    
    public var method: HTTPMethod {
        switch self {
        case .sources:
            return .get
        case .headlineNews:
            return .get
        }
    }
    
    public var dataType: DataType {
        switch self {
        case .sources:
            return .Json
        case .headlineNews:
            return .Json
        }
    }
}
