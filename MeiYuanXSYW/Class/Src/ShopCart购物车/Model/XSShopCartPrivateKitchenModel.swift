//
//  XSShopCartPrivateKitchenModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/24.
//

import UIKit

class XSShopCartPrivateKitchenModel: XSShopCartModelProtocol {
    var isSelect = false
    
    var Id: Int {
        return orderShoppingTrolleyVOList.id
    }

    var orderShoppingTrolleyVOList: XSShopCartTrolleyVOList

    var style: XSShopCartType = .privateKitchen
    var cellState: XSShopCartCellState
    
    var rowHeight: CGFloat {
     
        return 110
    }
    var hasTopRadius: Bool
    var hasBottomRadius: Bool
    
    var hasSelectRule: Bool
    var hasTicket: Bool
    

    init(cellState: XSShopCartCellState,
         orderShoppingTrolleyVOList: XSShopCartTrolleyVOList,
         hasTopRadius: Bool = false, hasBottomRadius: Bool = false, hasSelectRule: Bool = false, hasTicket: Bool = true) {
        self.cellState = cellState
        self.hasTopRadius = hasTopRadius
        self.hasBottomRadius = hasBottomRadius
        
        self.hasSelectRule = hasSelectRule
        self.hasTicket = hasTicket

        self.orderShoppingTrolleyVOList = orderShoppingTrolleyVOList
    }
    
}
