//
//  InsetLabel.swift
//  messagekitpractice
//
//  Created by Jung peter on 4/11/23.
//

import UIKit

class InsetLabel: UILabel {
  
  var textInsets: UIEdgeInsets = .zero {
    didSet { setNeedsDisplay() }
  }
  
  override func drawText(in rect: CGRect) {
    let insetRect = rect.inset(by: textInsets)
    super.drawText(in: insetRect)
  }
  
  
}
