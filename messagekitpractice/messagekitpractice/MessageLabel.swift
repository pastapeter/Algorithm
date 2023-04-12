//
//  MessageLabel.swift
//  messagekitpractice
//
//  Created by Jung peter on 4/5/23.
//

import Foundation
import UIKit

class MessageLabel: UILabel {

    // MARK: - Private Properties

    private lazy var layoutManager: NSLayoutManager = {
        let layoutManager = NSLayoutManager()
        layoutManager.addTextContainer(self.textContainer)
        return layoutManager
    }()

    private lazy var textContainer: NSTextContainer = {
        let textContainer = NSTextContainer()
        textContainer.lineFragmentPadding = 0
        textContainer.maximumNumberOfLines = self.numberOfLines
        textContainer.lineBreakMode = self.lineBreakMode
        textContainer.size = self.bounds.size
        return textContainer
    }()

    private lazy var textStorage: NSTextStorage = {
        let textStorage = NSTextStorage()
        textStorage.addLayoutManager(self.layoutManager)
        return textStorage
    }()

    internal lazy var rangesForDetectors: [DetectorType: [(NSRange, MessageTextCheckingType)]] = [:]
    
    private var isConfiguring: Bool = false

    // MARK: -  Properties

     weak var delegate: MessageLabelDelegate?

     var enabledDetectors: [DetectorType] = [] {
        didSet {
            setTextStorage(attributedText, shouldParse: true)
        }
    }

     override var attributedText: NSAttributedString? {
        didSet {
            setTextStorage(attributedText, shouldParse: true)
        }
    }

     override var text: String? {
        didSet {
            setTextStorage(attributedText, shouldParse: true)
        }
    }

     override var font: UIFont! {
        didSet {
            setTextStorage(attributedText, shouldParse: false)
        }
    }

     override var textColor: UIColor! {
        didSet {
            setTextStorage(attributedText, shouldParse: false)
        }
    }

     override var lineBreakMode: NSLineBreakMode {
        didSet {
            textContainer.lineBreakMode = lineBreakMode
            if !isConfiguring { setNeedsDisplay() }
        }
    }

     override var numberOfLines: Int {
        didSet {
            textContainer.maximumNumberOfLines = numberOfLines
            if !isConfiguring { setNeedsDisplay() }
        }
    }

     override var textAlignment: NSTextAlignment {
        didSet {
            setTextStorage(attributedText, shouldParse: false)
        }
    }

     var textInsets: UIEdgeInsets = .zero {
        didSet {
            if !isConfiguring { setNeedsDisplay() }
        }
    }

     override var intrinsicContentSize: CGSize {
        var size = super.intrinsicContentSize
        size.width += textInsets.horizontal
        size.height += textInsets.vertical
        return size
    }
    
    internal var messageLabelFont: UIFont?

    private var attributesNeedUpdate = false

     static var defaultAttributes: [NSAttributedString.Key: Any] = {
        return [
            NSAttributedString.Key.foregroundColor: UIColor.darkText,
            NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue,
            NSAttributedString.Key.underlineColor: UIColor.darkText
        ]
    }()

     internal(set) var addressAttributes: [NSAttributedString.Key: Any] = defaultAttributes

     internal(set) var dateAttributes: [NSAttributedString.Key: Any] = defaultAttributes

     internal(set) var phoneNumberAttributes: [NSAttributedString.Key: Any] = defaultAttributes

     internal(set) var urlAttributes: [NSAttributedString.Key: Any] = defaultAttributes
    
     internal(set) var transitInformationAttributes: [NSAttributedString.Key: Any] = defaultAttributes
    
     internal(set) var hashtagAttributes: [NSAttributedString.Key: Any] = defaultAttributes
    
     internal(set) var mentionAttributes: [NSAttributedString.Key: Any] = defaultAttributes

     internal(set) var customAttributes: [NSRegularExpression: [NSAttributedString.Key: Any]] = [:]

     func setAttributes(_ attributes: [NSAttributedString.Key: Any], detector: DetectorType) {
        switch detector {
        case .phoneNumber:
            phoneNumberAttributes = attributes
        case .address:
            addressAttributes = attributes
        case .date:
            dateAttributes = attributes
        case .url:
            urlAttributes = attributes
        case .transitInformation:
            transitInformationAttributes = attributes
        case .mention:
            mentionAttributes = attributes
        case .hashtag:
            hashtagAttributes = attributes
        case .custom(let regex):
            customAttributes[regex] = attributes
        }
        if isConfiguring {
            attributesNeedUpdate = true
        } else {
            updateAttributes(for: [detector])
        }
    }

    // MARK: - Initializers

     override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

     required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    // MARK: -  Methods

