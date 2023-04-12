//
//  Message.swift
//  messagekitpractice
//
//
//  Created by Jung peter on 4/5/23.
//

import Foundation
import UIKit

/// A subclass of `UICollectionViewCell` to be used inside of a `MessagesCollectionView`.
 class MessageCollectionViewCell: UICollectionViewCell {

    // MARK: - Initializers

    public override init(frame: CGRect) {
        super.init(frame: frame)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    /// Handle tap gesture on contentView and its subviews.
     func handleTapGesture(_ gesture: UIGestureRecognizer) {
        // Should be overridden
    }
}
