//
//  CellSizeCalculator.swift
//  messagekitpractice
//
//  Created by Jung peter on 4/5/23.
//

import Foundation
import UIKit

/// An object is responsible for
/// sizing and configuring cells for given `IndexPath`s.
 class CellSizeCalculator {

    /// The layout object for which the cell size calculator is used.
    public weak var layout: UICollectionViewFlowLayout?

    /// Used to configure the layout attributes for a given cell.
    ///
    /// - Parameters:
    /// - attributes: The attributes of the cell.
    /// The default does nothing
    open func configure(attributes: UICollectionViewLayoutAttributes) {}

    /// Used to size an item at a given `IndexPath`.
    ///
    /// - Parameters:
    /// - indexPath: The `IndexPath` of the item to be displayed.
    /// The default return .zero
    open func sizeForItem(at indexPath: IndexPath) -> CGSize { return .zero }
    
    public init() {}

}
