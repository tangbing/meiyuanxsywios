//
//  TBGoodsInfoHeaderGoodsModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2022/1/11.
//

import UIKit

class TBGoodsInfoHeaderGoodsModel: TBMerchInfoModelProtocol {
    private var isHasBottomRadius: Bool
    private var isHasTopRadius: Bool
    
    var goodsItem: TBTakeoutGoodsItem?
    var groupBuyGoodsItem: TBGroupBuyGoodsItem?
    var voucherGoodsItem: TBVoucherGoodsItem?
    
    var style: pinLocationStyle = .goodsInfoItem

    var rowHeight: CGFloat {
        return UITableView.automaticDimension
    }
    
    var hasTopRadius: Bool {
        return isHasTopRadius
    }

    var hasBottomRadus: Bool {
        return isHasBottomRadius
    }
    
    init(goodsItem: TBTakeoutGoodsItem? = nil , groupBuyGoodsItem: TBGroupBuyGoodsItem? = nil,
         voucherGoodsItem: TBVoucherGoodsItem? = nil
         ,hasTopRadius: Bool = false, hasBottomRadius: Bool = false) {
        self.goodsItem = goodsItem
        self.voucherGoodsItem = voucherGoodsItem
        self.groupBuyGoodsItem = groupBuyGoodsItem
        
        self.isHasTopRadius = hasTopRadius
        self.isHasBottomRadius = hasBottomRadius
        
    }
    
}
