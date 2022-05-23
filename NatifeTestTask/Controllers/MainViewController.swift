//
//  MainViewController.swift
//  NatifeTestTask
//
//  Created by Oleksandr Kachkin on 13.05.2022.
//

import UIKit
import SwiftUI

class MainViewController: UIViewController {
  
  //MARK: - Properties
  private var news = [Post]()
  private var postModels = [CellModel]()
  private var ascendingSorting = true
  private var expandedIndexSet : IndexSet = []
//  var buttonTitle = ["Expand", "Collapse"]
  
  //MARK: - Views
  
  private let segmentedControl: UISegmentedControl = {
    let sc = UISegmentedControl(items: ["Likes", "Date"])
    sc.selectedSegmentIndex = 0
    sc.selectedSegmentTintColor = .systemGray
    return sc
  }()
  
  private let tableView: UITableView = {
    let table = UITableView(frame: .zero, style: .plain)
    table.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
    return table
  }()
  
  lazy var stackView: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [segmentedControl, tableView])
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.spacing = 4
    stack.axis = .vertical
    return stack
  }()
  
  lazy var rightButton: UIButton = {
    let rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    rightButton.setBackgroundImage(UIImage(named: "AZ"), for: .normal)
    rightButton.addTarget(self, action: #selector(sortButtonAction), for: .touchUpInside)

    return rightButton
  }()
  
  // Actions
  @objc func sortButtonAction() {
    if segmentedControl.selectedSegmentIndex == 0 {
      postModels = postModels.sorted(by: { $0.likes < $1.likes})
    } else {
      postModels = postModels.sorted(by: { $0.date < $1.date})
    }
    tableView.reloadData()
  }
  
  func setupSortingButton(){
    let rightButton = rightButton
    rightButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
    rightButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    let rightButtonItem = UIBarButtonItem(customView: rightButton)
    navigationItem.rightBarButtonItem = rightButtonItem
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "News"
    
    tableView.delegate = self
    tableView.dataSource = self
    view.backgroundColor = .systemBackground
    
    setupSortingButton()
    setupConstraints()
    
    
    PostManager.shared.getNews { [weak self] result in
      switch result {
      case .success(let posts):
        self?.news = posts
        self?.postModels = posts.compactMap({
          CellModel(title: $0.title, previewText: $0.previewText, likes: $0.likesCount, date: $0.timestamp)
        })
        
        DispatchQueue.main.async {
          self?.tableView.reloadData()
        }
      case .failure(let error):
        print(error)
      }
    }
  }
  
  func setupConstraints(){
    
    view.addSubview(stackView)
    
    stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
    stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
    stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()

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
        
    cell.buttonTapBlock = { [weak self] in
      guard let self = self else { return }
      print("Button tapped")
    }
    
    // Expand and Collapse cell
    if expandedIndexSet.contains(indexPath.row) {
      cell.previewLabel.numberOfLines = 0
    } else {
      cell.previewLabel.numberOfLines = 2
    }
    
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    // Добавление/удаление в сет развернутых ячеек
//    if(expandedIndexSet.contains(indexPath.row)){
//      expandedIndexSet.remove(indexPath.row)
//    } else {
//      expandedIndexSet.insert(indexPath.row)
//    }
//    tableView.reloadRows(at: [indexPath], with: .automatic)
    
    // Passing data to DetailViewController
    let detailVC = DetailViewController()
    detailVC.newsTitle = postModels[indexPath.row].title
    detailVC.newsText = postModels[indexPath.row].previewText
    detailVC.likes = String(postModels[indexPath.row].likes)
    
    
    var dateString: String {
      let date = postModels[indexPath.row].date
      let input: Date = Date(timeIntervalSince1970: date)
    
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "dd MMMM YYYY"
      dateFormatter.locale = Locale(identifier: "en")
      return dateFormatter.string(from: input)
    }
    
    detailVC.date = dateString
    
    
    navigationController?.pushViewController(detailVC, animated: true)
  }
}

