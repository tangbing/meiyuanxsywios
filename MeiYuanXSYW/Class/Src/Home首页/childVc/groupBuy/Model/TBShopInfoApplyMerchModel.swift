//
//  TBShopInfoApplyMerchModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/17.
//

import UIKit

class TBShopInfoApplyMerchModel: TBMerchInfoModelProtocol {
    
    var style: pinLocationStyle = .applyMerch
    
    var groupBuyGoodsItem: TBGroupBuyGoodsItem?
    var voucherGoodsItem: TBVoucherGoodsItem?
    
    var rowHeight: CGFloat {
        return UITableView.automaticDimension
    }
    
    init(groupBuyGoodsItem: TBGroupBuyGoodsItem? = nil, voucherGoodsItem: TBVoucherGoodsItem? = nil) {
        self.groupBuyGoodsItem = groupBuyGoodsItem
        self.voucherGoodsItem = voucherGoodsItem
    }
    
    
//    var hasTopRadius: Bool {
//        return isHasTopRadus
//    }
//    
//    var hasBottomRadus: Bool {
//        return isHasBottomRadus
//    }
    
//    var nameTitleText: String
// 
//  
//    private var isHasBottomRadus: Bool
//    private var isHasTopRadus: Bool
//    
//    
//    init(nameTitleText: String,hasTopRadius: Bool = false, hasBottomRadius: Bool = false) {
//        self.nameTitleText = nameTitleText
//        self.isHasTopRadus = hasTopRadius
//        self.isHasBottomRadus = hasBottomRadius
//    }
    
    
    
}

