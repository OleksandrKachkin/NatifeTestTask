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
  let postID: Int
  let timeshamp: Int
  let title: String
  let likesCount: Int
  let previewText: String
  
  enum CodingKeys: String, CodingKey {
    case postID = "postId"
    case timeshamp
    case title
    case previewText = "preview_text"
    case likesCount = "likes_count"
  }
}


