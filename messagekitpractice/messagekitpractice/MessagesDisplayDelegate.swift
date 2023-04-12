//
//  MessagesDisplayDelegate.swift
//  messagekitpractice
//
//  Created by Jung peter on 4/5/23.
//

import Foundation
import UIKit

/// A protocol used by the `MessagesViewController` to customize the appearance of a `MessageContentCell`.
 protocol MessagesDisplayDelegate: AnyObject {

    // MARK: - All Messages

    /// Specifies the `MessageStyle` to be used for a `MessageContainerView`.
    ///
    /// - Parameters:
    ///   - message: The `MessageType` that will be displayed by this cell.
    ///   - indexPath: The `IndexPath` of the cell.
    ///   - messagesCollectionView: The `MessagesCollectionView` in which this cell will be displayed.
    ///
    /// - Note:
    ///   The default value returned by this method is `MessageStyle.bubble`.
    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle

    /// Specifies the background color of the `MessageContainerView`.
    ///
    /// - Parameters:
    ///   - message: The `MessageType` that will be displayed by this cell.
    ///   - indexPath: The `IndexPath` of the cell.
    ///   - messagesCollectionView: The `MessagesCollectionView` in which this cell will be displayed.
    ///
    /// - Note:
    ///   The default value is `UIColor.clear` for emoji messages.
    ///   For all other `MessageKind` cases, the color depends on the `SenderType`.
    ///
    ///   Current sender: Green
    ///
    ///   All other senders: Gray
    func backgroundColor(for message: MessageType, at  indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor

    /// The section header to use for a given `IndexPath`.
    ///
    /// - Parameters:
    ///   - message: The `MessageType` that will be displayed for this header.
    ///   - indexPath: The `IndexPath` of the header.
    ///   - messagesCollectionView: The `MessagesCollectionView` in which this header will be displayed.
    func messageHeaderView(for indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageReusableView

    /// The section footer to use for a given `IndexPath`.
    ///
    /// - Parameters:
    ///   - indexPath: The `IndexPath` of the footer.
    ///   - messagesCollectionView: The `MessagesCollectionView` in which this footer will be displayed.
    func messageFooterView(for indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageReusableView
    
    /// Used to configure the `AvatarView`‘s image in a `MessageContentCell` class.
    ///
    /// - Parameters:
    ///   - avatarView: The `AvatarView` of the cell.
    ///   - message: The `MessageType` that will be displayed by this cell.
    ///   - indexPath: The `IndexPath` of the cell.
    ///   - messagesCollectionView: The `MessagesCollectionView` in which this cell will be displayed.
    ///
    /// - Note:
    ///   The default image configured by this method is `?`.
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView)

    /// Used to configure the `AccessoryView` in a `MessageContentCell` class.
    ///
    /// - Parameters:
    ///   - accessoryView: The `AccessoryView` of the cell.
    ///   - message: The `MessageType` that will be displayed by this cell.
    ///   - indexPath: The `IndexPath` of the cell.
    ///   - messagesCollectionView: The `MessagesCollectionView` in which this cell will be displayed.
    ///
    /// - Note:
    ///   The default image configured by this method is `?`.
    func configureAccessoryView(_ accessoryView: UIView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView)

    // MARK: - Text Messages

    /// Specifies the color of the text for a `TextMessageCell`.
    ///
    /// - Parameters:
    ///   - message: A `MessageType` with a `MessageKind` case of `.text` to which the color will apply.
    ///   - indexPath: The `IndexPath` of the cell.
    ///   - messagesCollectionView: The `MessagesCollectionView` in which this cell will be displayed.
    ///
    /// - Note:
    ///   The default value returned by this method is determined by the messages `SenderType`.
    ///
    ///   Current sender: UIColor.white
    ///
    ///   All other senders: UIColor.darkText
    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor

    /// Specifies the `DetectorType`s to check for the `MessageType`'s text against.
    ///
    /// - Parameters:
    ///   - message: A `MessageType` with a `MessageKind` case of `.text` or `.attributedText` to which the detectors will apply.
    ///   - indexPath: The `IndexPath` of the cell.
    ///   - messagesCollectionView: The `MessagesCollectionView` in which this cell will be displayed.
    ///
    /// - Note:
    ///   This method returns an empty array by default.
    func enabledDetectors(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> [DetectorType]

    /// Specifies the attributes for a given `DetectorType`
    ///
    /// - Parameters:
    ///   - detector: The `DetectorType` for the applied attributes.
    ///   - message: A `MessageType` with a `MessageKind` case of `.text` or `.attributedText` to which the detectors will apply.
    ///   - indexPath: The `IndexPath` of the cell.
    func detectorAttributes(for detector: DetectorType, and message: MessageType, at indexPath: IndexPath) -> [NSAttributedString.Key: Any]
}

extension MessagesDisplayDelegate {

    // MARK: - All Messages Defaults

    func messageStyle(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageStyle {
        return .bubble
    }

    func backgroundColor(for message: MessageType, at  indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {

        switch message.kind {
        default:
            guard let dataSource = messagesCollectionView.messagesDataSource else {
              return .white
            }
            return dataSource.isFromCurrentSender(message: message) ? .outgoingMessageBackground : .incomingMessageBackground
        }
    }
    
    func messageHeaderView(for indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageReusableView {
        return messagesCollectionView.dequeueReusableHeaderView(MessageReusableView.self, for: indexPath)
    }

    func messageFooterView(for indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageReusableView {
        return messagesCollectionView.dequeueReusableFooterView(MessageReusableView.self, for: indexPath)
    }
    
    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
        avatarView.initials = "?"
    }

    func configureAccessoryView(_ accessoryView: UIView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {}

    // MARK: - Text Messages Defaults

    func textColor(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> UIColor {
        guard let dataSource = messagesCollectionView.messagesDataSource else {
            fatalError(MessageKitError.nilMessagesDataSource)
        }
        return dataSource.isFromCurrentSender(message: message) ? .outgoingMessageLabel : .incomingMessageLabel
    }

    func enabledDetectors(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> [DetectorType] {
        return []
    }

    func detectorAttributes(for detector: DetectorType, and message: MessageType, at indexPath: IndexPath) -> [NSAttributedString.Key: Any] {
        return MessageLabel.defaultAttributes
    }

}
