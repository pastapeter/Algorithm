//
//  UIEdgeInsets+Extensions.swift
//  messagekitpractice
//
//  Created by Jung peter on 4/11/23.
//

import Foundation
import UIKit

internal extension UIEdgeInsets {

    var vertical: CGFloat {
        return top + bottom
    }

    var horizontal: CGFloat {
        return left + right
    }

}
