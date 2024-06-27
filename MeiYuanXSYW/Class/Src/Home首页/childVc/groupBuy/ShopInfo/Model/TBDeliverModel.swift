//
//  TBDeliverModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/5.
//

import Foundation
import UIKit

class TBDeliverModel: TBMerchInfoModelProtocol {
    var goodsItems: [GoodsItemVo]
    var style: pinLocationStyle = .deliver
    
    var rowHeight: CGFloat {
        let itemW:CGFloat = (screenWidth - 30) * 0.5
        let itemH:CGFloat = itemW * 3 / 4 + 83
        return itemH
    }
    
    init(goodsItems: [GoodsItemVo]) {
        self.goodsItems = goodsItems
    }
    
}

