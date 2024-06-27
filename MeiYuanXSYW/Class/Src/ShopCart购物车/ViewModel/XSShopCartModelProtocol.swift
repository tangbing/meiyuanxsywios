//
//  XSShopCart.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/24.
//

import UIKit

enum XSShopCartType {
    /// 外卖
    case delieve
    /// 团购
    case groupBuy
    /// 私厨
    case privateKitchen
    /// 失效宝贝
    case loseTime
    case shopInfoTop
    /// 超出配送范围
    case outbounds
    /// 去凑单
    case balanceOrder
    /// 优惠信息
    case discountInfo
    /// 大家都在买
    case recommand
}

enum XSShopCartCellState {
    case normal // 正常
    case loseTime /// 已经失效
    case outBounds /// 超过配送范围
}


///// 数据模型继承此协议
protocol XSShopCartModelProtocol {
    var style: XSShopCartType { get }
    var rowHeight: CGFloat { get }
    var hasTopRadius: Bool { get }
    var hasBottomRadius: Bool { get }
    /// 失效状态
    var cellState: XSShopCartCellState { get }
    
    var isSelect: Bool { get set }
    
    var Id: Int { get}
    
}

extension XSShopCartModelProtocol {

    var Id: Int {
        return -1
    }
    
    var cellState: XSShopCartCellState { return .normal }

    
    var hasTopRadius: Bool {
        return false
    }
    var hasBottomRadius: Bool {
        return false
    }
    
}
