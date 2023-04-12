//
//  UIColor+Extension.swift
//  messagekitpractice
//
//  Created by Jung peter on 4/5/23.
//

import Foundation
import UIKit

internal extension UIColor {

  static var incomingMessageBackground: UIColor { .systemBlue  }

  static var outgoingMessageBackground: UIColor { .systemGreen }
    
  static var incomingMessageLabel: UIColor { .white }
    
  static var outgoingMessageLabel: UIColor { .white }

  static var collectionViewBackground: UIColor { .white }

  static var typingIndicatorDot: UIColor { .brown }
    
  static var label: UIColor { .yellow }
  
  //Theme Color
  static let primaryColor = UIColor(red: 69/255, green: 193/255, blue: 89/255, alpha: 1)
  
  static let oppositeColor =  UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1)

}

