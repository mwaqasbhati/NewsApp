//
//  PostListRemoteDataManager.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//

import Foundation

class NewsGateway: NewsEntityGatewayProtocol {

    var dispatcher: NetworkDispatcher?
    
    required init(_ dispatcher: NetworkDispatcher) {
        self.dispatcher = dispatcher
    }
    
    /**
     Execute a URLRequest via network API.
     
     
     - parameter request: Request object of NSURLSession.
     - parameter decode: Decodable Model for this particular API.
     - parameter completion: Result object which will contain objects or error.
     
     This method accepts a Request object containing (path, method, parameters), Decodable entity type and completion block which will be called when we will get data.
     */
    
    func fetchNews(_ request: APIRequest, completion: @escaping ([News]?, Error?) -> ()) {
        dispatcher?.execute(request: request, decode: NewsResponse.self) { (response) in
            switch response {
            case .success(let news):
                completion(news.news, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
