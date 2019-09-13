//
//  ArticleListPresenter.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//


class ArticleListPresenter {
    weak var view: ArticleListViewProtocol?
    var interactor: ArticleListInteractorInputProtocol?
    var wireFrame: ArticleListWireFrameProtocol?
}

// MARK: - Presenter to Interactor
extension ArticleListPresenter: ArticleListPresenterProtocol {
    func viewSources() {
        view?.showLoading()
        interactor?.loadSources()
    }
    func viewNews(_ source: String) {
        view?.showLoading()
        interactor?.loadNews(source)
    }
    func moveToDetailView(_ article: Articles) {
        if let view = view {
            wireFrame?.presentNewsDetail(from: view, article: article)
        }
    }
}

// MARK: - Presenter to View
extension ArticleListPresenter: ArticleListInteractorOutputProtocol {
    func didNewsListSuccess(_ articles: [Articles]) {
        view?.hideLoading()
        view?.presentNews(articles)
    }
    func didSourcesSuccess(_ sources: [Sources]) {
        view?.hideLoading()
        view?.presentSources(sources)
    }

    func onError(_ error: Error) {
        view?.hideLoading()
        view?.showError(error.localizedDescription)
    }
    
}


