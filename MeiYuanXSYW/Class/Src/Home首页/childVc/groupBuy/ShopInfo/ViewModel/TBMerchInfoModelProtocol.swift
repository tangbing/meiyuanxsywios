//
//  TBMerchInfoModelSection.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/4.
//

import Foundation
import UIKit
import AVFoundation


/// 数据模型继承此协议
protocol TBMerchInfoModelProtocol {
    var style: pinLocationStyle { get }
    var rowHeight: CGFloat { get }
    var rowCommentHeight: CGFloat { get }
    var hasTopRadius: Bool { get }
    var hasBottomRadus: Bool { get }
}

extension TBMerchInfoModelProtocol {
    
//    var style: pinLocationStyle { return .merchMore }
//    var rowHeight: CGFloat { return 0 }
    
    var rowCommentHeight: CGFloat {
        return 0
    }
    
    var hasTopRadius: Bool {
        return false
    }
    var hasBottomRadus: Bool {
        return false
    }
    
}

