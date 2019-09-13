//
//  ArticleDetailPresenter.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//


class ArticleDetailPresenter {
    
    var article: Articles
    weak var view: ArticleDetailViewProtocol?
    var interactor: ArticleDetailInteractorInputProtocol?
    var wireFrame: ArticleDetailWireFrameProtocol?
    
    init(_ article: Articles) {
        self.article = article
    }
}

extension ArticleDetailPresenter: ArticleDetailPresenterProtocol { }
extension ArticleDetailPresenter: ArticleDetailInteractorOutputProtocol { }


