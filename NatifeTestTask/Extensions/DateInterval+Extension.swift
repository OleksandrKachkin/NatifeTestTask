//
//  DateInterval + Extension.swift
//  NatifeTestTask
//
//  Created by Oleksandr Kachkin on 07.06.2022.
//

import Foundation

extension TimeInterval {
  
  func toString() -> String {
    let input: Date = Date(timeIntervalSince1970: self)
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "dd MMMM YYYY"
    dateFormatter.locale = Locale(identifier: "en")
    
    return dateFormatter.string(from: input)
  }
}
