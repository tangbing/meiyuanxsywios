//
//  XSDiscoverStudySpaceModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/2.
//

import UIKit

class XSDiscoverStudySpaceModel: XSDiscoverModelProtocol {
    
    var style: XSDiscoverType = .studySpace
    
    var rowHeight: CGFloat {
        return 97
    }
    
    var hasTopRadius: Bool
    var hasBottomRadius: Bool
    
    init(hasTopRadius: Bool = false, hasBottomRadius: Bool = false) {
        self.hasTopRadius = hasTopRadius
        self.hasBottomRadius = hasBottomRadius
    }
    
}
