//
//  VLCardBaseCollectionView.swift
//  Pods
//
//  Created by Dinh Luu on 01/12/2016.
//
//

import UIKit

public class VLCardBaseCollectionView: UICollectionView {
  
  var layout: VLCardBaseCollectionViewFlowLayout!
  public var cellModel: [VLCardBaseCellModel]!
  
  public init(frame: CGRect, models: [VLCardBaseCellModel]) {
    layout = VLCardBaseCollectionViewFlowLayout()
    super.init(frame: frame, collectionViewLayout: layout)
    
    cellModel = models
    
    register(VLCardBaseCollectionViewCell.self, forCellWithReuseIdentifier: "VLCardBaseCollectionViewCell")
    
    dataSource = self
    delegate = self
    
    showsVerticalScrollIndicator = false
    showsHorizontalScrollIndicator = false
  }
  
  required public init?(coder aDecoder: NSCoder) {
    layout = VLCardBaseCollectionViewFlowLayout()
    super.init(coder: aDecoder)
  }
  
  public override func layoutSubviews() {
    super.layoutSubviews()
    layout.setupLayout()
  }
}

extension VLCardBaseCollectionView: UICollectionViewDataSource, UICollectionViewDelegate {
  public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return cellModel.count
  }
  
  public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "VLCardBaseCollectionViewCell", for: indexPath) as! VLCardBaseCollectionViewCell
    
    let model = cellModel[indexPath.row]
    cell.setupCell(model: model)
    
    return cell
  }
  
  public func scrollViewDidScroll(_ scrollView: UIScrollView) {
    print(scrollView.contentOffset)
  }
}
