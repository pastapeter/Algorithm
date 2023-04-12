//
//  MessageReusableView.swift
//  messagekitpractice
//
//  Created by Jung peter on 4/6/23.
//

import Foundation
import UIKit

open class MessageReusableView: UICollectionReusableView {

    // MARK: - Initializers

    public override init(frame: CGRect) {
        super.init(frame: frame)
    }

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

}
