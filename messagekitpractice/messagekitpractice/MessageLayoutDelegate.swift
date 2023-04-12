//
//  MessageLayoutDelegate.swift
//  messagekitpractice
//
//  Created by Jung peter on 4/6/23.
//

import Foundation
import UIKit

/// A protocol used by the `MessagesCollectionViewFlowLayout` object to determine
/// the size and layout of a `MessageCollectionViewCell` and its contents.
protocol MessagesLayoutDelegate: AnyObject {

    /// Specifies the size to use for a header view.
    ///
    /// - Parameters:
    ///   - section: The section number of the header.
    ///   - messagesCollectionView: The `MessagesCollectionView` in which this header will be displayed.
    ///
    /// - Note:
    ///   The default value returned by this method is a size of `GGSize.zero`.
    func headerViewSize(for section: Int, in messagesCollectionView: MessagesCollectionView) -> CGSize

    /// Specifies the size to use for a footer view.
    ///
    /// - Parameters:
    ///   - section: The section number of the footer.
    ///   - messagesCollectionView: The `MessagesCollectionView` in which this footer will be displayed.
    ///
    /// - Note:
    ///   The default value returned by this method is a size of `GGSize.zero`.
    func footerViewSize(for section: Int, in messagesCollectionView: MessagesCollectionView) -> CGSize

    /// Specifies the height for the `MessageContentCell`'s top label.
    ///
    /// - Parameters:
    ///   - message: The `MessageType` that will be displayed for this cell.
    ///   - indexPath: The `IndexPath` of the cell.
    ///   - messagesCollectionView: The `MessagesCollectionView` in which this cell will be displayed.
    ///
    /// - Note:
    ///   The default value returned by this method is zero.
    func cellTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat
    
    /// Specifies the height for the `MessageContentCell`'s bottom label.
    ///
    /// - Parameters:
    ///   - message: The `MessageType` that will be displayed for this cell.
    ///   - indexPath: The `IndexPath` of the cell.
    ///   - messagesCollectionView: The `MessagesCollectionView` in which this cell will be displayed.
    ///
    /// - Note:
    ///   The default value returned by this method is zero.
    func cellBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat
    
    /// Specifies the height for the message bubble's top label.
    ///
    /// - Parameters:
    ///   - message: The `MessageType` that will be displayed for this cell.
    ///   - indexPath: The `IndexPath` of the cell.
    ///   - messagesCollectionView: The `MessagesCollectionView` in which this cell will be displayed.
    ///
    /// - Note:
    ///   The default value returned by this method is zero.
    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat

    /// Specifies the label alignment for the message bubble's top label.
    /// - Parameters:
    ///   - message: The `MessageType` that will be displayed for this cell.
    ///   - indexPath: The `IndexPath` of the cell.
    ///   - messagesCollectionView:  The `MessagesCollectionView` in which this cell will be displayed.
    /// - Returns: Optional LabelAlignment for the message bubble's top label. If nil is returned or the delegate method is not implemented,
    ///  alignment from MessageSizeCalculator will be used depending if the message is outgoing or incoming
    func messageTopLabelAlignment(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> LabelAlignment?

    /// Specifies the height for the `MessageContentCell`'s bottom label.
    ///
    /// - Parameters:
    ///   - message: The `MessageType` that will be displayed for this cell.
    ///   - indexPath: The `IndexPath` of the cell.
    ///   - messagesCollectionView: The `MessagesCollectionView` in which this cell will be displayed.
    ///
    /// - Note:
    ///   The default value returned by this method is zero.
    func messageBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat

    /// Specifies the label alignment for the message bubble's bottom label.
    /// - Parameters:
    ///   - message: The `MessageType` that will be displayed for this cell.
    ///   - indexPath: The `IndexPath` of the cell.
    ///   - messagesCollectionView:  The `MessagesCollectionView` in which this cell will be displayed.
    /// - Returns: Optional LabelAlignment for the message bubble's bottom label. If nil is returned or the delegate method is not implemented,
    ///  alignment from MessageSizeCalculator will be used depending if the message is outgoing or incoming
    func messageBottomLabelAlignment(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> LabelAlignment?

    /// Text cell size calculator for messages with MessageType.text.
    ///
    /// - Parameters:
    ///   - message: The text message
    ///   - indexPath: The `IndexPath` of the cell.
    ///   - messagesCollectionView: The `MessagesCollectionView` in which this cell will be displayed.
    ///
    /// - Note:
    ///   The default implementation will return nil. You must override this method if you are using your own cell for messages with MessageType.text.
    func textCellSizeCalculator(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CellSizeCalculator?
    
    /// Attributed text cell size calculator for messages with MessageType.attributedText.
    ///
    /// - Parameters:
    ///   - message: The attributedText message
    ///   - indexPath: The `IndexPath` of the cell.
    ///   - messagesCollectionView: The `MessagesCollectionView` in which this cell will be displayed.
    ///
    /// - Note:
    ///   The default implementation will return nil. You must override this method if you are using your own cell for messages with MessageType.attributedText.
    func attributedTextCellSizeCalculator(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CellSizeCalculator?
    
    /// Custom cell size calculator for messages with MessageType.custom.
    ///
    /// - Parameters:
    ///   - message: The custom message
    ///   - indexPath: The `IndexPath` of the cell.
    ///   - messagesCollectionView: The `MessagesCollectionView` in which this cell will be displayed.
    ///
    /// - Note:
    ///   The default implementation will throw fatalError(). You must override this method if you are using messages with MessageType.custom.
    func customCellSizeCalculator(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CellSizeCalculator
}

 extension MessagesLayoutDelegate {

    func headerViewSize(for section: Int, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return .zero
    }

    func footerViewSize(for section: Int, in messagesCollectionView: MessagesCollectionView) -> CGSize {
        return .zero
    }

    func cellTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 0
    }
    
    func cellBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 0
    }
    
    func messageTopLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 0
    }

    func messageTopLabelAlignment(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> LabelAlignment? {
        return nil
    }

    func messageBottomLabelHeight(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CGFloat {
        return 0
    }

    func messageBottomLabelAlignment(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> LabelAlignment? {
        return nil
    }
    
    func textCellSizeCalculator(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CellSizeCalculator? {
        return nil
    }
    
    func attributedTextCellSizeCalculator(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CellSizeCalculator? {
        return nil
    }
    
    func customCellSizeCalculator(for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> CellSizeCalculator {
        fatalError("Must return a CellSizeCalculator for MessageKind.custom(Any?)")
    }
}
