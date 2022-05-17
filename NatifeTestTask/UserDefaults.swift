//
//  UserDefaults.swift
//  NatifeTestTask
//
//  Created by Oleksandr Kachkin on 14.05.2022.
//

import Foundation

class Base {
  
  let defaults = UserDefaults.standard
  
  static let shared = Base()
  
  struct UserAddress: Codable {
    var city: String
    var street: String
    var house: String
    var build: String?
    var flat: String
  }
  
  var addresses: [UserAddress] {
    
    get {
      // Процесс получение старого адреса
      if let data = defaults.value(forKey: "addresses") as? Data {
        return try! PropertyListDecoder().decode([UserAddress].self, from: data)
      } else {
        return [UserAddress]()
      }
    }
    
    set {
      // Процесс сохранения нового адреса
      // Чтобы сохранить массив структур - нужно преобразовать их в дату
      // newValue - значение которое приходит, когда изменяем адреса
      if let data = try? PropertyListEncoder().encode(newValue) {
        defaults.set(data, forKey: "addresses")
      }
    }
  }
  
  func saveAddress(city: String, street: String, house: String, build: String?, flat: String) {
    
    let address = UserAddress(city: city, street: street, house: house, build: build, flat: flat)
    addresses.insert(address, at: 0)
  }
}
