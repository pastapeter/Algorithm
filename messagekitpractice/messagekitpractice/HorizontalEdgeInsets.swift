//
//  HorizontalEdgeInsets.swift
//  messagekitpractice
//
//  Created by Jung peter on 4/11/23.
//

import Foundation
import UIKit

public struct HorizontalEdgeInsets: Equatable {

    public var left: CGFloat
    public var right: CGFloat

    public init(left: CGFloat, right: CGFloat) {
        self.left = left
        self.right = right
    }

    public static var zero: HorizontalEdgeInsets {
        return HorizontalEdgeInsets(left: 0, right: 0)
    }
}

// MARK: Equatable Conformance

public extension HorizontalEdgeInsets {

    static func == (lhs: HorizontalEdgeInsets, rhs: HorizontalEdgeInsets) -> Bool {
        return lhs.left == rhs.left && lhs.right == rhs.right
    }
}

internal extension HorizontalEdgeInsets {

    var horizontal: CGFloat {
        return left + right
    }
}
