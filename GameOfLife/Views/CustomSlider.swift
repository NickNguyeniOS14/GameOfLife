//
//  CustomSlider.swift
//  GameOfLife
//
//  Created by Nick Nguyen on 7/29/20.
//

import UIKit

class CustomSlider: UISlider {
  @IBInspectable var trackHeight: CGFloat = 20
  
  override func trackRect(forBounds bounds: CGRect) -> CGRect {
    return CGRect(origin: bounds.origin, size: CGSize(width: bounds.width, height: trackHeight))
  }
}
