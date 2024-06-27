//
//  XSStudySpaceMerchInfoModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/6.
//

import UIKit

class XSStudySpaceMerchInfoModel: XSStudySpaceDetailProtocol {

    var style: XSStudySapceDetailStyle = .merchInfo
    
    var rowHeight: CGFloat {
        return 90
    }
    
    var hasTopRadius: Bool
    var hasBottomRadius: Bool
    
    init(hasTopRadius: Bool = false, hasBottomRadius: Bool = false) {
        self.hasTopRadius = hasTopRadius
        self.hasBottomRadius = hasBottomRadius
    }
    
}
