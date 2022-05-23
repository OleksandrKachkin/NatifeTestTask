//
//  Extensions.swift
//  NatifeTestTask
//
//  Created by Oleksandr Kachkin on 21.05.2022.
//

import Foundation

extension Date {
  
  func toString(withFormat format: String = "dd MMMM yyyy") -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone.current
    dateFormatter.locale = Locale(identifier: "en")
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: self)
  }
  
  // Returns the amount of days from another date
  func days(from date: Date) -> Int {
    return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
  }
    
  
  // Разница между 2-мя датами
  static func - (lhs: Date, rhs: Date) -> TimeInterval {
    return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
  }
  
  
}


