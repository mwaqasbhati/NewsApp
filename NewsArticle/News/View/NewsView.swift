//
//  NewsView.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//

import UIKit
import PKHUD
import Dropdowns

class NewsView: UIViewController, NewsViewProtocol {
    
    // MARK: - Constants

    private enum Constants {
        static let bbcNewsId = "bbc-news"
        static let bbcNews = "BBC News"
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
        
        fetchNews()
        fetchSources()

        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(NewsView.refresh), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl
        
        // Configure Table View
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
    }
    
    /**
     It fetches news categories from Network API.
     
     
     This method fetches all news categories like entertainment, music etc.
     */
    
    private func fetchSources() {
        sourcePresenter?.didSourceSuccess({ sourcesVM in
            DispatchQueue.main.async { [weak self] in
                guard let `self` = self else { return }
                self.sourceViewModel = sourcesVM
                self.sourcePresenter?.presentSources(self, sources: self.sourceViewModel)
            }
        })
        sourcePresenter?.didSourceError = { [weak self] (error) in
            self?.hideProgress()
            self?.showError(error.localizedDescription)
        }
        sourcePresenter?.didSelectSource = { [weak self] (index) in
            guard let `self` = self else { return }
            self.selectedSection = self.sourceViewModel[index].id ?? Constants.bbcNewsId
            self.resetFiltersAndLoad()
        }
    }
    
    /**
     It fetches news data from Network API..
     
     
     This method fetches news based on section, time and offset.
     */
    
    private func fetchNews() {
        self.presenter?.didFetchNews(self.selectedSection, completion: { [weak self] (newsVM, error) in
            guard let `self` = self else { return }
            self.newsViewModel = newsVM ?? [NewsViewModel]()
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        
    }
    
    /**
     It reset all news data filters and fetches all sections from Network API.
     
     
     This method refreshed news data.
     */
    
    @objc func refresh(sender:AnyObject) {
         resetFiltersAndLoad()
    }
    
    /**
     It reset news offset to 0 and fetches news.
     
    */
    
    private func resetFiltersAndLoad() {
        newsViewModel.removeAll()
        fetchNews()
    }
    
    // MARK: - IBActions
    
}

// MARK: - NewsViewProtocol

extension NewsView {
    
    func presentNews(_ news: [NewsViewModel]) {
        newsViewModel = news
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
        }
    }
    
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

