//
//  Extensions.swift
//  NatifeTestTask
//
//  Created by Oleksandr Kachkin on 21.05.2022.
//

import Foundation

extension Date {
    
    func toString(withFormat format: String = "MM/dd/yyyy") -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale(identifier: "en")
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
    
}
