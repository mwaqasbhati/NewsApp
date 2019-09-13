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
    func didFetchNews(_ source: String, completion: @escaping ([NewsViewModel]?, Error?)->())
    func presentNewsDetail(_ view: NewsViewProtocol, object: NewsViewModel)
}

// News Interactor Protocol

protocol NewsInteractorProtocol {
    var newsGateway: NewsEntityGatewayProtocol {get set}
    
    func onFetchNews(_ source: String, completion: @escaping ([News]?, Error?)->())
}

// News Entity Gateway Protocol

protocol NewsEntityGatewayProtocol {
    func fetchNews(_ request: APIRequest, completion: @escaping ([News]?, Error?)->())
}

// News Router Protocol

protocol NewsRouterProtocol {
    static func createNewsModule() -> NewsViewProtocol?
    func presentNewsDetail(from view: NewsViewProtocol, news: News)
}

/*
protocol NewsViewProtocol: class, Showable {
    var presenter: NewsPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func presentNews(_ news: [NewsViewModel])
}

protocol NewsRouterProtocol: class {
    // PRESENTER -> WIREFRAME
    func presentNewsDetail(from view: NewsViewProtocol, news: News)
}

protocol NewsPresenterProtocol: class {
    var view: NewsViewProtocol? { get set }
    var interactor: NewsInteractorInputProtocol? { get set }
    var wireFrame: NewsRouterProtocol? { get set }
    var news: [News] {get set}
    // VIEW -> PRESENTER
    func viewNews(_ source: String)
    func moveToDetailView(_ selected: NewsViewModel)
}

protocol NewsInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didNewsSuccess(_ news: [News])
    func onError(_ error: Error)
}

protocol NewsInteractorInputProtocol: class {
    var presenter: NewsInteractorOutputProtocol? { get set }
    var dataManager: NewsDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func loadNews(_ source: String)
}

protocol NewsDataManagerInputProtocol: class {
    var remoteRequestHandler: NewsDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> DATAMANAGER
    func loadNews(_ request: Request)
}

protocol NewsDataManagerOutputProtocol: class {
    // DATAMANAGER -> INTERACTOR
    func onNewsRetrieved(_ news: [News])
    func onError(_ error: Error)
}
*/
