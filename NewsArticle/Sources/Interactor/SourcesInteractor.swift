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
    
    func onFetchSources(_ completion: @escaping ([Sources]?, Error?) -> ()) {
        let request = APIRequest.sources
        sourcesGateway.fetchSources(request, completion: completion)
    }
    
}
