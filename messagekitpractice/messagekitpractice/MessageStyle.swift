//
//  MessageStyle.swift
//  messagekitpractice
//
//  Created by Jung peter on 4/5/23.
//

import Foundation
import UIKit

public enum MessageStyle {

    // MARK: - TailCorner

    public enum TailCorner: String {

        case topLeft
        case bottomLeft
        case topRight
        case bottomRight

        internal var imageOrientation: UIImage.Orientation {
            switch self {
            case .bottomRight: return .up
            case .bottomLeft: return .upMirrored
            case .topLeft: return .down
            case .topRight: return .downMirrored
            }
        }
    }

    // MARK: - TailStyle

    public enum TailStyle {

        case curved
        case pointedEdge

        internal var imageNameSuffix: String {
            switch self {
            case .curved:
                return "_tail_v2"
            case .pointedEdge:
                return "_tail_v1"
            }
        }
    }

    // MARK: - MessageStyle

    case none
    case bubble
    case bubbleOutline(UIColor)
    case bubbleTail(TailCorner, TailStyle)
    case bubbleTailOutline(UIColor, TailCorner, TailStyle)
//    case custom((MessageContainerView) -> Void)

    // MARK: - Public

    public var image: UIImage? {
        if let imageCacheKey = imageCacheKey, let cachedImage = MessageStyle.bubbleImageCache.object(forKey: imageCacheKey as NSString) {
            return cachedImage
        }

        guard
            let imageName = imageName,
            var image = UIImage(named: imageName, in: Bundle.messageKitAssetBundle, compatibleWith: nil)
        else {
            return nil
        }

        switch self {
//        case .custom:
//          return nil
        case .none:
            return nil
        case .bubble, .bubbleOutline:
            break
        case .bubbleTail(let corner, _), .bubbleTailOutline(_, let corner, _):
            guard let cgImage = image.cgImage else { return nil }
            image = UIImage(cgImage: cgImage, scale: image.scale, orientation: corner.imageOrientation)
        }
        
        let stretchedImage = stretch(image)
        if let imageCacheKey = imageCacheKey {
            MessageStyle.bubbleImageCache.setObject(stretchedImage, forKey: imageCacheKey as NSString)
        }
        return stretchedImage
    }

    // MARK: - Internal
    
    internal static let bubbleImageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.name = "com.messagekit.MessageKit.bubbleImageCache"
        return cache
    }()
    
    // MARK: - Private
    
    private var imageCacheKey: String? {
        guard let imageName = imageName else { return nil }
        
        switch self {
        case .bubble, .bubbleOutline:
            return imageName
        case .bubbleTail(let corner, _), .bubbleTailOutline(_, let corner, _):
            return imageName + "_" + corner.rawValue
        default:
            return nil
        }
    }

    private var imageName: String? {
        switch self {
        case .bubble:
            return "bubble_full"
        case .bubbleOutline:
            return "bubble_outlined"
        case .bubbleTail(_, let tailStyle):
            return "bubble_full" + tailStyle.imageNameSuffix
        case .bubbleTailOutline(_, _, let tailStyle):
            return "bubble_outlined" + tailStyle.imageNameSuffix
        case .none:
            return nil
        }
    }

    private func stretch(_ image: UIImage) -> UIImage {
        let center = CGPoint(x: image.size.width / 2, y: image.size.height / 2)
        let capInsets = UIEdgeInsets(top: center.y, left: center.x, bottom: center.y, right: center.x)
        return image.resizableImage(withCapInsets: capInsets, resizingMode: .stretch)
    }
}
