//
//  XSShopCartRecommendModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/26.
//

import UIKit

class XSShopCartRecommendModel: XSShopCartModelProtocol {
    var cellState: XSShopCartCellState {
        return .normal
    }
    
    var isSelect: Bool = false
    
    var style: XSShopCartType = .recommand

    var rowHeight: CGFloat {
        return CGFloat( 2 * 65 + 15)
    }
}
