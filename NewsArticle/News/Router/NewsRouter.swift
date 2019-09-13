//
//  NewsRouter.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//

import UIKit

class NewsRouter: NewsRouterProtocol {
    
    /**
     Setup News List Module.
     
     This method create news list view all elements like presenter, interactor, wireframe etc and return it if it is successfully initialized.
     */
    
    static func createNewsModule() -> NewsViewProtocol? {
        let dispatcher = NetworkDispatcher(configuration: URLSession(configuration: .default))
        let gateway = NewsGateway(dispatcher)
        let interactor = NewsInteractor(gateway)
        let router = NewsRouter()
        let presenter = NewsPresenter(interactor, router: router)
        let view = NewsRouter.create(presenter, sourcePresenter: SourcesRouter.createSourcePresenter())
        return view
    }
    
    private static func create(_ presenter: NewsPresenterProtocol, sourcePresenter: SourcesPresenterProtocol) -> NewsViewProtocol? {
        if let newsView = Storyboard.News.controller as? NewsView {
            newsView.presenter = presenter
            newsView.sourcePresenter = sourcePresenter
            return newsView
        }
        return nil
    }
    /**
     Create and present news detail view to current view hierarchy
     
     
     - parameter view: view object on which we want to present detail.
     - parameter news: News object which will be assigned to UI.

     This methods accepts news data object which will be assigner to UI elements e.g title, description.
     */
    
    func presentNewsDetail(from view: NewsViewProtocol, news: News) {
        
        if let view = view as? UIViewController, let controller = NewsDetailRouter.createNewsDetailModule(news) {
            view.navigationController?.pushViewController(controller, animated: true)
        }
    }
}
