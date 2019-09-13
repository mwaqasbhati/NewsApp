//
//  SourcesInteractorProtocol.swift
//  NewsArticle
//
//  Created by Muhammad Waqas on 9/13/19.
//  Copyright © 2019 Muhammad Waqas. All rights reserved.
//

import Foundation
import UIKit

// Presenter Protocol

protocol SourcesPresenterProtocol {
    var sourcesInteractor: SourcesInteractorProtocol {get set}
    var didSelectSource: ((_ index: Int)->())? {get set}
    var didSourceError: ((_ error: Error)->())? {get set}
    
    func didSourceSuccess(_ completion: @escaping ([SourceViewModel])->())
    func presentSources(_ view: UIViewController, sources: [SourceViewModel])
}

// Interactor Protocol

protocol SourcesInteractorProtocol {
    var sourcesGateway: SourcesEntityGatewayProtocol {get set}
    
    func onFetchSources(_ completion: @escaping ([Sources]?, Error?)->())
}

// Entity Gateway Protocol

protocol SourcesEntityGatewayProtocol {
    func fetchSources(_ request: APIRequest, completion: @escaping ([Sources]?, Error?)->())
}

// Router Protocol

protocol SourcesRouterProtocol {
    static func createSourcePresenter() -> SourcesPresenterProtocol
}
