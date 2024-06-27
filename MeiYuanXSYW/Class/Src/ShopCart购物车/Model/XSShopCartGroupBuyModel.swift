//
//  XSShopCartGroupBuyModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/24.
//

import UIKit

class XSShopCartGroupBuyModel: XSShopCartModelProtocol {
  
    
    var cellState: XSShopCartCellState
    
    var Id: Int {
        return orderShoppingTrolleyVOList.id
    }
    
    var isSelect = false
    
    var orderShoppingTrolleyVOList: XSShopCartTrolleyVOList

    var style: XSShopCartType = .groupBuy
    
    var rowHeight: CGFloat {
      
        return UITableView.automaticDimension
    }
    
    
    var hasTopRadius: Bool
    var hasBottomRadius: Bool
    

    init(cellState: XSShopCartCellState,
        orderShoppingTrolleyVOList: XSShopCartTrolleyVOList,
         hasTopRadius: Bool = false, hasBottomRadius: Bool = false) {
        self.cellState = cellState
        self.hasTopRadius = hasTopRadius
        self.hasBottomRadius = hasBottomRadius
        self.orderShoppingTrolleyVOList = orderShoppingTrolleyVOList
    }
    
}
