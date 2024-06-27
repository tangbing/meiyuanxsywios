//
//  XSStudySpaceDetailProtocol.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/6.
//

import UIKit

enum XSStudySapceDetailStyle {
 case info
 case content
 case wait
 case merchInfo
}

/// 数据模型继承此协议
protocol XSStudySpaceDetailProtocol {
    var style: XSStudySapceDetailStyle { get }
    var rowHeight: CGFloat { get }
    var hasTopRadius: Bool { get }
    var hasBottomRadius: Bool { get }
}

extension XSStudySpaceDetailProtocol {
    
//    var style: pinLocationStyle { return .merchMore }
//    var rowHeight: CGFloat { return 0 }
    
    
    var hasTopRadius: Bool {
        return false
    }
    var hasBottomRadus: Bool {
        return false
    }
    
}
