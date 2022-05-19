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
  
  //MARK: - Views
  private let segmentedControl: UISegmentedControl = {
    let sc = UISegmentedControl(items: ["Date", "Likes"])
    sc.selectedSegmentIndex = 0
    sc.selectedSegmentTintColor = .systemGray
    sc.addTarget(self, action: #selector(segmentedControlAction(_:)), for: .touchUpInside)
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
    //    stack.alignment = .fill
    //    stack.distribution = .fill
    return stack
  }()
  
  
  
  lazy var rightButton: UIButton = {
    let rightButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
    rightButton.setBackgroundImage(UIImage(named: "AZ"), for: .normal)
    rightButton.addTarget(self, action: #selector(sortButtonAction), for: .touchUpInside)

    return rightButton
  }()
  
  func setupSortingButton(){
    let rightButton = rightButton
    
    rightButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
    rightButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    let rightButtonItem = UIBarButtonItem(customView: rightButton)
    navigationItem.rightBarButtonItem = rightButtonItem
  }
  
  
  // Actions
  @objc func segmentedControlAction(_ sender: UISegmentedControl) {
    
    sorting()
    
//    switch segmentedControl.selectedSegmentIndex {
//    case 0:
//      postModels = postModels.sorted(by: { $0.likes < $1.likes})
//    case 1:
//      postModels = postModels.sorted(by: { $0.time < $1.time})
//    default:
//      print("Hello error")
//    }
//
//    tableView.reloadData()
  }
  
  @objc func sortButtonAction() {
    ascendingSorting.toggle()
    if ascendingSorting {
      rightButton.setBackgroundImage(UIImage(named: "AZ"), for: .normal)
    } else {
      rightButton.setBackgroundImage(UIImage(named: "ZA"), for: .normal)
    }
    
    sorting()
  }
  
  private func sorting() {
    if segmentedControl.selectedSegmentIndex == 0 {
      postModels = postModels.sorted(by: { $0.likes < $1.likes})
    } else {
      postModels = postModels.sorted(by: { $0.time < $1.time})
    }
    tableView.reloadData()
  }
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "News"
    
    //    view.addSubview(stackView)
    tableView.delegate = self
    tableView.dataSource = self
    view.backgroundColor = .systemBackground
    
    setupSortingButton()
    setupConstraints()
    
    
    // Mark - вопрос 1 - куда лучше размещать запрос данных
    PostManager.shared.getNews { [weak self] result in
      switch result {
      case .success(let posts):
        self?.news = posts
        self?.postModels = posts.compactMap({
          CellModel(title: $0.title, previewText: $0.previewText, likes: $0.likesCount, time: $0.timestamp)
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
    //    stackView.frame = view.bounds
    //    stackView.frame = CGRect.init(origin: .zero, size: CGSize(width: 200, height: 200))
    //    tableView.frame = view.bounds
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
    
    // if the cell is expanded
    if expandedIndexSet.contains(indexPath.row) {
      // the label can take as many lines it need to display all text
      cell.previewLabel.numberOfLines = 0
      //          cell. messageLabel.numberOfLines = 0
    } else {
      // if the cell is contracted
      // only show first 3 lines
      cell.previewLabel.numberOfLines = 2
      //          cell.messageLabel.numberOfLines = 3
    }
    
    return cell
  }
  
  //  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
  //    return 220
  //  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
    
    // Добавление/удаление в сет развернутых ячеек
//    if(expandedIndexSet.contains(indexPath.row)){
//      expandedIndexSet.remove(indexPath.row)
//    } else {
//      expandedIndexSet.insert(indexPath.row)
//    }
//    tableView.reloadRows(at: [indexPath], with: .automatic)
    
    // открыть новый ВК
     let detailVC = DetailViewController()
    navigationController?.pushViewController(detailVC, animated: true)
  }
}

