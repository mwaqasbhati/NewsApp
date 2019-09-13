//
//  NewsPresenter.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//
import UIKit

class NewsPresenter: NewsPresenterProtocol {
    
    var newsInteractor: NewsInteractorProtocol
    var newsRouter: NewsRouterProtocol
    var news: [News]?
    var didSelectNews: ((_ index: Int)->())?
    
    init(_ interactor: NewsInteractorProtocol, router: NewsRouterProtocol) {
        newsInteractor = interactor
        newsRouter = router
    }
    
    func didFetchNews(_ source: String, completion: @escaping ([NewsViewModel]?, Error?)->()) {
        newsInteractor.onFetchNews(source) { [weak self] (news, error) in
            guard let `self` = self else { return }
            let newsVM = news?.map{ (object) -> NewsViewModel in
                return NewsViewModel(title: object.title, description: object.description, url: object.urlToImage, publishDate: object.publishedAt?.getDate())
            }
            self.news = news
            completion(newsVM, error)
        }
    }
    
    
    func presentNewsDetail(_ view: NewsViewProtocol, object: NewsViewModel) {
        guard let news = news?.filter({ $0.title == object.title && $0.description == object.description }).first else {
            return
        }
        newsRouter.presentNewsDetail(from: view, news: news)
    }

}



