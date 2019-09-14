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
    var didNewsError: ((String) -> ())?

    init(_ interactor: NewsInteractorProtocol, router: NewsRouterProtocol) {
        newsInteractor = interactor
        newsRouter = router
    }
    
    /**
     Get sources from interactor
     
     - source: source Identifier
     - completion: it will be called when we will get news data
     
     This method will convert entity to View Model and handle error
     
     */
    
    func didFetchNews(_ source: String, completion: @escaping ([NewsViewModel])->()) {
        newsInteractor.onFetchNews(source) { [weak self] (news, error) in
            guard let weakSelf = self else { return }
            if let error = error {
                weakSelf.didNewsError?(error.localizedDescription)
            } else {
                let newsVM = news?.map{ (object) -> NewsViewModel in
                    return NewsViewModel(title: object.title, description: object.description, url: object.urlToImage, publishDate: object.publishedAt?.getDate())
                }
                weakSelf.news = news
                completion(newsVM ?? [NewsViewModel]())
            }
        }
    }
    
    /**
     Present News Detail
     
     - view: it will return sources or error fetched from entity gateway
     - object: it is view Model which will be presented for news detail
     
     This method converts view model to entity and call news detail presenter
     
     */
    
    func presentNewsDetail(_ view: NewsViewProtocol, object: NewsViewModel) {
        guard let news = news?.filter({ $0.title == object.title && $0.description == object.description }).first else {
            return
        }
        newsRouter.presentNewsDetail(from: view, news: news)
    }

}



