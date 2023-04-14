//
//  MessageViewController.swift
//  messagekitpractice
//
//  Created by Jung peter on 4/5/23.
//

import Foundation
import UIKit

class MessagesViewController: UIViewController,
UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIGestureRecognizerDelegate {

    /// The `MessagesCollectionView` managed by the messages view controller object.
     var messagesCollectionView = MessagesCollectionView()

    /// The `InputBarAccessoryView` used as the `inputAccessoryView` in the view controller.
  // 현재 회사에서 사용할 수 없을 수도 있음
  // 하지만 해당 기능이 필요하긴함 -> 다른 방법으로 구현해야함
//     lazy var messageInputBar = InputBarAccessoryView()

    /// A Boolean value that determines whether the `MessagesCollectionView` scrolls to the
    /// last item whenever the `InputTextView` begins editing.
    ///
    /// The default value of this property is `false`.
    /// NOTE: This is related to `scrollToLastItem` whereas the below flag is related to `scrollToBottom` - check each function for differences
     var scrollsToLastItemOnKeyboardBeginsEditing: Bool = false

    /// A Boolean value that determines whether the `MessagesCollectionView` scrolls to the
    /// bottom whenever the `InputTextView` begins editing.
    ///
    /// The default value of this property is `false`.
    /// NOTE: This is related to `scrollToBottom` whereas the above flag is related to `scrollToLastItem` - check each function for differences
    @available(*, deprecated, message: "Control scrolling to bottom on keyboardBeginEditing by using scrollsToLastItemOnKeyboardBeginsEditing instead", renamed: "scrollsToLastItemOnKeyboardBeginsEditing")
     var scrollsToBottomOnKeyboardBeginsEditing: Bool = false
    
    /// A Boolean value that determines whether the `MessagesCollectionView`
    /// maintains it's current position when the height of the `MessageInputBar` changes.
    ///
    /// The default value of this property is `false`.
     var maintainPositionOnKeyboardFrameChanged: Bool = false

    /// Display the date of message by swiping left.
    /// The default value of this property is `false`.
     var showMessageTimestampOnSwipeLeft: Bool = false {
        didSet {
            messagesCollectionView.showMessageTimestampOnSwipeLeft = showMessageTimestampOnSwipeLeft
            if showMessageTimestampOnSwipeLeft {
                addPanGesture()
            } else {
                removePanGesture()
            }
        }
    }

    /// Pan gesture for display the date of message by swiping left.
    private var panGesture: UIPanGestureRecognizer?

     override var canBecomeFirstResponder: Bool {
        return true
    }

     override var inputAccessoryView: UIView? {
//        return messageInputBar
       return nil
    }

     override var shouldAutorotate: Bool {
        return false
    }

    /// A CGFloat value that adds to (or, if negative, subtracts from) the automatically
    /// computed value of `messagesCollectionView.contentInset.bottom`. Meant to be used
    /// as a measure of last resort when the built-in algorithm does not produce the right
    /// value for your app. Please let us know when you end up having to use this property.
     var additionalBottomInset: CGFloat = 0 {
        didSet {
            let delta = additionalBottomInset - oldValue
            messageCollectionViewBottomInset += delta
        }
    }

    public var isTypingIndicatorHidden: Bool {
        return messagesCollectionView.isTypingIndicatorHidden
    }

    public var selectedIndexPathForMenu: IndexPath?

    private var isFirstLayout: Bool = true
    
    internal var isMessagesControllerBeingDismissed: Bool = false

    internal var messageCollectionViewBottomInset: CGFloat = 0 {
        didSet {
            messagesCollectionView.contentInset.bottom = messageCollectionViewBottomInset
            messagesCollectionView.scrollIndicatorInsets.bottom = messageCollectionViewBottomInset
        }
    }

    // MARK: - View Life Cycle

     override func viewDidLoad() {
        super.viewDidLoad()
        setupDefaults()
        setupSubviews()
        setupConstraints()
        setupDelegates()
//        addMenuControllerObservers()
        addObservers()
    }
    
     override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !isFirstLayout {
            addKeyboardObservers()
        }
    }
    
     override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isMessagesControllerBeingDismissed = false
    }
    
     override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        isMessagesControllerBeingDismissed = true
        removeKeyboardObservers()
    }
    
     override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        isMessagesControllerBeingDismissed = false
    }
    
     override func viewDidLayoutSubviews() {
        // Hack to prevent animation of the contentInset after viewDidAppear
        if isFirstLayout {
            defer { isFirstLayout = false }
            addKeyboardObservers()
            messageCollectionViewBottomInset = requiredInitialScrollViewBottomInset()
        }
    }

     override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        messageCollectionViewBottomInset = requiredInitialScrollViewBottomInset()
    }

    // MARK: - Initializers

    deinit {
//        removeMenuControllerObservers()
        removeObservers()
        clearMemoryCache()
    }

    // MARK: - Methods [Private]

    /// Display time of message by swiping the cell
    private func addPanGesture() {
        panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
        guard let panGesture = panGesture else {
            return
        }
        panGesture.delegate = self
        messagesCollectionView.addGestureRecognizer(panGesture)
        messagesCollectionView.clipsToBounds = false
    }

    private func removePanGesture() {
        guard let panGesture = panGesture else {
            return
        }
        panGesture.delegate = nil
        self.panGesture = nil
        messagesCollectionView.removeGestureRecognizer(panGesture)
        messagesCollectionView.clipsToBounds = true
    }

    @objc
    private func handlePanGesture(_ gesture: UIPanGestureRecognizer) {
        guard let parentView = gesture.view else {
            return
        }

        switch gesture.state {
        case .began, .changed:
            messagesCollectionView.showsVerticalScrollIndicator = false
            let translation = gesture.translation(in: view)
            let minX = -(view.frame.size.width * 0.35)
            let maxX: CGFloat = 0
            var offsetValue = translation.x
            offsetValue = max(offsetValue, minX)
            offsetValue = min(offsetValue, maxX)
            parentView.frame.origin.x = offsetValue
        case .ended:
            messagesCollectionView.showsVerticalScrollIndicator = true
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
                parentView.frame.origin.x = 0
            }, completion: nil)
        default:
            break
        }
    }

    private func setupDefaults() {
        extendedLayoutIncludesOpaqueBars = true
        view.backgroundColor = .collectionViewBackground
        messagesCollectionView.keyboardDismissMode = .interactive
        messagesCollectionView.alwaysBounceVertical = true
        messagesCollectionView.backgroundColor = .collectionViewBackground
        if #available(iOS 13.0, *) {
            messagesCollectionView.automaticallyAdjustsScrollIndicatorInsets = false
        }
    }

    private func setupDelegates() {
        messagesCollectionView.delegate = self
        messagesCollectionView.dataSource = self
    }

    private func setupSubviews() {
        view.addSubview(messagesCollectionView)
    }

    private func setupConstraints() {
        messagesCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        let top = messagesCollectionView.topAnchor.constraint(equalTo: view.topAnchor)
        let bottom = messagesCollectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        let leading = messagesCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor)
        let trailing = messagesCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        NSLayoutConstraint.activate([top, bottom, trailing, leading])
    }

    // MARK: - Typing Indicator API

    /// Sets the typing indicator sate by inserting/deleting the `TypingBubbleCell`
    ///
    /// - Parameters:
    ///   - isHidden: A Boolean value that is to be the new state of the typing indicator
    ///   - animated: A Boolean value determining if the insertion is to be animated
    ///   - updates: A block of code that will be executed during `performBatchUpdates`
    ///              when `animated` is `TRUE` or before the `completion` block executes
    ///              when `animated` is `FALSE`
    ///   - completion: A completion block to execute after the insertion/deletion
     func setTypingIndicatorViewHidden(_ isHidden: Bool, animated: Bool, whilePerforming updates: (() -> Void)? = nil, completion: ((Bool) -> Void)? = nil) {

        guard isTypingIndicatorHidden != isHidden else {
            completion?(false)
            return
        }

        let section = messagesCollectionView.numberOfSections

        if animated {
            messagesCollectionView.performBatchUpdates({ [weak self] in
                self?.performUpdatesForTypingIndicatorVisability(at: section)
                updates?()
                }, completion: completion)
        } else {
            performUpdatesForTypingIndicatorVisability(at: section)
            updates?()
            completion?(true)
        }
    }

    /// Performs a delete or insert on the `MessagesCollectionView` on the provided section
    ///
    /// - Parameter section: The index to modify
    private func performUpdatesForTypingIndicatorVisability(at section: Int) {
        if isTypingIndicatorHidden {
            messagesCollectionView.deleteSections([section - 1])
        } else {
            messagesCollectionView.insertSections([section])
        }
    }

    /// A method that by default checks if the section is the last in the
    /// `messagesCollectionView` and that `isTypingIndicatorViewHidden`
    /// is FALSE
    ///
    /// - Parameter section
    /// - Returns: A Boolean indicating if the TypingIndicator should be presented at the given section
    public func isSectionReservedForTypingIndicator(_ section: Int) -> Bool {
        return !messagesCollectionView.isTypingIndicatorHidden && section == self.numberOfSections(in: messagesCollectionView) - 1
    }

    // MARK: - UICollectionViewDataSource

     func numberOfSections(in collectionView: UICollectionView) -> Int {
        guard let collectionView = collectionView as? MessagesCollectionView else {
            fatalError(MessageKitError.notMessagesCollectionView)
        }
        let sections = collectionView.messagesDataSource?.numberOfSections(in: collectionView) ?? 0
        return collectionView.isTypingIndicatorHidden ? sections : sections + 1
    }

     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let collectionView = collectionView as? MessagesCollectionView else {
            fatalError(MessageKitError.notMessagesCollectionView)
        }
        if isSectionReservedForTypingIndicator(section) {
            return 1
        }
        return collectionView.messagesDataSource?.numberOfItems(inSection: section, in: collectionView) ?? 0
    }

    /// Notes:
    /// - If you override this method, remember to call MessagesDataSource's customCell(for:at:in:)
    /// for MessageKind.custom messages, if necessary.
    ///
    /// - If you are using the typing indicator you will need to ensure that the section is not
    /// reserved for it with `isSectionReservedForTypingIndicator` defined in
    /// `MessagesCollectionViewFlowLayout`
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        guard let messagesCollectionView = collectionView as? MessagesCollectionView else {
            fatalError(MessageKitError.notMessagesCollectionView)
        }

        guard let messagesDataSource = messagesCollectionView.messagesDataSource else {
            fatalError(MessageKitError.nilMessagesDataSource)
        }

        let message = messagesDataSource.messageForItem(at: indexPath, in: messagesCollectionView)

        switch message.kind {
        case .text, .attributedText:
            if let cell = messagesDataSource.textCell(for: message, at: indexPath, in: messagesCollectionView) {
                return cell
            } else {
                let cell = messagesCollectionView.dequeueReusableCell(TextMessageCell.self, for: indexPath)
                cell.configure(with: message, at: indexPath, and: messagesCollectionView)
                return cell
            }
        case .custom:
          return messagesDataSource.customCell(for: message, at: indexPath, in: messagesCollectionView)
        }
    }

     func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        guard let messagesCollectionView = collectionView as? MessagesCollectionView else {
            fatalError(MessageKitError.notMessagesCollectionView)
        }

        guard let displayDelegate = messagesCollectionView.messagesDisplayDelegate else {
            fatalError(MessageKitError.nilMessagesDisplayDelegate)
        }

        switch kind {
        case UICollectionView.elementKindSectionHeader:
            return displayDelegate.messageHeaderView(for: indexPath, in: messagesCollectionView)
        case UICollectionView.elementKindSectionFooter:
            return displayDelegate.messageFooterView(for: indexPath, in: messagesCollectionView)
        default:
            fatalError(MessageKitError.unrecognizedSectionKind)
        }
    }

    // MARK: - UICollectionViewDelegateFlowLayout

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let messagesFlowLayout = collectionViewLayout as? MessagesCollectionViewFlowLayout else { return .zero }
        return messagesFlowLayout.sizeForItem(at: indexPath)
    }

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {

        guard let messagesCollectionView = collectionView as? MessagesCollectionView else {
            fatalError(MessageKitError.notMessagesCollectionView)
        }
        guard let layoutDelegate = messagesCollectionView.messagesLayoutDelegate else {
            fatalError(MessageKitError.nilMessagesLayoutDelegate)
        }
        if isSectionReservedForTypingIndicator(section) {
            return .zero
        }
        return layoutDelegate.headerViewSize(for: section, in: messagesCollectionView)
    }

