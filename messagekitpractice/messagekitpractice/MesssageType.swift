//
//  MesssageType.swift
//  messagekitpractice
//
//  Created by Jung peter on 4/5/23.
//

import Foundation

public protocol MessageType {

    /// The sender of the message.
    var sender: SenderType { get }

    /// The unique identifier for the message.
    var messageId: String { get }

    /// The date the message was sent.
    var sentDate: Date { get }

    /// The kind of message and its underlying kind.
    var kind: MessageKind { get }

}

