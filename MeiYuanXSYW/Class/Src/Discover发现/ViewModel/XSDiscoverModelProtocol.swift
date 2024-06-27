//
//  XSDiscoverModelProtocol.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/2.
//

import UIKit

enum XSDiscoverType {
    /// 吃货研究所
    case studySpace
    /// 吃货推荐
    case recommand
}

protocol XSDiscoverModelProtocol {
    var style: XSDiscoverType { get }
    var rowHeight: CGFloat { get }
    var hasTopRadius: Bool { get }
    var hasBottomRadius: Bool { get }
}

extension XSDiscoverModelProtocol {

    
    var hasTopRadius: Bool {
        return false
    }
    var hasBottomRadius: Bool {
        return false
    }
    
}
