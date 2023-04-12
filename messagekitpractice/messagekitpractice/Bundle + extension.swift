//
//  Bundle + extension.swift
//  messagekitpractice
//
//  Created by Jung peter on 4/5/23.
//

import Foundation

internal extension Bundle {
    #if IS_SPM
    static var messageKitAssetBundle: Bundle = Bundle.module
    #else
    static var messageKitAssetBundle: Bundle {
        return Bundle(for: MessagesViewController.self)
    }
    #endif
}
