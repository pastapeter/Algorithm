//
//  NSAttributedString+Extension.swift
//  messagekitpractice
//
//  Created by Jung peter on 4/11/23.
//

import Foundation
import UIKit

extension NSAttributedString {

    func width(considering height: CGFloat) -> CGFloat {

        let size = self.size(consideringHeight: height)
        return size.width
        
    }
    
    func height(considering width: CGFloat) -> CGFloat {

        let size = self.size(consideringWidth: width)
        return size.height
        
    }
    
    func size(consideringHeight height: CGFloat) -> CGSize {
        
        let constraintBox = CGSize(width: .greatestFiniteMagnitude, height: height)
        return self.size(considering: constraintBox)
        
    }
    
    func size(consideringWidth width: CGFloat) -> CGSize {
        
        let constraintBox = CGSize(width: width, height: .greatestFiniteMagnitude)
        return self.size(considering: constraintBox)
        
    }
    
    func size(considering size: CGSize) -> CGSize {
        
        let rect = self.boundingRect(with: size, options: [.usesLineFragmentOrigin, .usesFontLeading], context: nil)
        return rect.size
        
    }
}
