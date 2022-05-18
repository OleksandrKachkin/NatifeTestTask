//
//  PostManager.swift
//  NatifeTestTask
//
//  Created by Oleksandr Kachkin on 16.05.2022.
//

import Foundation

class PostManager {
  // Singelton
  static let shared = PostManager()
  
  struct Constant {
    static let newsURL = URL(string: "https://raw.githubusercontent.com/anton-natife/jsons/master/api/main.json")
  }
  
  private init() {}
  
  
  
//  let postURL = "https://raw.githubusercontent.com/anton-natife/jsons/master/api/main.json"
  
//  var delegate: PostManagerDelegate?
  
//  func fetchPost(postID: Int) {
//    let urlString = "https://raw.githubusercontent.com/anton-natife/jsons/master/api/main.json"
//    performRequest(with: urlString)
//  }
  
  public func getNews(completion: @escaping (Result<[Post], Error>) -> Void) {
    guard let url = Constant.newsURL else { return }
    
    let task = URLSession.shared.dataTask(with: url) { data, _, error  in
      if let error = error {
        completion(.failure(error))
      }
      else if let safeData = data {
        do {
          let result = try JSONDecoder().decode(APIResponse.self, from: safeData)
          print("Articles: \(result.posts.count)")
          completion(.success(result.posts))
        }
        catch {
          completion(.failure(error))
        }
      }
    }
    task.resume()
  }
}
