//
//  NewsProtocols.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//

import UIKit

// New View Protocol

protocol NewsViewProtocol {
    var presenter: NewsPresenterProtocol? {get set}
    var sourcePresenter: SourcesPresenterProtocol? {get set}
    
}

// News Presenter Protocol

protocol NewsPresenterProtocol {
    var newsInteractor: NewsInteractorProtocol {get set}
    var newsRouter: NewsRouterProtocol {get set}
    var didSelectNews: ((_ index: Int)->())? {get set}
    var news: [News]? {get set}
    var didNewsError: ((_ error: String)->())? {get set}
    
    func didFetchNews(_ source: String, completion: @escaping ([NewsViewModel])->())
    func presentNewsDetail(_ view: NewsViewProtocol, object: NewsViewModel)
}

// News Interactor Protocol

protocol NewsInteractorProtocol {
    var newsGateway: NewsEntityGatewayProtocol {get set}
    
    func onFetchNews(_ source: String, completion: @escaping ([News]?, APIError?)->())
}

// News Entity Gateway Protocol

protocol NewsEntityGatewayProtocol {
    func fetchNews(_ request: APIRequest, completion: @escaping ([News]?, APIError?)->())
}

// News Router Protocol

protocol NewsRouterProtocol {
    static func createNewsModule() -> NewsViewProtocol?
    func presentNewsDetail(from view: NewsViewProtocol, news: News)
}

