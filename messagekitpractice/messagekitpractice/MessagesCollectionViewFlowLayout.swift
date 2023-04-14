//
//  MessagesCollectionViewFlowLayout.swift
//  messagekitpractice
//
//  Created by Jung peter on 4/6/23.
//

import Foundation
import UIKit
import AVFoundation

// The layout object used by `MessagesCollectionView` to determine the size of all
/// framework provided `MessageCollectionViewCell` subclasses.
 class MessagesCollectionViewFlowLayout: UICollectionViewFlowLayout {

     override class var layoutAttributesClass: AnyClass {
        return MessagesCollectionViewLayoutAttributes.self
    }
    
    /// The `MessagesCollectionView` that owns this layout object.
    public var messagesCollectionView: MessagesCollectionView {
        guard let messagesCollectionView = collectionView as? MessagesCollectionView else {
            fatalError(MessageKitError.layoutUsedOnForeignType)
        }
        return messagesCollectionView
    }
    
    /// The `MessagesDataSource` for the layout's collection view.
    public var messagesDataSource: MessagesDataSource {
        guard let messagesDataSource = messagesCollectionView.messagesDataSource else {
            fatalError(MessageKitError.nilMessagesDataSource)
        }
        return messagesDataSource
    }
    
    /// The `MessagesLayoutDelegate` for the layout's collection view.
    public var messagesLayoutDelegate: MessagesLayoutDelegate {
        guard let messagesLayoutDelegate = messagesCollectionView.messagesLayoutDelegate else {
            fatalError(MessageKitError.nilMessagesLayoutDelegate)
        }
        return messagesLayoutDelegate
    }

    public var itemWidth: CGFloat {
        guard let collectionView = collectionView else { return 0 }
        return collectionView.frame.width - sectionInset.left - sectionInset.right
    }

    public private(set) var isTypingIndicatorViewHidden: Bool = true

    // MARK: - Initializers

    public override init() {
        super.init()
        setupView()
        setupObserver()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
        setupObserver()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Methods
    
    private func setupView() {
        sectionInset = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
    }
    
    private func setupObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(MessagesCollectionViewFlowLayout.handleOrientationChange(_:)), name: UIApplication.didChangeStatusBarOrientationNotification, object: nil)
    }

   
    // MARK: - Attributes

     override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributesArray = super.layoutAttributesForElements(in: rect) as? [MessagesCollectionViewLayoutAttributes] else {
            return nil
        }
        for attributes in attributesArray where attributes.representedElementCategory == .cell {
            let cellSizeCalculator = cellSizeCalculatorForItem(at: attributes.indexPath)
            cellSizeCalculator.configure(attributes: attributes)
        }
        return attributesArray
    }

     override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        guard let attributes = super.layoutAttributesForItem(at: indexPath) as? MessagesCollectionViewLayoutAttributes else {
            return nil
        }
        if attributes.representedElementCategory == .cell {
            let cellSizeCalculator = cellSizeCalculatorForItem(at: attributes.indexPath)
            cellSizeCalculator.configure(attributes: attributes)
        }
        return attributes
    }

    // MARK: - Layout Invalidation

     override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return collectionView?.bounds.width != newBounds.width
    }

     override func invalidationContext(forBoundsChange newBounds: CGRect) -> UICollectionViewLayoutInvalidationContext {
        let context = super.invalidationContext(forBoundsChange: newBounds)
        guard let flowLayoutContext = context as? UICollectionViewFlowLayoutInvalidationContext else { return context }
        flowLayoutContext.invalidateFlowLayoutDelegateMetrics = shouldInvalidateLayout(forBoundsChange: newBounds)
        return flowLayoutContext
    }

    @objc
    private func handleOrientationChange(_ notification: Notification) {
        invalidateLayout()
    }

    // MARK: - Cell Sizing

    lazy  var textMessageSizeCalculator = TextMessageSizeCalculator(layout: self)
    lazy  var attributedTextMessageSizeCalculator = TextMessageSizeCalculator(layout: self)
    
    /// Note:
    /// - If you override this method, remember to call MessageLayoutDelegate's
    /// customCellSizeCalculator(for:at:in:) method for MessageKind.custom messages, if necessary

     func cellSizeCalculatorForItem(at indexPath: IndexPath) -> CellSizeCalculator {

        let message = messagesDataSource.messageForItem(at: indexPath, in: messagesCollectionView)
        switch message.kind {
        case .text:
            return messagesLayoutDelegate.textCellSizeCalculator(for: message, at: indexPath, in: messagesCollectionView) ?? textMessageSizeCalculator
        case .attributedText:
            return messagesLayoutDelegate.attributedTextCellSizeCalculator(for: message, at: indexPath, in: messagesCollectionView) ??  attributedTextMessageSizeCalculator
        case .custom:
          return messagesLayoutDelegate.customCellSizeCalculator(for: message, at: indexPath, in: messagesCollectionView)
        }
    }

     func sizeForItem(at indexPath: IndexPath) -> CGSize {
        let calculator = cellSizeCalculatorForItem(at: indexPath)
        return calculator.sizeForItem(at: indexPath)
    }
    
    /// Set `incomingAvatarSize` of all `MessageSizeCalculator`s
    public func setMessageIncomingAvatarSize(_ newSize: CGSize) {
        messageSizeCalculators().forEach { $0.incomingAvatarSize = newSize }
    }
    
    /// Set `outgoingAvatarSize` of all `MessageSizeCalculator`s
    public func setMessageOutgoingAvatarSize(_ newSize: CGSize) {
        messageSizeCalculators().forEach { $0.outgoingAvatarSize = newSize }
    }
    
    /// Set `incomingAvatarPosition` of all `MessageSizeCalculator`s
    public func setMessageIncomingAvatarPosition(_ newPosition: AvatarPosition) {
        messageSizeCalculators().forEach { $0.incomingAvatarPosition = newPosition }
    }
    
    /// Set `outgoingAvatarPosition` of all `MessageSizeCalculator`s
    public func setMessageOutgoingAvatarPosition(_ newPosition: AvatarPosition) {
        messageSizeCalculators().forEach { $0.outgoingAvatarPosition = newPosition }
    }

    /// Set `avatarLeadingTrailingPadding` of all `MessageSizeCalculator`s
    public func setAvatarLeadingTrailingPadding(_ newPadding: CGFloat) {
        messageSizeCalculators().forEach { $0.avatarLeadingTrailingPadding = newPadding }
    }
    
    /// Set `incomingMessagePadding` of all `MessageSizeCalculator`s
    public func setMessageIncomingMessagePadding(_ newPadding: UIEdgeInsets) {
        messageSizeCalculators().forEach { $0.incomingMessagePadding = newPadding }
    }
    
    /// Set `outgoingMessagePadding` of all `MessageSizeCalculator`s
    public func setMessageOutgoingMessagePadding(_ newPadding: UIEdgeInsets) {
        messageSizeCalculators().forEach { $0.outgoingMessagePadding = newPadding }
    }
    
    /// Set `incomingCellTopLabelAlignment` of all `MessageSizeCalculator`s
    public func setMessageIncomingCellTopLabelAlignment(_ newAlignment: LabelAlignment) {
        messageSizeCalculators().forEach { $0.incomingCellTopLabelAlignment = newAlignment }
    }
    
    /// Set `outgoingCellTopLabelAlignment` of all `MessageSizeCalculator`s
    public func setMessageOutgoingCellTopLabelAlignment(_ newAlignment: LabelAlignment) {
        messageSizeCalculators().forEach { $0.outgoingCellTopLabelAlignment = newAlignment }
    }
    
    /// Set `incomingCellBottomLabelAlignment` of all `MessageSizeCalculator`s
    public func setMessageIncomingCellBottomLabelAlignment(_ newAlignment: LabelAlignment) {
        messageSizeCalculators().forEach { $0.incomingCellBottomLabelAlignment = newAlignment }
    }
    
    /// Set `outgoingCellBottomLabelAlignment` of all `MessageSizeCalculator`s
    public func setMessageOutgoingCellBottomLabelAlignment(_ newAlignment: LabelAlignment) {
        messageSizeCalculators().forEach { $0.outgoingCellBottomLabelAlignment = newAlignment }
    }
    
    /// Set `incomingMessageTopLabelAlignment` of all `MessageSizeCalculator`s
    public func setMessageIncomingMessageTopLabelAlignment(_ newAlignment: LabelAlignment) {
        messageSizeCalculators().forEach { $0.incomingMessageTopLabelAlignment = newAlignment }
    }
    
    /// Set `outgoingMessageTopLabelAlignment` of all `MessageSizeCalculator`s
    public func setMessageOutgoingMessageTopLabelAlignment(_ newAlignment: LabelAlignment) {
        messageSizeCalculators().forEach { $0.outgoingMessageTopLabelAlignment = newAlignment }
    }
    
    /// Set `incomingMessageBottomLabelAlignment` of all `MessageSizeCalculator`s
    public func setMessageIncomingMessageBottomLabelAlignment(_ newAlignment: LabelAlignment) {
        messageSizeCalculators().forEach { $0.incomingMessageBottomLabelAlignment = newAlignment }
    }
    
    /// Set `outgoingMessageBottomLabelAlignment` of all `MessageSizeCalculator`s
    public func setMessageOutgoingMessageBottomLabelAlignment(_ newAlignment: LabelAlignment) {
        messageSizeCalculators().forEach { $0.outgoingMessageBottomLabelAlignment = newAlignment }
    }

    /// Set `incomingAccessoryViewSize` of all `MessageSizeCalculator`s
    public func setMessageIncomingAccessoryViewSize(_ newSize: CGSize) {
        messageSizeCalculators().forEach { $0.incomingAccessoryViewSize = newSize }
    }

    /// Set `outgoingAccessoryViewSize` of all `MessageSizeCalculator`s
    public func setMessageOutgoingAccessoryViewSize(_ newSize: CGSize) {
        messageSizeCalculators().forEach { $0.outgoingAccessoryViewSize = newSize }
    }

