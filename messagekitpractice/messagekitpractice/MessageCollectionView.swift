import Foundation
import UIKit

class MessagesCollectionView: UICollectionView {

    // MARK: - Properties

    weak var messagesDataSource: MessagesDataSource?

    weak var messagesDisplayDelegate: MessagesDisplayDelegate?

    weak var messagesLayoutDelegate: MessagesLayoutDelegate?

     weak var messageCellDelegate: MessageCellDelegate?

     var isTypingIndicatorHidden: Bool {
        return messagesCollectionViewFlowLayout.isTypingIndicatorViewHidden
    }

    /// Display the date of message by swiping left.
    /// The default value of this property is `false`.
    internal var showMessageTimestampOnSwipeLeft: Bool = false

    private var indexPathForLastItem: IndexPath? {
        guard numberOfSections > 0 else { return nil }
        
        for offset in 1...numberOfSections {
            let section = numberOfSections - offset
            let lastItem = numberOfItems(inSection: section) - 1
            if lastItem >= 0 {
                return IndexPath(item: lastItem, section: section)
            }
        }
        return nil
    }

     var messagesCollectionViewFlowLayout: MessagesCollectionViewFlowLayout {
        guard let layout = collectionViewLayout as? MessagesCollectionViewFlowLayout else {
            fatalError(MessageKitError.layoutUsedOnForeignType)
        }
        return layout
    }

    // MARK: - Initializers

    public override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        backgroundColor = .collectionViewBackground
        registerReusableViews()
        setupGestureRecognizers()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(frame: .zero, collectionViewLayout: MessagesCollectionViewFlowLayout())
    }

    public convenience init() {
        self.init(frame: .zero, collectionViewLayout: MessagesCollectionViewFlowLayout())
    }

    // MARK: - Methods
    
    private func registerReusableViews() {
        register(TextMessageCell.self)
        register(MessageReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader)
        register(MessageReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter)
    }
    
    private func setupGestureRecognizers() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        tapGesture.delaysTouchesBegan = true
        addGestureRecognizer(tapGesture)
    }
    
    @objc
     func handleTapGesture(_ gesture: UIGestureRecognizer) {
        guard gesture.state == .ended else { return }
        
        let touchLocation = gesture.location(in: self)
        guard let indexPath = indexPathForItem(at: touchLocation) else { return }
        
        let cell = cellForItem(at: indexPath) as? MessageCollectionViewCell
        cell?.handleTapGesture(gesture)
    }

    // NOTE: It's possible for small content size this wouldn't work - https://github.com/MessageKit/MessageKit/issues/725
    public func scrollToLastItem(at pos: UICollectionView.ScrollPosition = .bottom, animated: Bool = true) {
        guard let indexPath = indexPathForLastItem else { return }
        
        scrollToItem(at: indexPath, at: pos, animated: animated)
    }
    
    // NOTE: This method seems to cause crash in certain cases - https://github.com/MessageKit/MessageKit/issues/725
    // Could try using `scrollToLastItem` above
    @available(*, deprecated, message: "Scroll to bottom by using scrollToLastItem(:) instead", renamed: "scrollToLastItem")
    public func scrollToBottom(animated: Bool = false) {
        performBatchUpdates(nil) { [weak self] _ in
            guard let self = self else { return }
            let collectionViewContentHeight = self.collectionViewLayout.collectionViewContentSize.height
          self.scrollRectToVisible(CGRect(x: 0.0, y: collectionViewContentHeight - 1.0, width: 1.0, height: 1.0), animated: animated)
        }
    }
    
    public func reloadDataAndKeepOffset() {
        // stop scrolling
        setContentOffset(contentOffset, animated: false)
        
        // calculate the offset and reloadData
        let beforeContentSize = contentSize
        reloadData()
        layoutIfNeeded()
        let afterContentSize = contentSize
        
        // reset the contentOffset after data is updated
        let newOffset = CGPoint(
            x: contentOffset.x + (afterContentSize.width - beforeContentSize.width),
            y: contentOffset.y + (afterContentSize.height - beforeContentSize.height))
        setContentOffset(newOffset, animated: false)
    }

    // MARK: - View Register/Dequeue

    /// Registers a particular cell using its reuse-identifier
    public func register<T: UICollectionViewCell>(_ cellClass: T.Type) {
        register(cellClass, forCellWithReuseIdentifier: String(describing: T.self))
    }

    /// Registers a reusable view for a specific SectionKind
    public func register<T: UICollectionReusableView>(_ reusableViewClass: T.Type, forSupplementaryViewOfKind kind: String) {
        register(reusableViewClass,
                 forSupplementaryViewOfKind: kind,
                 withReuseIdentifier: String(describing: T.self))
    }
    
    /// Registers a nib with reusable view for a specific SectionKind
    public func register<T: UICollectionReusableView>(_ nib: UINib? = UINib(nibName: String(describing: T.self), bundle: nil), headerFooterClassOfNib headerFooterClass: T.Type, forSupplementaryViewOfKind kind: String) {
        register(nib,
                 forSupplementaryViewOfKind: kind,
                 withReuseIdentifier: String(describing: T.self))
    }

    /// Generically dequeues a cell of the correct type allowing you to avoid scattering your code with guard-let-else-fatal
    public func dequeueReusableCell<T: UICollectionViewCell>(_ cellClass: T.Type, for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: String(describing: T.self), for: indexPath) as? T else {
            fatalError("Unable to dequeue \(String(describing: cellClass)) with reuseId of \(String(describing: T.self))")
        }
        return cell
    }

    /// Generically dequeues a header of the correct type allowing you to avoid scattering your code with guard-let-else-fatal
    public func dequeueReusableHeaderView<T: UICollectionReusableView>(_ viewClass: T.Type, for indexPath: IndexPath) -> T {
        let view = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: String(describing: T.self), for: indexPath)
        guard let viewType = view as? T else {
            fatalError("Unable to dequeue \(String(describing: viewClass)) with reuseId of \(String(describing: T.self))")
        }
        return viewType
    }

    /// Generically dequeues a footer of the correct type allowing you to avoid scattering your code with guard-let-else-fatal
    public func dequeueReusableFooterView<T: UICollectionReusableView>(_ viewClass: T.Type, for indexPath: IndexPath) -> T {
        let view = dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: T.self), for: indexPath)
        guard let viewType = view as? T else {
            fatalError("Unable to dequeue \(String(describing: viewClass)) with reuseId of \(String(describing: T.self))")
        }
        return viewType
    }

}

