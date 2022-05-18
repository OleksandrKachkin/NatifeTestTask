//
//  MainViewController.swift
//  NatifeTestTask
//
//  Created by Oleksandr Kachkin on 13.05.2022.
//

import UIKit

class MainViewController: UIViewController {
  
  private let tableView: UITableView = {
    let table = UITableView()
    table.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
    return table
  }()
  
  private var news = [Post]()
  private var postModels = [CellModel]()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "News"
//    navigationController?.navigationBar.prefersLargeTitles = true
    view.addSubview(tableView)
    tableView.delegate = self
    tableView.dataSource = self
    view.backgroundColor = .systemBackground
    
    // Mark - вопрос 1 - куда лучше размещать запрос данных
    PostManager.shared.getNews { [weak self] result in
      switch result {
      case .success(let posts):
        self?.news = posts
        self?.postModels = posts.compactMap({
          CellModel(title: $0.title, previewText: $0.previewText)
        })
        //        self?.postModels = posts.compactMap({
        //          PostModel(title: $0.title, previewText: $0.previewText,
        //          CellModel(title: <#T##String#>, previewText: <#T##String#>, likes: <#T##Int#>, time: <#T##Int#>)
        //        })
        
        DispatchQueue.main.async {
          self?.tableView.reloadData()
        }
      case .failure(let error):
        print(error)
      }
    }
  }
  
  
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    tableView.frame = view.bounds
//    tableView.frame = CGRect.init(origin: .zero, size: CGSize(width: 200, height: 200))
  }
}

// MARK: - UITableViewDelegate, UITableViewDataSource

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return postModels.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
    guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier, for: indexPath) as? NewsTableViewCell else { fatalError() }
    cell.configure(with: postModels[indexPath.row])
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 220
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    // открыть новый ВК
    // let vc =
  }
}

