//
//  PostManager.swift
//  NatifeTestTask
//
//  Created by Oleksandr Kachkin on 16.05.2022.
//

import Foundation

//protocol PostManagerDelegate {
//  // Метод обновляет интерфейс
//  func didUpdatePost(_ postManager: PostManager, post: PostModel)
//  // Метод обрабатывает ошибки
//  func didFailWithError(error: Error)
//}

class PostManager {
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
//        print(error)
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
//  
//  func performRequest(with urlString: String) {
//    
//    if let url = URL(string: urlString) {
//      let session = URLSession(configuration: .default)
//      
//      let task = session.dataTask(with: url) { (data, response, error) in
//        if error != nil {
//          print(error!)
//          return
//        }
//        
//        if let safeData = data {
//          do {
//            let result = try JSONDecoder().decode(PostData.self, from: safeData)
//            print("Articles: \(result.posts.count)")
//          }
//          
////          if let post = self.parseJSON(safeData) {
////            self.delegate?.didUpdatePost(self, post: post)
////          }
//        }
//      }
//      
//      task.resume()
//      print(url)
//    }
//  }
//  
//  
//  func parseJSON(_ postData: Data) -> PostModel? {
//    
//    let decoder = JSONDecoder()
//    
//    do {
//      let decodedData = try decoder.decode(PostData.self, from: postData)
//      print(decodedData.posts[0].title)
//      let id = decodedData.posts[0].postID
//      let title = decodedData.posts[id].title
//      let previewText = decodedData.posts[id].previewText
//      let likes = decodedData.posts[id].likesCount
//      let time = decodedData.posts[id].timeshamp
//      let post = PostModel(title: title, subtitle: subtitle, likes: likes, time: time)
//      return post
//      
//    } catch {
//      delegate?.didFailWithError(error: error)
//      print(error)
//      return nil
//    }
//  }
//  
//}


// Models
//
//struct APIResponse: Codable {
//  let posts: [Post]
//}
//
//struct Post: Codable {
//  let postID: Int
//  let timeshamp: Int
//  let title: String
//  let previewText: String
//  let likesCount: Int
//  
//  enum CodingKeys: String, CodingKey {
//    case postID = "postId"
//    case timeshamp
//    case title
//    case previewText = "preview_text"
//    case likesCount = "likes_count"
//  }
//}
