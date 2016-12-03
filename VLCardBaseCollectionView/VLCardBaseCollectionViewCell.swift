//
//  VLCardBaseCollectionViewCell.swift
//  Pods
//
//  Created by Dinh Luu on 01/12/2016.
//
//

import UIKit
import Kingfisher

extension Int {
  var degreesToRadians: Double { return Double(self) * .pi / 180 }
  var radiansToDegrees: Double { return Double(self) * 180 / .pi }
}
extension FloatingPoint {
  var degreesToRadians: Self { return self * .pi / 180 }
  var radiansToDegrees: Self { return self * 180 / .pi }
}

public protocol VLCardBaseCellModel {
  var content: String! { get set }
  var contentImageUrl: String! { get set }
  var coverColor: UIColor? { get set }
}

class VLCardBaseCollectionViewCell: UICollectionViewCell {
  
  var coverView: UIView!
  var contentImageView: UIImageView!
  var contentLabel: UILabel!
  
  var content: String!
  var contentImage: UIImage!
  var coverColor: UIColor!
  var coverViewTopCons: NSLayoutConstraint!
  
  var topAnchorCons: CGFloat = 40.0
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupUI()
    layoutUI()
  }
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    setupUI()
    layoutUI()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
  }
  
  private func setupUI() {
    coverColor = UIColor(red: 254/255, green: 255/255, blue: 188/255, alpha: 1.0)
    self.clipsToBounds = true
    
    coverView = UIView()
    coverView.backgroundColor = coverColor
    coverView.translatesAutoresizingMaskIntoConstraints = false
    
    contentImageView = UIImageView()
    contentImageView.contentMode = .scaleAspectFill
    contentImageView.translatesAutoresizingMaskIntoConstraints = false
    
    contentLabel = UILabel()
    contentLabel.font = UIFont(name: "AvenirNext-Regular", size: 15.0)
    contentLabel.textColor = UIColor.black
    contentLabel.translatesAutoresizingMaskIntoConstraints = false
    contentLabel.numberOfLines = 0
    contentLabel.baselineAdjustment = .alignCenters
    contentLabel.clipsToBounds = true
    
    contentView.addSubview(contentImageView)
    contentView.addSubview(coverView)
    contentView.addSubview(contentLabel)
    
    let angle = CGFloat((-9).degreesToRadians)
    coverView.layer.transform = CATransform3DMakeRotation(angle, 0, 0, 1)
    contentLabel.alpha          = 0.0
  }
  
  private func layoutUI() {
    
    coverViewTopCons = coverView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: topAnchorCons)
    NSLayoutConstraint.activate([
      
      coverViewTopCons,
      coverView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: -topAnchorCons),
      coverView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: topAnchorCons),
      coverView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: topAnchorCons),
      coverView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      coverView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      
      contentImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
      contentImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0),
      contentImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 0),
      contentImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
      
      contentLabel.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 20),
      contentLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -20),
      contentLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
      contentLabel.topAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 20.0)
      
    ])
  }
  
  func setupCell(model: VLCardBaseCellModel) {
    let resource                = URL(string: model.contentImageUrl)
    contentImageView.kf.setImage(with: resource)
    contentLabel.text           = model.content
    
    if let color = model.coverColor {
      coverView.backgroundColor   = color
    }
  }
  
  override func apply(_ layoutAttributes: UICollectionViewLayoutAttributes) {
    guard let attribute = layoutAttributes as? VLCardBaseCollectionViewLayoutAttribute else { return }
    
    coverViewTopCons.constant   = attribute.topConstant
    contentLabel.alpha          = attribute.alphaFactor
    contentLabel.transform      = CGAffineTransform(scaleX: 1.2 - attribute.scaleFactor, y: 1.2 - attribute.scaleFactor)
  }
  
}