     override func drawText(in rect: CGRect) {

        let insetRect = rect.inset(by: textInsets)
        textContainer.size = CGSize(width: insetRect.width, height: rect.height)

        let origin = insetRect.origin
        let range = layoutManager.glyphRange(for: textContainer)

        layoutManager.drawBackground(forGlyphRange: range, at: origin)
        layoutManager.drawGlyphs(forGlyphRange: range, at: origin)
    }

    // MARK: -  Methods
    
    func configure(block: () -> Void) {
        isConfiguring = true
        block()
        if attributesNeedUpdate {
            updateAttributes(for: enabledDetectors)
        }
        attributesNeedUpdate = false
        isConfiguring = false
        setNeedsDisplay()
    }

    // MARK: - Private Methods

    private func setTextStorage(_ newText: NSAttributedString?, shouldParse: Bool) {

        guard let newText = newText, newText.length > 0 else {
            textStorage.setAttributedString(NSAttributedString())
            setNeedsDisplay()
            return
        }
        
        let style = paragraphStyle(for: newText)
        let range = NSRange(location: 0, length: newText.length)
        
        let mutableText = NSMutableAttributedString(attributedString: newText)
        mutableText.addAttribute(.paragraphStyle, value: style, range: range)
        
        if shouldParse {
            rangesForDetectors.removeAll()
            let results = parse(text: mutableText)
            setRangesForDetectors(in: results)
        }
        
        for (detector, rangeTuples) in rangesForDetectors {
            if enabledDetectors.contains(detector) {
                let attributes = detectorAttributes(for: detector)
                rangeTuples.forEach { (range, _) in
                    mutableText.addAttributes(attributes, range: range)
                }
            }
        }

        let modifiedText = NSAttributedString(attributedString: mutableText)
        textStorage.setAttributedString(modifiedText)

        if !isConfiguring { setNeedsDisplay() }

    }
    
    private func paragraphStyle(for text: NSAttributedString) -> NSParagraphStyle {
        guard text.length > 0 else { return NSParagraphStyle() }
        
        var range = NSRange(location: 0, length: text.length)
        let existingStyle = text.attribute(.paragraphStyle, at: 0, effectiveRange: &range) as? NSMutableParagraphStyle
        let style = existingStyle ?? NSMutableParagraphStyle()
        
        style.lineBreakMode = lineBreakMode
        style.alignment = textAlignment
        
        return style
    }

    private func updateAttributes(for detectors: [DetectorType]) {

        guard let attributedText = attributedText, attributedText.length > 0 else { return }
        let mutableAttributedString = NSMutableAttributedString(attributedString: attributedText)

        for detector in detectors {
            guard let rangeTuples = rangesForDetectors[detector] else { continue }

            for (range, _)  in rangeTuples {
                // This will enable us to attribute it with our own styles, since `UILabel` does not provide link attribute overrides like `UITextView` does
                if detector.textCheckingType == .link {
                    mutableAttributedString.removeAttribute(NSAttributedString.Key.link, range: range)
                }

                let attributes = detectorAttributes(for: detector)
                mutableAttributedString.addAttributes(attributes, range: range)
            }

            let updatedString = NSAttributedString(attributedString: mutableAttributedString)
            textStorage.setAttributedString(updatedString)
        }
    }

    private func detectorAttributes(for detectorType: DetectorType) -> [NSAttributedString.Key: Any] {

        switch detectorType {
        case .address:
            return addressAttributes
        case .date:
            return dateAttributes
        case .phoneNumber:
            return phoneNumberAttributes
        case .url:
            return urlAttributes
        case .transitInformation:
            return transitInformationAttributes
        case .mention:
            return mentionAttributes
        case .hashtag:
            return hashtagAttributes
        case .custom(let regex):
            return customAttributes[regex] ?? MessageLabel.defaultAttributes
        }

    }

    private func detectorAttributes(for checkingResultType: NSTextCheckingResult.CheckingType) -> [NSAttributedString.Key: Any] {
        switch checkingResultType {
        case .address:
            return addressAttributes
        case .date:
            return dateAttributes
        case .phoneNumber:
            return phoneNumberAttributes
        case .link:
            return urlAttributes
        case .transitInformation:
            return transitInformationAttributes
        default:
            fatalError(MessageKitError.unrecognizedCheckingResult)
        }
    }
    
    private func setupView() {
        numberOfLines = 0
        lineBreakMode = .byWordWrapping
    }

    // MARK: - Parsing Text

