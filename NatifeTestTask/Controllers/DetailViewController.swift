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
  
  var newsTitle = ""
  var newsText = ""
  var likes = ""
  var date = "" // 1645030659
//  var dateTest: String {
//    let input: Date = Date(timeIntervalSince1970: date)
//    let dataFormatter = DateFormatter()
//    dataFormatter.dateFormat = "EEE, MMMM d YYYY"
//    return dataFormatter.string(from: input)
//  }
  
  var height = UIScreen.main.bounds.height / 2
  
//  public func configure(with date: Date) {
//    dayLabe.text = date.toString(withFormat: "d")
//    dayOfTheWeakLabel.text = date.toString(withFormat: "EEE").uppercased()
//  }
  
  // MARK: - Views
  
  // Картинка в верхней части экрана
  private let imageView: UIImageView = {
    let image = UIImageView(image: UIImage(named: "postImageView"))
    image.contentMode = .scaleToFill
    return image
  }()
  
  // Нижняя часть экрана
  let postView: UIView = {
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
  
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Natife Actual News"
    view.backgroundColor = .white
    
    newsTitleLabel.text = newsTitle
    previewLabel.text = newsText
    likesCountLabel.text = likes
    timestampLabel.text = date
      
      
    
    setupPostView()
    setupConstraints()
  }

  
  func setupPostView(){
    postView.addSubview(newsTitleLabel)
    postView.addSubview(previewLabel)
    postView.addSubview(likesStackView)
    postView.addSubview(timestampLabel)
    
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
  
  func setupConstraints(){
    view.addSubview(stackView)

    stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
    stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
    stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
    stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
    
  }
}


// MARK: - Show Canvas like SwiftUI

struct SwiftUIController: UIViewControllerRepresentable {
  typealias UIViewControllerType = DetailViewController
  
  func makeUIViewController(context: Context) -> UIViewControllerType {
    let viewController = UIViewControllerType()
    return viewController
  }
  
  func updateUIViewController(_ uiViewController: DetailViewController, context: Context) {
    
  }
}

struct SwiftUIController_Previews: PreviewProvider {
  static var previews: some View {
    SwiftUIController().edgesIgnoringSafeArea(.all)
  }
}
