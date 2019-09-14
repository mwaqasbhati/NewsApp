//
//  Showable.swift
//  Cezan
//
//  Created by Muhammad Waqas on 5/19/19.
//  Copyright © 2019 Muhammad Waqas. All rights reserved.
//

import Foundation
import PKHUD

protocol Showable {
    func showError(_ message: String)
    func showProgress()
    func hideProgress()
}

extension Showable where Self: UIViewController {
    func showError(_ message: String) {
        func showAlertView(_ message: String) {
            let alertView = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            let okAction = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
            alertView.addAction(okAction)
            self.present(alertView, animated: true, completion: nil)
        }
        if Thread.isMainThread {
                showAlertView(message)
        } else {
            DispatchQueue.main.async {
                showAlertView(message)
            }
        }
    }
    func showProgress() {
        if Thread.isMainThread {
            HUD.show(.progress)
        } else {
            DispatchQueue.main.async {
                HUD.show(.progress)
            }
        }
    }
    func hideProgress() {
        if Thread.isMainThread {
            HUD.hide()
        } else {
            DispatchQueue.main.async {
                HUD.hide()
            }
        }
    }
}
