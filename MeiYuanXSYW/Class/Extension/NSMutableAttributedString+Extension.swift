//
//  NSMutableAttributedString+Extension.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/26.
//

import UIKit

extension NSMutableAttributedString {
    
    func setMultAttributes(elements: [(str :String, attr : [NSAttributedString.Key : Any])]) -> NSMutableAttributedString? {
        
//        let textAttribute = Self.init(string: text)
        
        for element in elements {
            
            guard let elementRange = string.range(of: element.str)  else {
                return nil
            }
            
            let location = string.distance(from: string.startIndex, to: elementRange.lowerBound)
            let length = string.distance(from: elementRange.lowerBound, to: elementRange.upperBound)
            
            self.setAttributes(element.attr, range: NSRange(location: location, length: length))
                        
        }
        return self
    }
    
    
    convenience init?(elements: [(str :String, attr : [NSAttributedString.Key : Any])]) {
        guard elements.count > 0 else {
            return nil
        }
        
        let allString : String = elements.reduce("") { (res, ele) ->String in
            return res+ele.str
        }

        self.init(string: allString)
        for ele in elements {
            let eleStr = ele.str
            let range : Range = allString.range(of: eleStr)!
            let nsRange : NSRange = NSRange(range, in: allString)
            self.addAttributes(ele.attr, range: nsRange)
        }
        
    }
    
}



