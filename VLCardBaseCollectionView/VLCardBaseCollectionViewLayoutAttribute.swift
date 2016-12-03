//
//  VLCardBaseCollectionViewLayoutAttribute.swift
//  Pods
//
//  Created by Dinh Luu on 01/12/2016.
//
//

import UIKit

class VLCardBaseCollectionViewLayoutAttribute: UICollectionViewLayoutAttributes {
  
  var topConstant: CGFloat = -40
  var alphaFactor: CGFloat = 0.0
  var scaleFactor: CGFloat = 1.5
  
  override func copy(with zone: NSZone? = nil) -> Any {
    if let attribute = super.copy(with: zone) as? VLCardBaseCollectionViewLayoutAttribute {
      attribute.topConstant = self.topConstant
      attribute.alphaFactor = alphaFactor
      attribute.scaleFactor = scaleFactor
      return attribute
    }
    
    return super.copy(with: zone)
  }
  
  override func isEqual(_ object: Any?) -> Bool {
    if let attribute = object as? VLCardBaseCollectionViewLayoutAttribute {
      if attribute.topConstant == self.topConstant && attribute.alphaFactor == alphaFactor && attribute.scaleFactor == scaleFactor {
        return super.isEqual(object)
      }
    }
    
    return false
  }

}
