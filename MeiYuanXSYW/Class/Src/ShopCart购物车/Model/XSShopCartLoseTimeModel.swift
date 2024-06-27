//
//  XSShopCartLoseTimeModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/24.
//

import UIKit


class XSShopCartLoseTimeModel: XSShopCartModelProtocol {
    var cellState: XSShopCartCellState
    var isSelect = false
    
    var style: XSShopCartType = .loseTime
    
    var rowHeight: CGFloat {
        let itemW:CGFloat = (screenWidth - 30) * 0.5
        let itemH:CGFloat = itemW * 3 / 4 + 83
        return itemH
    }
    init(cellState: XSShopCartCellState) {
        self.cellState = cellState
    }
    
}
