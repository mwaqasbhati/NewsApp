//
//  NewsView.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//

import UIKit

class NewsView: UIViewController, NewsViewProtocol {
    
    // MARK: - Constants

    private enum Constants {
        static let bbcNewsId = "bbc-news"
    }
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Instance Variables
    
    private let refreshControl = UIRefreshControl()
    private var newsViewModel = [NewsViewModel]()
    private var sourceViewModel = [SourceViewModel]()
    var presenter: NewsPresenterProtocol?
    var sourcePresenter: SourcesPresenterProtocol?
    private var selectedSection = Constants.bbcNewsId
    private let group = DispatchGroup()
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Helper Methods
    
    /**
     setup will initialize basic UI elements.
     
     This method initializes basic UI elements
     */
    
    private func setup() {
        
        showProgress()
        
        fetchNews()
        fetchSources()
        
        group.notify(queue: DispatchQueue.main) {
            self.hideProgress()
        }
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(NewsView.refresh), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl
        
        // Configure Table View
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
    }
    
    /**
     It fetches news categories from Network API.
     
     
     This method fetches all news Sources like BBC, CNN etc.
     */
    
    private func fetchSources() {
        group.enter()
        sourcePresenter?.didSourceError = { [weak self] (error) in
            self?.group.leave()
            DispatchQueue.main.async {
                self?.showError(error)
            }
        }
        sourcePresenter?.didSourceSuccess({ [weak self] sourcesVM in
            guard let `self` = self else { return }
            self.sourceViewModel = sourcesVM
            self.group.leave()
            DispatchQueue.main.async {
                self.sourcePresenter?.presentSources(self, sources: self.sourceViewModel)
            }
        })
        sourcePresenter?.didSelectSource = { [weak self] (index) in
            guard let `self` = self else { return }
            self.selectedSection = self.sourceViewModel[index].id ?? Constants.bbcNewsId
            self.updateNews()
        }
    }
    
    /**
     It fetches news data from Network API..
     
     
     This method fetches news based on news source.
     */
    
    private func fetchNews() {
        group.enter()
        presenter?.didNewsError = { [weak self] error in
            guard let `self` = self else { return }
            self.group.leave()
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.showError(error)
            }
        }
        presenter?.didFetchNews(self.selectedSection, completion: { [weak self] newsVM in
            guard let `self` = self else { return }
            self.newsViewModel = newsVM
            self.group.leave()
            DispatchQueue.main.async {
                self.refreshControl.endRefreshing()
                self.tableView.reloadData()
            }
        })
        
    }
    
    /**
     
     This method refreshed news data.
     */
    
    @objc func refresh(sender:AnyObject) {
         updateNews()
    }
    
    /**
     It updated news and fetch latest news from Network.
     
    */
    
    private func updateNews() {
        newsViewModel.removeAll()
        fetchNews()
    }
    
    // MARK: - IBActions
    
    
    
}

// MARK: - UITableView DataSource & Delegate

extension NewsView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsViewModel.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.cellId) as? NewsTableViewCell else {
            return UITableViewCell()
        }
        cell.setNews(newsViewModel[indexPath.row])
        return cell
    }
}

extension NewsView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.presentNewsDetail(self, object: newsViewModel[indexPath.row])
    }
    
}

