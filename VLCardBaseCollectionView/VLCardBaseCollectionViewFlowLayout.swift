//
//  VLCardBaseCollectionViewFlowLayout.swift
//  Pods
//
//  Created by Dinh Luu on 01/12/2016.
//
//

import UIKit

class VLCardBaseCollectionViewFlowLayout: UICollectionViewFlowLayout {
  
  private var collectionViewSize: CGSize {
    return collectionView!.bounds.size
  }
  
  private var itemGap: CGFloat {
    return collectionViewSize.width / 14
  }
  
  private var inset: CGFloat {
    return 10.0 + itemGap
  }
  
  func setupLayout() {
    scrollDirection = .horizontal
    collectionView!.contentInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
    minimumLineSpacing = itemGap
    itemSize = CGSize(width: collectionViewSize.width - itemGap*2 - 20, height: collectionViewSize.height)
  }
  
  override class var layoutAttributesClass: Swift.AnyClass {
    return VLCardBaseCollectionViewLayoutAttribute.self
  }
  
  override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
    return true
  }
  
  override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
    var offsetAdjust: CGFloat = 10000
    
    let horizontalCenter = proposedContentOffset.x + collectionView!.bounds.width / 2
    
    let proposedRect = CGRect(x: proposedContentOffset.x,
                              y: 0.0,
                              width: collectionView!.bounds.width,
                              height: collectionView!.bounds.height)
    
    guard let attributesArray = super.layoutAttributesForElements(in: proposedRect) else { return proposedContentOffset }
    
    for attribute in attributesArray {
      if case UICollectionElementCategory.supplementaryView = attribute.representedElementCategory { continue }
      
      let itemHorizontalCenter = attribute.center.x
      if fabs(itemHorizontalCenter - horizontalCenter) < fabs(offsetAdjust) {
        offsetAdjust = itemHorizontalCenter - horizontalCenter
      }
    }
    
    return CGPoint(x: proposedContentOffset.x + offsetAdjust, y: proposedContentOffset.y + offsetAdjust)
  }
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    guard let attributesArray = super.layoutAttributesForElements(in: rect) else { return nil }
    
    guard let collectionView = self.collectionView else { return attributesArray }
    
    let visibleRect = CGRect(x: collectionView.contentOffset.x,
                             y: collectionView.contentOffset.y,
                             width: collectionView.bounds.width,
                             height: collectionView.bounds.height)
    
    for attribute in attributesArray {
      apply(layoutAttributes: attribute as! VLCardBaseCollectionViewLayoutAttribute, for: visibleRect)
    }
    
    return attributesArray
  }
  
  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    guard let attribute = super.layoutAttributesForItem(at: indexPath) else { return nil }
    
    let visibleRect = CGRect(x: collectionView!.contentOffset.x,
                             y: collectionView!.contentOffset.y,
                             width: collectionView!.bounds.width,
                             height: collectionView!.bounds.height)
    apply(layoutAttributes: attribute as! VLCardBaseCollectionViewLayoutAttribute, for: visibleRect)
    
    return attribute
  }
  
  func apply(layoutAttributes attributes: VLCardBaseCollectionViewLayoutAttribute, for visibleRect: CGRect) {
    let maxConstant = collectionViewSize.height/2 + 30.0
    let ACTIVE_DISTANCE = collectionView!.bounds.width/2 + 10.0
    // skip supplementary kind
    if case UICollectionElementCategory.supplementaryView = attributes.representedElementCategory { return }
    
    let distanceFromVisibleRectToItem: CGFloat = visibleRect.midX - attributes.center.x
    if fabs(distanceFromVisibleRectToItem) < ACTIVE_DISTANCE {
      
      let normalizeDistance = fabs(distanceFromVisibleRectToItem) / ACTIVE_DISTANCE
      
      let factorScale = 1 - normalizeDistance
      attributes.topConstant = -40 + (factorScale * maxConstant)
      attributes.alphaFactor = factorScale
      attributes.scaleFactor = 0.2*factorScale
    } else {
      attributes.topConstant = -40
      attributes.alphaFactor = 0.0
    }
    
  }
  
}
