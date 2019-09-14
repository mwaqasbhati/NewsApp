//
//  UIViewCotroller+extensions.swift
//  NewsArticle
//
//  Created by Muhammad Waqas on 9/14/19.
//  Copyright © 2019 Muhammad Waqas. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController: Showable { }

extension UIViewController {
    
    func presentAlert(withTitle title: String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default,handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
