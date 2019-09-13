//
//  ArticleListProtocols.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//

import UIKit


protocol ArticleListViewProtocol: class {
    var presenter: ArticleListPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func presentSources(_ sources: [Sources])
    func presentNews(_ articles: [Articles])
    func showError(_ message: String)
    func showLoading()
    func hideLoading()
}

protocol ArticleListWireFrameProtocol: class {
    // PRESENTER -> WIREFRAME
    func presentNewsDetail(from view: ArticleListViewProtocol, article: Articles)
}

protocol ArticleListPresenterProtocol: class {
    var view: ArticleListViewProtocol? { get set }
    var interactor: ArticleListInteractorInputProtocol? { get set }
    var wireFrame: ArticleListWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewSources()
    func viewNews(_ source: String)
    func moveToDetailView(_ article: Articles)
}

protocol ArticleListInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didNewsListSuccess(_ articles: [Articles])
    func didSourcesSuccess(_ sources: [Sources])
    func onError(_ error: Error)
}

protocol ArticleListInteractorInputProtocol: class {
    var presenter: ArticleListInteractorOutputProtocol? { get set }
    var dataManager: ArticleListDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func loadSources()
    func loadNews(_ source: String)
}

protocol ArticleListDataManagerInputProtocol: class {
    var remoteRequestHandler: ArticleListDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> DATAMANAGER
    func loadSources(_ request: Request)
    func loadNews(_ request: Request)
}

protocol ArticleListDataManagerOutputProtocol: class {
    // DATAMANAGER -> INTERACTOR
    func onSourcesRetrieved(_ sources: [Sources])
    func onNewsRetrieved(_ articles: [Articles])
    func onError(_ error: Error)
}

