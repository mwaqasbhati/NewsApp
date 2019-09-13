//
//  ArticleListInteractor.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//


class ArticleListInteractor {
    weak var presenter: ArticleListInteractorOutputProtocol?
    var dataManager: ArticleListDataManagerInputProtocol?
}

// MARK: Interactor to DataManager
extension ArticleListInteractor: ArticleListInteractorInputProtocol {
    func loadSources() {
        let request = APIRequest.sources
        dataManager?.loadSources(request)
    }
    func loadNews(_ source: String) {
        let request = APIRequest.headlineNews(source)
        dataManager?.loadNews(request)
    }
}

// MARK: Interactor to Presenter
extension ArticleListInteractor: ArticleListDataManagerOutputProtocol {
    func onSourcesRetrieved(_ sources: [Sources]) {
        presenter?.didSourcesSuccess(sources)
    }
    func onNewsRetrieved(_ articles: [Articles]) {
        presenter?.didNewsListSuccess(articles)
    }
    func onError(_ error: Error) {
        presenter?.onError(error)
    }
}
