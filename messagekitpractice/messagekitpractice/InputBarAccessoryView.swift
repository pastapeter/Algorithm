//
//  InputBarAccessoryView.swift
//  messagekitpractice
//
//  Created by Jung peter on 4/13/23.
//

import UIKit

protocol InputBarAccessoryViewDelegate: AnyObject {
  
  func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String)
  
  func inputBar(_ inputBar: InputBarAccessoryView, didChangeIntrinsicContentTo size: CGSize)
  
  func inputBar(_ inputBar: InputBarAccessoryView, textViewTextDidChangeTo text: String)
  
}

extension InputBarAccessoryViewDelegate {
  
  func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) { }
  
  func inputBar(_ inputBar: InputBarAccessoryView, didChangeIntrinsicContentTo size: CGSize) {}
  
  func inputBar(_ inputBar: InputBarAccessoryView, textViewTextDidChangeTo text: String) {}
  
}

class InputBarAccessoryView: UIView {
  
  weak var delegate: InputBarAccessoryViewDelegate?
  
  var backgroundView: UIView = {
      let view = UIView()
      view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = .systemBackground
      return view
  }()
  
  var contentView: UIView = {
      let view = UIView()
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
  }()
  
  var blurView: UIVisualEffectView = {
      let blurEffect = UIBlurEffect(style: .light)
      let view = UIVisualEffectView(effect: blurEffect)
      view.translatesAutoresizingMaskIntoConstraints = false
      return view
  }()
  
  let separatorLine = SeparatorLine()
  
  let topStackView: InputStackView = {
      let stackView = InputStackView(axis: .vertical, spacing: 0)
      stackView.alignment = .fill
      return stackView
  }()
  
  let rightStackView = InputStackView(axis: .horizontal, spacing: 0)
  
  let bottomStackView = InputStackView(axis: .horizontal, spacing: 15)
  
  lazy var inputTextView: InputTextView = {
    let inputTextView = InputTextView()
    
  }

  
}
