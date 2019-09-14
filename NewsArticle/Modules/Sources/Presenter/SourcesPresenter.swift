//
//  SourcesPresenter.swift
//  NewsArticle
//
//  Created by Muhammad Waqas on 9/13/19.
//  Copyright © 2019 Muhammad Waqas. All rights reserved.
//

import Foundation
import Dropdowns

class SourcesPresenter: SourcesPresenterProtocol {
    
    var sourcesInteractor: SourcesInteractorProtocol
    var sourcesRouter: SourcesRouterProtocol
    var didSelectSource: ((_ index: Int)->())?
    var didSourceError: ((_ error: String)->())?

    private var sections = [String]()
    private let defaultId = "bbc-news"
    private let bbcNews = "BBC News"

    init(_ interactor: SourcesInteractorProtocol, router: SourcesRouterProtocol) {
        sourcesInteractor = interactor
        sourcesRouter = router
    }
    
    /**
     Get sources from interactor
     
     - completion: it will return sources or error fetched from entity gateway
     
     This method will convert entity to View Model and handle error
     
     */
    
    func didSourceSuccess(_ completion: @escaping ([SourceViewModel]) -> ()) {
        sourcesInteractor.onFetchSources { [weak self] (sources, error) in
            guard let `self` = self else { return }
            if error == nil {
                let sourcesVM = sources?.map({ (source) -> SourceViewModel in
                    return SourceViewModel(id: source.id, name: source.name)
                })
                completion(sourcesVM ?? [SourceViewModel]())
            } else {
                self.didSourceError?(error?.localizedDescription ?? APIError.unknown.localizedDescription)
            }
            
        }
    }
    
    /**
     Present Sources View
     
     - view: view on which we will present sources popup
     - sources: it will give sources as datasource
     
     
     */
    
    func presentSources(_ view: UIViewController, sources: [SourceViewModel]) {
        sections = sources.map({ $0.name ?? "" })
        guard let navC = view.navigationController else { return }
        if let titleView = TitleView(navigationController: navC, title: bbcNews, items: self.sections, initialIndex: sources.firstIndex(where: { $0.id == defaultId }) ?? 0) {
            view.navigationItem.titleView = titleView
            titleView.action = { [weak self] index in
                guard let `self` = self else { return }
                self.didSelectSource?(index)
            }
        }
        
    }
}
