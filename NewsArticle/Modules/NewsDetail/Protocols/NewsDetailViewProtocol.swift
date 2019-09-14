//
//  NewsDetailProtocols.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//

import UIKit


protocol NewsDetailViewProtocol: class {
    var presenter: NewsDetailPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW        
}

protocol NewsDetailRouterProtocol: class {
    // PRESENTER -> WIREFRAME
}

protocol NewsDetailPresenterProtocol: class {
    var view: NewsDetailViewProtocol? { get set }
    var interactor: NewsDetailInteractorInputProtocol? { get set }
    var wireFrame: NewsDetailRouterProtocol? { get set }
    var news: News {get set}
    // VIEW -> PRESENTER
}

protocol NewsDetailInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
}

protocol NewsDetailInteractorInputProtocol: class {
    var presenter: NewsDetailInteractorOutputProtocol? { get set }
    var dataManager: NewsDetailDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
}

protocol NewsDetailDataManagerInputProtocol: class {
    var remoteRequestHandler: NewsDetailDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> DATAMANAGER
}

protocol NewsDetailDataManagerOutputProtocol: class {
    // DATAMANAGER -> INTERACTOR
}

