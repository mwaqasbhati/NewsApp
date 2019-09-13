//
//  SourceRouter.swift
//  NewsArticle
//
//  Created by Muhammad Waqas on 9/14/19.
//  Copyright © 2019 Muhammad Waqas. All rights reserved.
//

import Foundation


class SourcesRouter: SourcesRouterProtocol {
    
    static func createSourcePresenter() -> SourcesPresenterProtocol {
        let dispatcher = NetworkDispatcher(configuration: URLSession(configuration: .default))
        let gateway = SourcesEntityGateway(dispatcher)
        let interactor = SourcesInteractor(gateway)
        let router = SourcesRouter()
        let presenter = SourcesPresenter(interactor, router: router)
        return presenter
    }
    
}
