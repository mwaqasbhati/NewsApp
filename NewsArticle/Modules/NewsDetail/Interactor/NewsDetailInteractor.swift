//
//  NewsDetailInteractor.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//


class NewsDetailInteractor: NewsDetailInteractorInputProtocol {
    weak var presenter: NewsDetailInteractorOutputProtocol?
    var dataManager: NewsDetailDataManagerInputProtocol?
}

extension NewsDetailInteractor: NewsDetailDataManagerOutputProtocol {
    
}
