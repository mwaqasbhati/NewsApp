//
//  NewsInteractor.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//


class NewsInteractor: NewsInteractorProtocol {
    
    var newsGateway: NewsEntityGatewayProtocol
    
    init(_ gateway: NewsEntityGatewayProtocol) {
        newsGateway = gateway
    }
    
    func onFetchNews(_ source: String, completion: @escaping ([News]?, Error?)->()) {
        let request = APIRequest.headlineNews(source)
        newsGateway.fetchNews(request, completion: completion)
    }

}
