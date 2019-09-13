//
//  SourcesEntityGateway.swift
//  NewsArticle
//
//  Created by Muhammad Waqas on 9/13/19.
//  Copyright © 2019 Muhammad Waqas. All rights reserved.
//

import Foundation



class SourcesEntityGateway: SourcesEntityGatewayProtocol {
   
    var dispatcher: NetworkDispatcher?
    
    required init(_ dispatcher: NetworkDispatcher) {
        self.dispatcher = dispatcher
    }
    
    /**
     Fetch News Sections via network API.
     
     
     - parameter request: Request object of NSURLSession.
     - parameter decode: Decodable Model for this particular API.
     - parameter completion: Result object which will contain objects or error.
     
     This method accepts a Request object containing (path, method, parameters), Decodable entity type and completion block which will be called when we will get data.
     */
    
    func fetchSources(_ request: APIRequest, completion: @escaping ([Sources]?, Error?) -> ()) {
        dispatcher?.execute(request: request, decode: SourceResponse.self) { [weak self] (response) in
            guard self != nil else { return }
            switch response {
            case .success(let response):
                completion(response.sources, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
    
    
    
}
