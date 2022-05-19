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
  
  
  
  
  // MARK: - Views
  
  // Если новость будет большая, то пользователь будет скролить
  let scrollView = UIScrollView()
  
  private let postImageView: UIImageView = {
    let image = UIImageView(image: UIImage(named: "postImageView"))
    image.contentMode = .scaleAspectFit
    image.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
    return image
  }()
  
  private let postTitleLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.font = .systemFont(ofSize: 32, weight: .regular)
    label.textAlignment = .left
    label.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
    return label
  }()
  
  private let postTextLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.font = .systemFont(ofSize: 16, weight: .regular)
    label.textAlignment = .left
    label.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
    return label
  }()
  
  private let likesImageView: UIImageView = {
    let image = UIImageView(image: UIImage(systemName: "heart.fill"))
    image.tintColor = .red
    image.contentMode = .scaleAspectFit
    image.frame = .init(x: 0, y: 0, width: 20, height: 20)
    image.backgroundColor = #colorLiteral(red: 0.9568627477, green: 0.6588235497, blue: 0.5450980663, alpha: 1)
    return image
  }()
  
  private let likesCountLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 16, weight: .light)
    label.textAlignment = .left
    label.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
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
  
  private let dayLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = .systemFont(ofSize: 16, weight: .light)
    label.textAlignment = .right
    label.backgroundColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
    return label
  }()
  
  lazy var bottomStackView: UIStackView = {
    let stack = UIStackView(arrangedSubviews: [likesStackView, dayLabel])
    stack.translatesAutoresizingMaskIntoConstraints = false
    stack.spacing = 4
    stack.axis = .horizontal
    stack.alignment = .fill
    stack.distribution = .fillProportionally
    return stack
  }()
  
  lazy var stackView: UIStackView = {
      let stack = UIStackView(arrangedSubviews: [postImageView, postTitleLabel, postTextLabel, bottomStackView])
      stack.spacing = 20
      stack.axis = .vertical
      stack.alignment = .center
      stack.translatesAutoresizingMaskIntoConstraints = false
      return stack
  }()
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupViews()
    setupScrollView()
    setupConstraints()
  }
  
  func setupViews(){
    title = "Natife News"
    view.addSubview(scrollView)
    
//    let backBarButtonItem = UIBarButtonItem(title: "← Назад", style: .done, target: self, action: #selector(dismissButtonAction))
//    backBarButtonItem.tintColor = .black
//    navigationItem.leftBarButtonItem = backBarButtonItem
    
  }
  
  func setupScrollView(){
    scrollView.addSubview(stackView)
    scrollView.translatesAutoresizingMaskIntoConstraints = false
  }
  
  func setupConstraints(){
    scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    scrollView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
    scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
    scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    
    stackView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
    stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 5/6).isActive = true
    stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
    stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
  }
  
  @objc func dismissButtonAction(){
      self.navigationController?.popToRootViewController(animated: true)
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
