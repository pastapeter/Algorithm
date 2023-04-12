//
//  MessageContainerView.swift
//  messagekitpractice
//
//  Created by Jung peter on 4/11/23.
//

import UIKit

class MessageContainerView: UIImageView {

    // MARK: - Properties

    private let imageMask = UIImageView()

     var style: MessageStyle = .none {
        didSet {
            applyMessageStyle()
        }
    }

     override var frame: CGRect {
        didSet {
            sizeMaskToView()
        }
    }

    // MARK: - Methods

    private func sizeMaskToView() {
        switch style {
        case .none:
            break
        case .bubble, .bubbleTail, .bubbleOutline, .bubbleTailOutline:
            imageMask.frame = bounds
        }
    }

    private func applyMessageStyle() {
        switch style {
        case .bubble, .bubbleTail:
            imageMask.image = style.image
            sizeMaskToView()
            mask = imageMask
          print("herer")
            image = nil
        case .bubbleOutline(let color):
            let bubbleStyle: MessageStyle = .bubble
            imageMask.image = bubbleStyle.image
            sizeMaskToView()
            mask = imageMask
            image = style.image?.withRenderingMode(.alwaysTemplate)
            tintColor = color
        case .bubbleTailOutline(let color, let tail, let corner):
            let bubbleStyle: MessageStyle = .bubbleTail(tail, corner)
            imageMask.image = bubbleStyle.image
            sizeMaskToView()
            mask = imageMask
            image = style.image?.withRenderingMode(.alwaysTemplate)
            tintColor = color
        case .none:
            mask = nil
            image = nil
            tintColor = nil
        }
    }
}

