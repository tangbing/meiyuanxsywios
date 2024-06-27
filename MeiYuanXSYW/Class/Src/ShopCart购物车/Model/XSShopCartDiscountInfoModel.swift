//
//  XSShopCartDiscountInfoModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/29.
//

import UIKit

class XSShopCartDiscountInfoModel: XSShopCartModelProtocol {

    var caculateMoreAmt: OrderCarVOList
    
    var cellState: XSShopCartCellState {
        return .normal
    }
    
    var isSelect = false
    

    var style: XSShopCartType = .discountInfo
    
    var rowHeight: CGFloat {
        return UITableView.automaticDimension
    }
    
    var hasTopRadius: Bool
    var hasBottomRadius: Bool
    
    init(cellState: XSShopCartCellState = .normal,caculateMoreAmt: OrderCarVOList, hasTopRadius: Bool = false, hasBottomRadius: Bool = false) {
        //self.cellState = cellState
        
        self.hasTopRadius = hasTopRadius
        self.hasBottomRadius = hasBottomRadius
        
        self.caculateMoreAmt = caculateMoreAmt

    }
    
}
