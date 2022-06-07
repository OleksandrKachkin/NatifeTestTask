//
//  PostManager.swift
//  NatifeTestTask
//
//  Created by Oleksandr Kachkin on 16.05.2022.
//

import Foundation

class PostManager {
  
  // MARK: - Properties
  
  private let urlBase = "https://raw.githubusercontent.com/anton-natife/jsons/master/api/"
  // https://raw.githubusercontent.com/anton-natife/jsons/master/api/main.json
  // https://raw.githubusercontent.com/anton-natife/jsons/master/api/posts/111.json
  
  static let shared = PostManager()
  
  // MARK: - Inits
  
  private init() {}
  
  // MARK: - Helper Methods
  
  // Метод для загрузки ленты постов
  public func getNews(completion: @escaping (Result<[Post], Error>) -> Void) {
    
    guard let url = URL(string: "\(urlBase)main.json") else { return }
    
    let task = URLSession.shared.dataTask(with: url) { data, _, error  in
      if let error = error {
        completion(.failure(error))
      }
      else if let safeData = data {
        do {
          let result = try JSONDecoder().decode(APIResponse.self, from: safeData)
          print("Number of posts: \(result.posts.count)")
          completion(.success(result.posts))
        }
        catch {
          completion(.failure(error))
        }
      }
    }
    task.resume()
  }
  
  // Метод для загрузки конкретного поста по его ID
  public func getPost(id: Int, completion: @escaping (Result<PostID, Error>) -> Void) {
    guard let url = URL(string: "\(urlBase)posts/\(id).json") else { return }
    
    let task = URLSession.shared.dataTask(with: url) { data, _, error  in
      if let error = error {
        completion(.failure(error))
      }
      else if let safeData = data {
        do {
          let result = try JSONDecoder().decode(PostModel.self, from: safeData)
          print("PostID: \(result.post.postId)")
          completion(.success(result.post))
        }
        catch {
          completion(.failure(error))
        }
      }
    }
    task.resume()
  }
}

