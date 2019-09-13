//
//  NewsDetailRouter.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//

import UIKit


class NewsDetailRouter {
    
    /**
     Setup News detail Module.
     
     - parameter news: accepts news object.

     This method creates news detail view all business elements like presenter, interactor, wireframe etc and return it if it is successfully initialized.
     */
    
    static func createNewsDetailModule(_ news: News) -> UIViewController? {
        if let newsDetail = Storyboard.NewsDetail.controller as? NewsDetailView {
        let presenter = NewsDetailPresenter(news)
        let interactor = NewsDetailInteractor()
        let wireFrame = NewsDetailRouter()
        let dataManager = NewsDetailDataManager()
        
        dataManager.remoteRequestHandler = interactor
        interactor.presenter = presenter
        interactor.dataManager = dataManager
        presenter.interactor = interactor
        presenter.wireFrame = wireFrame
        presenter.view = newsDetail
        newsDetail.presenter = presenter
        return newsDetail
        
        }
        return nil
    }
}

extension NewsDetailRouter: NewsDetailRouterProtocol {}
