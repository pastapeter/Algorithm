//
//  InputTextView.swift
//  messagekitpractice
//
//  Created by Jung peter on 4/14/23.
//

import UIKit

class InputTextView: UITextView {
  
  override var text: String! {
    didSet {
      postTextViewDidChangeNotification()
    }
  }
  
  override var attributedText: NSAttributedString! {
    didSet {
        postTextViewDidChangeNotification()
    }
  }
  
  var placeholderLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textColor = .lightGray
    label.text = "New Message"
    label.backgroundColor = .clear
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  var placeholder: String? = "New Message" {
    didSet {
      placeholderLabel.text = placeholder
    }
  }
  
  var placeholderTextColor: UIColor? = .lightGray {
    didSet {
      placeholderLabel.textColor = placeholderTextColor
    }
  }
  
  var placeholderLabelInsets: UIEdgeInsets = UIEdgeInsets(top: 8, left: 4, bottom: 8, right: 4)  {
      didSet {
          updateConstraintsForPlaceholderLabel()
      }
  }
  
  override var font: UIFont! {
    didSet {
      placeholderLabel.font = font
    }
  }
  
}

extension InputTextView {
  
  private func postTextViewDidChangeNotification() {
      NotificationCenter.default.post(name: UITextView.textDidChangeNotification, object: self)
  }
  
  @objc private func textViewTextDidChange() {
    
  }
  
}
