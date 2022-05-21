//
//  PostData.swift
//  NatifeTestTask
//
//  Created by Oleksandr Kachkin on 16.05.2022.
//

import Foundation

struct APIResponse: Codable {
  let posts: [Post]
}

struct Post: Codable {
  let postId: Int
  let timestamp: Date
  let title: String
  let previewText: String
  let likesCount: Int
  
  enum CodingKeys: String, CodingKey {
    case postId
    case timestamp = "timeshamp"
    case title
    case previewText = "preview_text"
    case likesCount = "likes_count"
  }
}