//     func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        guard let cell = cell as? TypingIndicatorCell else { return }
//        cell.typingBubble.startAnimating()
//    }

     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard let messagesCollectionView = collectionView as? MessagesCollectionView else {
            fatalError(MessageKitError.notMessagesCollectionView)
        }
        guard let layoutDelegate = messagesCollectionView.messagesLayoutDelegate else {
            fatalError(MessageKitError.nilMessagesLayoutDelegate)
        }
        if isSectionReservedForTypingIndicator(section) {
            return .zero
        }
        return layoutDelegate.footerViewSize(for: section, in: messagesCollectionView)
    }

     func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        guard let messagesDataSource = messagesCollectionView.messagesDataSource else { return false }

        if isSectionReservedForTypingIndicator(indexPath.section) {
            return false
        }

        let message = messagesDataSource.messageForItem(at: indexPath, in: messagesCollectionView)

        switch message.kind {
        case .text, .attributedText:
            selectedIndexPathForMenu = indexPath
            return true
        default:
            return false
        }
    }

     func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        if isSectionReservedForTypingIndicator(indexPath.section) {
            return false
        }
        return (action == NSSelectorFromString("copy:"))
    }

     func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
        guard let messagesDataSource = messagesCollectionView.messagesDataSource else {
            fatalError(MessageKitError.nilMessagesDataSource)
        }
        let pasteBoard = UIPasteboard.general
        let message = messagesDataSource.messageForItem(at: indexPath, in: messagesCollectionView)

        switch message.kind {
        case .text(let text):
            pasteBoard.string = text
        case .attributedText(let attributedText):
            pasteBoard.string = attributedText.string
//        case .photo(let mediaItem):
//            pasteBoard.image = mediaItem.image ?? mediaItem.placeholderImage
        default:
            break
        }
    }

    // MARK: - Helpers
    
    private func addObservers() {
        NotificationCenter.default.addObserver(
            self, selector: #selector(clearMemoryCache), name: UIApplication.didReceiveMemoryWarningNotification, object: nil)
    }
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: UIApplication.didReceiveMemoryWarningNotification, object: nil)
    }
    
    @objc private func clearMemoryCache() {
        MessageStyle.bubbleImageCache.removeAllObjects()
    }

    // MARK: - UIGestureRecognizerDelegate
           
    /// Check Pan Gesture Direction:
     func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let panGesture = gestureRecognizer as? UIPanGestureRecognizer else {
            return false
        }
        let velocity = panGesture.velocity(in: messagesCollectionView)
        return abs(velocity.x) > abs(velocity.y)
    }
}

        // MARK: - UIScrollViewDelegate

extension MessagesViewController: UIScrollViewDelegate{
    
     func scrollViewDidScroll(_ scrollView: UIScrollView) { }
    
     func scrollViewWillBeginDragging(_ scrollView: UIScrollView){ }
    
     func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>){ }
    
     func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool){ }
    
     func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView){ }
    
     func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) { }
    
     func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) { }
    
     func scrollViewDidScrollToTop(_ scrollView: UIScrollView){ }
    
     func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) { }
}

