//
//  MessageKit+textMessageKind.swift
//  messagekitpractice
//
//  Created by Jung peter on 4/11/23.
//

import Foundation

internal extension MessageKind {
    var textMessageKind: MessageKind {
        switch self {
        case .text, .attributedText:
            return self
        default:
            fatalError("textMessageKind not supported for messageKind: \(self)")
        }
    }
}
