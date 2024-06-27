//
//  XSShopCartInfoTopModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/24.
//

import UIKit

class XSShopCartInfoTopModel: XSShopCartModelProtocol {
    /// 是否失效，true 未失效，false 失效
    var cellState: XSShopCartCellState
    var dataModel: XSShopCartDataModel!
    var signalTitle: String
    var style: XSShopCartType = .shopInfoTop
    
    var rowHeight: CGFloat {
        return 74
    }
    var isSelect = false
    
    var hasTopRadius: Bool
    var hasBottomRadius: Bool

    
    init(cellState: XSShopCartCellState, signalTitle: String,
         dataModel: XSShopCartDataModel, hasTopRadius: Bool = false, hasBottomRadius: Bool = false) {
        self.hasTopRadius = hasTopRadius
        self.hasBottomRadius = hasBottomRadius
        self.cellState = cellState
        self.dataModel = dataModel
        self.signalTitle = signalTitle
    }
    
}