    private func parse(text: NSAttributedString) -> [NSTextCheckingResult] {
        guard enabledDetectors.isEmpty == false else { return [] }
        let range = NSRange(location: 0, length: text.length)
        var matches = [NSTextCheckingResult]()

        // Get matches of all .custom DetectorType and add it to matches array
        let regexs = enabledDetectors
            .filter { $0.isCustom }
            .map { parseForMatches(with: $0, in: text, for: range) }
            .joined()
        matches.append(contentsOf: regexs)

        // Get all Checking Types of detectors, except for .custom because they contain their own regex
        let detectorCheckingTypes = enabledDetectors
            .filter { !$0.isCustom }
            .reduce(0) { $0 | $1.textCheckingType.rawValue }
        if detectorCheckingTypes > 0, let detector = try? NSDataDetector(types: detectorCheckingTypes) {
            let detectorMatches = detector.matches(in: text.string, options: [], range: range)
            matches.append(contentsOf: detectorMatches)
        }

        guard enabledDetectors.contains(.url) else {
            return matches
        }

        // Enumerate NSAttributedString NSLinks and append ranges
        var results: [NSTextCheckingResult] = matches

        text.enumerateAttribute(NSAttributedString.Key.link, in: range, options: []) { value, range, _ in
            guard let url = value as? URL else { return }
            let result = NSTextCheckingResult.linkCheckingResult(range: range, url: url)
            results.append(result)
        }

        return results
    }

    private func parseForMatches(with detector: DetectorType, in text: NSAttributedString, for range: NSRange) -> [NSTextCheckingResult] {
        switch detector {
        case .custom(let regex):
            return regex.matches(in: text.string, options: [], range: range)
        default:
            fatalError("You must pass a .custom DetectorType")
        }
    }

    private func setRangesForDetectors(in checkingResults: [NSTextCheckingResult]) {

        guard checkingResults.isEmpty == false else { return }
        
        for result in checkingResults {

            switch result.resultType {
            case .date:
                var ranges = rangesForDetectors[.date] ?? []
                let tuple: (NSRange, MessageTextCheckingType) = (result.range, .date(result.date))
                ranges.append(tuple)
                rangesForDetectors.updateValue(ranges, forKey: .date)
           
            case .transitInformation:
                var ranges = rangesForDetectors[.transitInformation] ?? []
                let tuple: (NSRange, MessageTextCheckingType) = (result.range, .transitInfoComponents(result.components))
                ranges.append(tuple)
                rangesForDetectors.updateValue(ranges, forKey: .transitInformation)
//            case .regularExpression:
//                guard let text = text, let regex = result.regularExpression, let range = Range(result.range, in: text) else { return }
//                let detector = DetectorType.custom(regex)
//                var ranges = rangesForDetectors[detector] ?? []
//                let tuple: (NSRange, MessageTextCheckingType) = (result.range, .custom(pattern: regex.pattern, match: String(text[range])))
//                ranges.append(tuple)
//                rangesForDetectors.updateValue(ranges, forKey: detector)
            default:
                fatalError("Received an unrecognized NSTextCheckingResult.CheckingType")
            }

        }

    }

    // MARK: - Gesture Handling

    private func stringIndex(at location: CGPoint) -> Int? {
        guard textStorage.length > 0 else { return nil }

        var location = location

        location.x -= textInsets.left
        location.y -= textInsets.top

        let index = layoutManager.glyphIndex(for: location, in: textContainer)

        let lineRect = layoutManager.lineFragmentUsedRect(forGlyphAt: index, effectiveRange: nil)
        
        var characterIndex: Int?
        
        if lineRect.contains(location) {
            characterIndex = layoutManager.characterIndexForGlyph(at: index)
        }
        
        return characterIndex

    }

   func handleGesture(_ touchLocation: CGPoint) -> Bool {

        guard let index = stringIndex(at: touchLocation) else { return false }

        for (detectorType, ranges) in rangesForDetectors {
            for (range, value) in ranges {
                if range.contains(index) {
                    handleGesture(for: detectorType, value: value)
                    return true
                }
            }
        }
        return false
    }

    // swiftlint:disable cyclomatic_complexity
    private func handleGesture(for detectorType: DetectorType, value: MessageTextCheckingType) {
        
        switch value {
        case let .date(date):
            guard let date = date else { return }
            handleDate(date)
        case let .transitInfoComponents(transitInformation):
            var transformedTransitInformation = [String: String]()
            guard let transitInformation = transitInformation else { return }
            transitInformation.forEach { (key, value) in
                transformedTransitInformation[key.rawValue] = value
            }
            handleTransitInformation(transformedTransitInformation)
        }
    }
    
    private func handleDate(_ date: Date) {
        delegate?.didSelectDate(date)
    }
    
    private func handleURL(_ url: URL) {
        delegate?.didSelectURL(url)
    }
    
    private func handleTransitInformation(_ components: [String: String]) {
        delegate?.didSelectTransitInformation(components)
    }

    private func handleHashtag(_ hashtag: String) {
        delegate?.didSelectHashtag(hashtag)
    }

    private func handleMention(_ mention: String) {
        delegate?.didSelectMention(mention)
    }

}

internal enum MessageTextCheckingType {
    case date(Date?)
    case transitInfoComponents([NSTextCheckingKey: String]?)
}
