//
//  XSShopCartOutBoundsModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/25.
//

import UIKit

class XSShopCartOutBoundsModel: XSShopCartModelProtocol {
    var cellState: XSShopCartCellState {
        return .outBounds
    }

    var isSelect = false
        

    var caculateMoreAmt: OrderCarVOList
    
    var style: XSShopCartType = .outbounds

    var rowHeight: CGFloat {
        return 64
    }

    var hasTopRadius: Bool
    var hasBottomRadius: Bool

    init(caculateMoreAmt: OrderCarVOList,hasTopRadius: Bool = false, hasBottomRadius: Bool = false) {
        self.hasTopRadius = hasTopRadius
        self.hasBottomRadius = hasBottomRadius
        self.caculateMoreAmt = caculateMoreAmt
    }
    
}

