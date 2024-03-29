//
//  NetworkError.swift
//  Cezan
//
//  Created by Muhammad Waqas on 5/10/19.
//  Copyright © 2019 Muhammad Waqas. All rights reserved.
//

import Foundation

struct ResponseError: Decodable {
    let message: String
    let code: Int
}

enum APIError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure
    case internetError
    case unknown
    case responseError(String)
    
    var localizedDescription: String {
        switch self {
        case .requestFailed: return "Request Failed."
        case .invalidData: return "Invalid Data."
        case .responseUnsuccessful: return "Response Unsuccessful."
        case .jsonParsingFailure: return "JSON Parsing Failure."
        case .jsonConversionFailure: return "JSON Conversion Failure."
        case .internetError: return "No internet connection, please try again later."
        case .unknown: return "Unknown error occur, please try again later."
        case .responseError(let message):
            return message
        }
    }
}
