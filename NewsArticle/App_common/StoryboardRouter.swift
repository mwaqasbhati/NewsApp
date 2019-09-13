//
//  StoryboardRouter.swift
//  NewsNews
//
//  Created by Muhammad Waqas on 7/26/19.
//  Copyright © 2019 Muhammad Waqas. All rights reserved.
//

import UIKit

protocol StoryboardRouter {
    var name: String {get}
    var controller: UIViewController? {get}
}

enum Storyboard: StoryboardRouter {
    case News
    case NewsDetail
    
    var name: String {
        switch self {
        case .News:
            return "Main"
        case . NewsDetail:
            return "Main"
        }
    }
    
    var controller: UIViewController? {
        switch self {
        case .News:
            return UIStoryboard(name: name, bundle: nil).instantiateViewController(withIdentifier: "NewsView")
        case . NewsDetail:
            return UIStoryboard(name: name, bundle: nil).instantiateViewController(withIdentifier: "NewsDetailView")
        }
    }
    
    
}
