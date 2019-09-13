//
//  Date+Formatter.swift
//  NewsNews
//
//  Created by Muhammad Waqas on 9/12/19.
//  Copyright © 2019 Muhammad Waqas. All rights reserved.
//

import Foundation

extension String {
    func getDate() -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current
        return dateFormatter.date(from: self)
    }
}

extension Date {
    
    func getPresentable() -> String {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day, .hour], from: self, to: Date())
        return components.hour ?? 0 < 24 ? "\(components.hour ?? 1)h" : "\(components.day ?? 0)d"
    }
    
}
