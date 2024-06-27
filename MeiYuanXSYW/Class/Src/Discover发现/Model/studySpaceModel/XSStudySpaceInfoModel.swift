//
//  XSStudySpaceInfoModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/6.
//

import UIKit

class XSStudySpaceInfoModel: XSStudySpaceDetailProtocol {

    var style: XSStudySapceDetailStyle = .info
    
    var rowHeight: CGFloat {
        return UITableView.automaticDimension
    }
    
    var hasTopRadius: Bool
    var hasBottomRadius: Bool
    
    init(hasTopRadius: Bool = false, hasBottomRadius: Bool = false) {
        self.hasTopRadius = hasTopRadius
        self.hasBottomRadius = hasBottomRadius
    }
}
