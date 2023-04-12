//
//  LabelAlignment.swift
//  messagekitpractice
//
//  Created by Jung peter on 4/6/23.
//

import UIKit

public struct LabelAlignment: Equatable {

    public var textAlignment: NSTextAlignment
    public var textInsets: UIEdgeInsets
    
    public init(textAlignment: NSTextAlignment, textInsets: UIEdgeInsets) {
        self.textAlignment = textAlignment
        self.textInsets = textInsets
    }

}

// MARK: - Equatable Conformance

public extension LabelAlignment {

    static func == (lhs: LabelAlignment, rhs: LabelAlignment) -> Bool {
        return lhs.textAlignment == rhs.textAlignment && lhs.textInsets == rhs.textInsets
    }

}
