//
//  MainViewController.swift
//  NatifeTestTask
//
//  Created by Oleksandr Kachkin on 13.05.2022.
//

import UIKit

class MainViewController: UITableViewController {
  
  private var news = [Post]()
  private var postModels = [PostModel]()
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "News"
    tableView.delegate = self
    tableView.dataSource = self
    view.backgroundColor = .systemBackground
    
    // Mark - вопрос 1 - куда лучше размещать запрос данныхБ
    PostManager.shared.getNews { [weak self] result in
      switch result {
      case .success(let posts):
        self?.news = posts
        self?.postModels = posts.compactMap({
//          PostModel(title: $0.title, previewText: $0.previewText,
          PostModel(title: <#T##String#>, previewText: <#T##String#>, likes: <#T##Int#>, time: <#T##Int#>)
        })
        
        DispatchQueue.main.async {
          self?.tableView.reloadData()
        }
      case .failure(let error): print(error)
      }
    }
  }

  
  // MARK: - UITableViewDelegate, UITableViewDataSource
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModels.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.reuseId,for: indexPath) as? NewsTableViewCell else { fatalError() }
    cell.configure(with: viewModels[indexPath.row])
    
    return cell
  }
  
  
}

