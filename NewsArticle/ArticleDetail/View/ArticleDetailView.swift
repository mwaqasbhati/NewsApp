//
//  ArticleDetailView.swift
//  iOS-Viper-Architecture
//
// Created by Muhammad Waqas Bhati//

import UIKit
import PKHUD
import SDWebImage

class ArticleDetailView: UIViewController {
    
    // MARK: - Constants

    enum Constants {
        static let placeHolder = "placeholder"
        static let error = "Error"
        static let close = "Close"
        static let alertMessage = "There was a problem when trying to open"
    }
    
    // MARK: - IBOutlets

    @IBOutlet weak var labelDesc: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var labelAuthor: UILabel!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var imageViewPreview: UIImageView!
    @IBOutlet weak var buttonMoreDetails: UIButton!
    
    // MARK: - Instance Variables

    var presenter: ArticleDetailPresenterProtocol?
    private var article: Articles?
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        if let article = presenter?.article {
            self.article = article
            setData(article)
        }
    }
    
    // MARK: - Helper Methods

    /**
     Set Data will assign article to UI elements.
     
     
     - parameter article: article data object from Network API.
     
     This method accepts article object which will be mapped to particular UI elements
     */
    
    private func setData(_ article: Articles) {
        labelTitle.text = article.title
        labelAuthor.text = article.author
        labelDesc.text = article.description
        
        if let date = article.publishedAt {
            labelDate.text = "🗓 \(date)"
        }
        if  let media = article.urlToImage, let url = URL(string: media) {
            SDWebImageManager.shared.imageLoader.requestImage(with: url, options: .continueInBackground, context: nil, progress: nil, completed: { [weak self] (image:UIImage?, data:Data?, error:Error?, finished:Bool) in
                
                guard let weakSelf = self else { return }
                if image != nil {
                    weakSelf.imageViewPreview.image = image
                    weakSelf.imageViewPreview.contentMode = .scaleAspectFill
                } else {
                    weakSelf.imageViewPreview.image = UIImage(named: Constants.placeHolder)
                }
            })
        }
    }
    
    
    @IBAction func moreDetailButtonPressed(_ sender: Any) {
        
        if let urlStr = article?.url, let url = URL(string: urlStr) {
            
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                let alert = UIAlertController(title: Constants.error, message: "\(Constants.alertMessage) \(url)", preferredStyle: UIAlertController.Style.alert)
                
                alert.addAction(UIAlertAction(title: Constants.close, style: UIAlertAction.Style.cancel, handler: nil))
                
                present(alert, animated: true, completion: nil)
            }
        }
        
    }
    
}

// MARK: - Presenter to View

extension ArticleDetailView: ArticleDetailViewProtocol { }

