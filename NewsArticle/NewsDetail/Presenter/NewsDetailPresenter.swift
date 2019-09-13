//
//  NewsDetailPresenter.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//


class NewsDetailPresenter {
    
    var news: News
    weak var view: NewsDetailViewProtocol?
    var interactor: NewsDetailInteractorInputProtocol?
    var wireFrame: NewsDetailRouterProtocol?
    
    init(_ news: News) {
        self.news = news
    }
}

extension NewsDetailPresenter: NewsDetailPresenterProtocol { }
extension NewsDetailPresenter: NewsDetailInteractorOutputProtocol { }


