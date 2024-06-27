//
//  XSGoodsInfoGroupBuyTicketModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/19.
//

import UIKit

class XSGoodsInfoGroupBuyGoldTicketModel: TBMerchInfoModelProtocol {
    
    var voucherGoodsItem: TBVoucherGoodsItem
    var style: pinLocationStyle = .goldTicket
    
    var rowHeight: CGFloat {
        return 164
    }
    
    init(voucherGoodsItem: TBVoucherGoodsItem) {
        self.voucherGoodsItem = voucherGoodsItem
    }
    
    
}
