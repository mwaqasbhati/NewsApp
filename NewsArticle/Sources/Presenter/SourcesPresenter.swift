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
    var didSourceError: ((_ error: Error)->())?

    private var sections = [String]()
    private let defaultId = "bbc-news"

    init(_ interactor: SourcesInteractorProtocol, router: SourcesRouterProtocol) {
        sourcesInteractor = interactor
        sourcesRouter = router
    }
    func didSourceSuccess(_ completion: @escaping ([SourceViewModel]) -> ()) {
        sourcesInteractor.onFetchSources { (sources, error) in
            if error == nil {
                let sourcesVM = sources?.map({ (source) -> SourceViewModel in
                    return SourceViewModel(id: source.id, name: source.name)
                })
                completion(sourcesVM ?? [SourceViewModel]())
            } else {
                self.didSourceError?(error ?? APIError.internetError)
            }
            
        }
    }
    
    func presentSources(_ view: UIViewController, sources: [SourceViewModel]) {
        sections = sources.map({ $0.name ?? "" })
        guard let navC = view.navigationController else { return }
        if let titleView = TitleView(navigationController: navC, title: "", items: self.sections, initialIndex: sources.firstIndex(where: { $0.id == defaultId }) ?? 0) {
            view.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleView)
            titleView.action = { [weak self] index in
                guard let `self` = self else { return }
                self.didSelectSource?(index)
            }
        }
        
    }
}
