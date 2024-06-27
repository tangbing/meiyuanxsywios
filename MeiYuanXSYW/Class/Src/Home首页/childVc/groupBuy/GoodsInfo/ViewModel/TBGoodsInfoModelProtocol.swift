//
//  TBShopInfoModelProtocol.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/16.
//

import Foundation
import UIKit

enum TBGoodsInfoHeaderStyle {
   case picArray
   case killSecond
   case goodsInfoItem
   case ticket
}

///// 数据模型继承此协议
protocol TBShopInfoModelProtocol {
    var style: TBGoodsInfoHeaderStyle { get }
    var rowHeight: CGFloat { get }
    var hasTopRadius: Bool { get }
    var hasBottomRadus: Bool { get }
}

extension TBShopInfoModelProtocol {
    
//    var style: pinLocationStyle { return .merchMore }
//    var rowHeight: CGFloat { return 0 }
    
    
    var hasTopRadius: Bool {
        return false
    }
    var hasBottomRadus: Bool {
        return false
    }
    
}
