//
//  NewsTableViewCell.swift
//  NatifeTestTask
//
//  Created by Oleksandr Kachkin on 13.05.2022.
//

import UIKit


// перенести во ViewModel
class NewsTableViewCellViewModel {
  let title: String
  let subtitle: String
  
  init(title: String, subtitle: String) {
    self.title = title
    self.subtitle = subtitle
  }
  
}

class NewsTableViewCell: UITableViewCell {
  
  static let reuseId = "NewsTableViewCell"
  
  private let newsTitleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.font = .systemFont(ofSize: 22, weight: .semibold)
    return label
  }()
  
  private let subtitleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 2
    label.font = .systemFont(ofSize: 17, weight: .light)
    return label
  }()
  
  private let likesImageView: UIImageView = {
    let imageView = UIImageView(image: UIImage(systemName: "heart.fill"))
    imageView.tintColor = .red
    return imageView
  }()
  
  //  Написать ЮАЙ программно.
  // Добавить likesCountLabel и timestampLabel
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    contentView.addSubview(newsTitleLabel)
    contentView.addSubview(subtitleLabel)
  }
  
  required init?(coder: NSCoder) {
    fatalError()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    newsTitleLabel.frame = CGRect(
      x: 10,
      y: 0,
      width: contentView.frame.size.width - 10,
      height: 70
    )
    
    subtitleLabel.frame = CGRect(
      x: 10,
      y: 70,
      width: contentView.frame.size.width - 10,
      height: contentView.frame.size.height / 2
    )
    
    // Добавить вьюшки Лайки и Время
  }
  
  override func prepareForReuse() {
    super.prepareForReuse()
    newsTitleLabel.text = nil
    subtitleLabel.text = nil
  }
  
  func configure(with viewModel: NewsTableViewCellViewModel) {
    newsTitleLabel.text = viewModel.title
    subtitleLabel.text = viewModel.subtitle
    
    // likesImageView будет статическим, без изменений
    // Нужно добавить likesCountLabel и timestampLabel
    
  }
}