//    /// Set `incomingAccessoryViewPadding` of all `MessageSizeCalculator`s
//    public func setMessageIncomingAccessoryViewPadding(_ newPadding: HorizontalEdgeInsets) {
//        messageSizeCalculators().forEach { $0.incomingAccessoryViewPadding = newPadding }
//    }
//
//    /// Set `outgoingAccessoryViewPadding` of all `MessageSizeCalculator`s
//    public func setMessageOutgoingAccessoryViewPadding(_ newPadding: HorizontalEdgeInsets) {
//        messageSizeCalculators().forEach { $0.outgoingAccessoryViewPadding = newPadding }
//    }
//
//    /// Set `incomingAccessoryViewPosition` of all `MessageSizeCalculator`s
//    public func setMessageIncomingAccessoryViewPosition(_ newPosition: AccessoryPosition) {
//        messageSizeCalculators().forEach { $0.incomingAccessoryViewPosition = newPosition }
//    }
//
//    /// Set `outgoingAccessoryViewPosition` of all `MessageSizeCalculator`s
//    public func setMessageOutgoingAccessoryViewPosition(_ newPosition: AccessoryPosition) {
//        messageSizeCalculators().forEach { $0.outgoingAccessoryViewPosition = newPosition }
//    }

    /// Get all `MessageSizeCalculator`s
     func messageSizeCalculators() -> [MessageSizeCalculator] {
        return [textMessageSizeCalculator,
                attributedTextMessageSizeCalculator
        ]
    }
    
}
