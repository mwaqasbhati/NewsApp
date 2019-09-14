//
//  NewsTableViewCell.swift
//  NewsNews
//
//  Created by macadmin on 7/25/19.
//  Copyright © 2019 Muhammad Waqas. All rights reserved.
//

import UIKit
import SDWebImage

class NewsTableViewCell: UITableViewCell {

    // MARK: - Constants
    
    private enum Constants {
        static let placeholder = "placeholder"
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var imageviewThumbnail: UIImageView!
    @IBOutlet weak var labelTitle: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    
    static let cellId = "NewsCell"
    
    // MARK: - Cell Lifecycle

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageviewThumbnail.layer.masksToBounds = true
        imageviewThumbnail.layer.cornerRadius = 10.0
        imageviewThumbnail.contentMode = .scaleAspectFill
    }
    
    // MARK: - Helper Methods

    /**
     Set News to a particlur UITableviewcell.
     
     
     - parameter news: News object which will be assigned to UI.
     
     This methods accepts news data object which will be assigner to UI elements e.g title, description.
     */
    
    func setNews(_ news: NewsViewModel) {
        labelTitle.text = news.title
        labelDescription.text = news.description
        if let publishAt = news.publishDate {
            labelDate.text = publishAt.getPresentable()
        }
        if  let media = news.url, let url = URL(string: media) {
            imageviewThumbnail.sd_setImage(with: url, placeholderImage: UIImage(named: Constants.placeholder), options: .transformAnimatedImage, progress: nil, completed: nil)
        }
    }
}
