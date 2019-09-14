//
//  SourcesInteractor.swift
//  NewsArticle
//
//  Created by Muhammad Waqas on 9/13/19.
//  Copyright © 2019 Muhammad Waqas. All rights reserved.
//

import Foundation


class SourcesInteractor: SourcesInteractorProtocol {
    
    var sourcesGateway: SourcesEntityGatewayProtocol
    
    init(_ gateway: SourcesEntityGatewayProtocol) {
        sourcesGateway = gateway
    }
    
    /**
     Get sources from entity gateway
     
     - completion: it will return sources or error fetched from entity gateway
     
     This method creates VIPER stack for Sources module which includes, View, Interactor, Presenter, Entity and gateway.
     */
    
    func onFetchSources(_ completion: @escaping ([Sources]?, APIError?) -> ()) {
        let request = APIRequest.sources
        sourcesGateway.fetchSources(request, completion: completion)
    }
    
}
