//
//  XSStudySpaceWaitModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/6.
//

import UIKit

class XSStudySpaceWaitModel: XSStudySpaceDetailProtocol {

    var style: XSStudySapceDetailStyle = .wait
    
    var rowHeight: CGFloat {
        return 93
    }
    
    var hasTopRadius: Bool
    var hasBottomRadius: Bool
    
    init(hasTopRadius: Bool = false, hasBottomRadius: Bool = false) {
        self.hasTopRadius = hasTopRadius
        self.hasBottomRadius = hasBottomRadius
    }
}
