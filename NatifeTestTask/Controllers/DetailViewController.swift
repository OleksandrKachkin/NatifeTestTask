//
//  DetailViewController.swift
//  NatifeTestTask
//
//  Created by Oleksandr Kachkin on 19.05.2022.
//

import UIKit
import SwiftUI

class DetailViewController: UIViewController {
  
  // MARK: - Properties
  var height = UIScreen.main.bounds.height / 2
  var newsTitle = ""
  var newsText = ""
  var likes = ""
  var date = ""
  
  // MARK: - Views
  private let imageView: UIImageView = {
    let image = UIImageView(image: UIImage(named: "postImageView"))
    image.contentMode = .scaleToFill
    return image
  }()
  
  lazy var postView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  private let newsTitleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.font = .systemFont(ofSize: 32, weight: .regular)
    label.textAlignment = .left
    return label
  }()
  
  private let previewLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.font = .systemFont(ofSize: 16, weight: .regular)
    label.textAlignment = .left
    return label
  }()
  
  private let likesImageView: UIImageView = {
    let image = UIImageView(image: UIImage(systemName: "heart.fill"))
    image.tintColor = .red
    image.contentMode = .scaleAspectFit
    image.frame = .init(x: 0, y: 0, width: 20, height: 20)
    return image
  }()
  
  private let likesCountLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 16, weight: .light)
    label.textAlignment = .left
    return label
  }()
  
  lazy var likesStackView: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [likesImageView, likesCountLabel])
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.spacing = 4
    stack.axis = .horizontal
    stack.alignment = .fill
    stack.distribution = .fillProportionally
    return stack
  }()
  
  private let timestampLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 16, weight: .light)
    label.textAlignment = .right
    return label
  }()
  
  lazy var stackView: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [imageView, postView])
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.axis = .vertical
    return stack
  }()
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Natife Actual News"
    view.backgroundColor = .white
    
    newsTitleLabel.text = newsTitle
    previewLabel.text = newsText
    likesCountLabel.text = likes
    timestampLabel.text = date
    
    setupPostView()
    setupStackView()
  }
  
  //MARK: - View setup
  func setupPostView(){
    view.addSubview(stackView)
    postView.addSubview(newsTitleLabel)
    postView.addSubview(previewLabel)
    postView.addSubview(likesStackView)
    postView.addSubview(timestampLabel)
  }
  
  func setupStackView(){
    
    // newsTitleLabel constraints
    newsTitleLabel.topAnchor.constraint(equalTo: postView.topAnchor, constant: 20).isActive = true
    newsTitleLabel.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: 20).isActive = true
    newsTitleLabel.trailingAnchor.constraint(equalTo: postView.trailingAnchor, constant: -20).isActive = true
    
    // previewLabel constraints
    previewLabel.topAnchor.constraint(equalTo: newsTitleLabel.bottomAnchor, constant: 20).isActive = true
    previewLabel.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: 20).isActive = true
    previewLabel.trailingAnchor.constraint(equalTo: postView.trailingAnchor, constant: -20).isActive = true
    
    // likesStackView constraints
    likesStackView.topAnchor.constraint(equalTo: previewLabel.bottomAnchor, constant: 20).isActive = true
    likesStackView.leadingAnchor.constraint(equalTo: postView.leadingAnchor, constant: 15).isActive = true
    likesStackView.heightAnchor.constraint(equalToConstant: 20).isActive = true
    
    // timestampLabel constraints
    timestampLabel.topAnchor.constraint(equalTo: previewLabel.bottomAnchor, constant: 20).isActive = true
    timestampLabel.trailingAnchor.constraint(equalTo: postView.trailingAnchor, constant: -15).isActive = true
    timestampLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    
    // stackView constraints
    stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
    stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
    stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
  }
}

