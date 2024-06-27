//
//  XSShopCartDelieveModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/24.
//

import UIKit

class XSShopCartDelieveModel: XSShopCartModelProtocol {
    
    
    
    var Id: Int {
        return orderShoppingTrolleyVOList.id
    }
    
    var cellState: XSShopCartCellState
    
    var orderShoppingTrolleyVOList: XSShopCartTrolleyVOList
    
    var isSelect = false
    

    // 是否是选规格
    var hasSelectStandard: Bool
    

    var style: XSShopCartType = .delieve
    
    var rowHeight: CGFloat {
        return UITableView.automaticDimension
    }
    
    var hasTopRadius: Bool
    var hasBottomRadius: Bool
    

    init(cellState: XSShopCartCellState,
         orderShoppingTrolleyVOList: XSShopCartTrolleyVOList,
         hasTopRadius: Bool = false, hasBottomRadius: Bool = false, hasSelectStandard: Bool = false) {
        self.cellState = cellState
        self.hasTopRadius = hasTopRadius
        self.hasBottomRadius = hasBottomRadius
        self.hasSelectStandard = hasSelectStandard
        self.orderShoppingTrolleyVOList = orderShoppingTrolleyVOList
    }
    
}
