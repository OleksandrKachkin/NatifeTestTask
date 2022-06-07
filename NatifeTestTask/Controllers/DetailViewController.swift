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
  var id = 0
  var newsTitle = ""
  var newsText = ""
  var likes = ""
  var date = ""
  
  private var post: PostID?
  private let scrollView = UIScrollView()
  
  // MARK: - Views
  
  private let imageView: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
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
    label.font = .systemFont(ofSize: 20, weight: .semibold)
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
    let stack = UIStackView(arrangedSubviews: [postView])
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.axis = .vertical
    return stack
  }()
  
  // MARK: - Lifecycle
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    newsTitleLabel.text = newsTitle
//    previewLabel.text = newsText
    likesCountLabel.text = likes
    timestampLabel.text = date
    
    setupViews()
    setupScrollView()
    setupConstraints()
    
    PostManager.shared.getPost(id: id) { [weak self] result in
      switch result {
      case .success(let posts):
        self?.post = posts
        
        self!.imageView.loadFrom(URLAddress: posts.postImage)
        
        DispatchQueue.main.async {
          self!.previewLabel.text = posts.text
        }
        
      case .failure(let error):
        print(error)
      }
    }
  }
  
  //MARK: - View setup
  func setupViews(){
    title = "Natife News"
    view.backgroundColor = .white
    view.addSubview(scrollView)
    view.addSubview(imageView)
    
//    view.addSubview(stackView)
    postView.addSubview(newsTitleLabel)
    postView.addSubview(previewLabel)
    postView.addSubview(likesStackView)
    postView.addSubview(timestampLabel)
  }
  
  func setupScrollView() {
    scrollView.addSubview(stackView)
    scrollView.translatesAutoresizingMaskIntoConstraints = false
  }
  
  func setupConstraints() {
    
    // imageView constraints
    imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
    imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
    imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
    
    // scrollView constraints
    scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    scrollView.topAnchor.constraint(equalTo: imageView.bottomAnchor).isActive = true
    scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    
    // stackView constraints
    stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
    stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
    stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    
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
    
   
  }
}


