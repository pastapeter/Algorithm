//
//  AccessoryPosition.swift
//  messagekitpractice
//
//  Created by Jung peter on 4/11/23.
//

import Foundation

public enum AccessoryPosition {
    
    /// Aligns the `AccessoryView`'s top edge to the cell's top edge.
    case cellTop
    
    /// Aligns the `AccessoryView`'s top edge to the `messageTopLabel`'s top edge.
    case messageLabelTop
    
    /// Aligns the `AccessoryView`'s top edge to the `MessageContainerView`'s top edge.
    case messageTop
    
    /// Aligns the `AccessoryView` center to the `MessageContainerView` center.
    case messageCenter
    
    /// Aligns the `AccessoryView`'s bottom edge to the `MessageContainerView`s bottom edge.
    case messageBottom
    
    /// Aligns the `AccessoryView`'s bottom edge to the cell's bottom edge.
    case cellBottom
}
