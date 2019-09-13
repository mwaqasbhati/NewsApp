//
//  ArticleListView.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//

import UIKit
import PKHUD
import Dropdowns

class ArticleListView: UIViewController {
    
    // MARK: - Constants

    private enum Constants {
        static let allSections = "all-sections"
        static let cancel = "Cancel"
        static let popularItemsTitle = "See most popular items for"
        static let all = "All"
        static let bbcNewsId = "bbc-news"
        static let bbcNews = "BBC News"
    }
    // MARK: - IBOutlets
    
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Instance Variables
    
    private let refreshControl = UIRefreshControl()
    private var articles = [Articles]()
    private var sources = [Sources]()
    private var sections = [String]()
    private var selectedSection = Constants.bbcNewsId
    private var defaultTimePeriod = TimePeriod.Week
    var presenter: ArticleListPresenterProtocol?
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchArticles()
        fetchArticleSections()
        setup()
    }
    
    // MARK: - Helper Methods
    
    /**
     setup will initialize basic UI elements.
     
     This method initializes basic UI elements
     */
    
    private func setup() {
        
        // Configure Refresh Control
        refreshControl.addTarget(self, action: #selector(ArticleListView.refresh), for: UIControl.Event.valueChanged)
        tableView.refreshControl = refreshControl
        
        // Configure Table View
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
    }
    
    /**
     It fetches article categories from Network API.
     
     
     This method fetches all article categories like entertainment, music etc.
     */
    
    private func fetchArticleSections() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let `self` = self else { return }
            self.presenter?.viewSources()
        }
    }
    
    /**
     It fetches article data from Network API..
     
     
     This method fetches article based on section, time and offset.
     */
    
    private func fetchArticles() {
        DispatchQueue.global(qos: .background).async { [weak self] in
            guard let `self` = self else { return }
            self.presenter?.viewNews(self.selectedSection)
        }
    }
    
    /**
     It reset all article data filters and fetches all sections from Network API.
     
     
     This method refreshed article data.
     */
    
    @objc func refresh(sender:AnyObject) {
         resetFiltersAndLoad()
    }
    
    /**
     It reset article offset to 0 and fetches articles.
     
    */
    
    private func resetFiltersAndLoad() {
        articles.removeAll()
        presenter?.viewNews(selectedSection)
    }
    private func showTimePeriodFilters() {
        let alert = UIAlertController(title: Constants.popularItemsTitle, message: nil, preferredStyle: .actionSheet)
        for timePeriod in TimePeriod.names {
            let timePeriodAction = UIAlertAction(title: getDisplayNameForTimePeriod(timePeriod: timePeriod),
                                                 style: .default, handler: { action in
                                                    self.defaultTimePeriod = timePeriod
                                                    self.fetchArticles()
            })
            alert.addAction(timePeriodAction)
        }
        let cancelAction = UIAlertAction(title: Constants.cancel,
                                         style: .cancel, handler: nil)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
    }
    
    private func getDisplayNameForTimePeriod(timePeriod: TimePeriod) -> String {
        var displayName = timePeriod.name
        if defaultTimePeriod == timePeriod {
            displayName = "✓ " + displayName
        }
        return displayName
    }
    // MARK: - IBActions
    
    @IBAction func rightButtonPressed(_ sender: Any) {
        showTimePeriodFilters()
    }
}

// MARK: - ArticleListViewProtocol

extension ArticleListView: ArticleListViewProtocol {
    
    func presentSources(_ sources: [Sources]) {
        self.sources = sources
        sections.removeAll()
        sections.append(contentsOf: sources.map({ $0.name ?? "" }))
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self, let navC = self.navigationController else { return }
            if let titleView = TitleView(navigationController: navC, title: Constants.bbcNews, items: self.sections, initialIndex: self.sources.firstIndex(where: { $0.id == Constants.bbcNewsId }) ?? 0) {
                self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: titleView)
                titleView.action = { [weak self] index in
                    guard let `self` = self else { return }
                    self.selectedSection = self.sources[index].id ?? Constants.bbcNewsId
                    self.resetFiltersAndLoad()
                }
            }
        }
    }
    
    func presentNews(_ articles: [Articles]) {
        self.articles = articles
        DispatchQueue.main.async { [weak self] in
            guard let `self` = self else { return }
            self.refreshControl.endRefreshing()
            self.tableView.reloadData()
           // self.tableView.scrollToRow(at: IndexPath(row: self.currentOffset, section: 0), at: .bottom, animated: false)
        }
    }
    
    func showError(_ message: String) {
        DispatchQueue.main.async {
            HUD.flash(.label(message), delay: 2.0)
        }
    }
    
    func showLoading() {
        DispatchQueue.main.async {
            HUD.show(.progress)
        }
    }
    
    func hideLoading() {
        DispatchQueue.main.async {
            HUD.hide()
        }
    }
    
}

// MARK: - UITableView DataSource & Delegate
extension ArticleListView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return articles.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ArticleListTableViewCell.cellId) as? ArticleListTableViewCell else {
            return UITableViewCell()
        }
        let article = articles[indexPath.row]
        cell.setArticle(article)
        
        return cell
    }
}

extension ArticleListView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let article = articles[indexPath.row]
        presenter?.moveToDetailView(article)
    }
    
}

// MARK: - Search Bar Delegate
extension ArticleListView: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        tableView.tableHeaderView = nil
        tableView.reloadData()
    }
}
