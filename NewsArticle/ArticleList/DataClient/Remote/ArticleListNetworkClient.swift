//
//  PostListRemoteDataManager.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//

import Foundation

class ArticleListNetworkClient: ArticleListDataManagerInputProtocol {
    
    weak var remoteRequestHandler: ArticleListDataManagerOutputProtocol?
    var dispatcher: NetworkDispatcher?
    
    required init(_ dispatcher: NetworkDispatcher) {
        self.dispatcher = dispatcher
    }
    /**
     Fetch Article Sections via network API.
     
     
     - parameter request: Request object of NSURLSession.
     - parameter decode: Decodable Model for this particular API.
     - parameter completion: Result object which will contain objects or error.
     
     This method accepts a Request object containing (path, method, parameters), Decodable entity type and completion block which will be called when we will get data.
     */
    
    func loadSources(_ request: Request) {
        dispatcher?.execute(request: request, decode: SourceResponse.self) { [weak self] (response) in
            guard let `self` = self else { return }
            switch response {
            case .success(let response):
                self.remoteRequestHandler?.onSourcesRetrieved(response.sources ?? [Sources]())
            case .failure(let error):
                self.remoteRequestHandler?.onError(error)
            }
        }
    }
    
    /**
     Execute a URLRequest via network API.
     
     
     - parameter request: Request object of NSURLSession.
     - parameter decode: Decodable Model for this particular API.
     - parameter completion: Result object which will contain objects or error.
     
     This method accepts a Request object containing (path, method, parameters), Decodable entity type and completion block which will be called when we will get data.
     */
    
    func loadNews(_ request: Request) {
        dispatcher?.execute(request: request, decode: NewsResponse.self) { (response) in
            switch response {
            case .success(let articles):
                self.remoteRequestHandler?.onNewsRetrieved(articles.articles ?? [Articles]())
            case .failure(let error):
                self.remoteRequestHandler?.onError(error)
            }
        }
    }
}
