//
//  TBGoodsInfoHeaderTicketModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2022/1/11.
//

import UIKit

class TBGoodsInfoHeaderTicketModel: TBMerchInfoModelProtocol {
    private var isHasBottomRadus: Bool
    private var isHasTopRadus: Bool
    
    var prefixTitleText: String?
    var suffixValueText: String?
    
    var commonCouponVos: [TBGoodsCommonCouponVo]?
    
    var style: pinLocationStyle = .goodsInfoTicket

    var rowHeight: CGFloat {
        return 44
    }
    
    var hasTopRadius: Bool {
        return isHasTopRadus
    }

    var hasBottomRadus: Bool {
        return isHasBottomRadus
    }
    
    init(commonCouponVos: [TBGoodsCommonCouponVo]?, prefixTitleText: String? = nil,suffixValueText: String? = nil,hasTopRadius: Bool = false, hasBottomRadius: Bool = false) {
        self.commonCouponVos = commonCouponVos
        self.prefixTitleText = prefixTitleText
        self.suffixValueText = suffixValueText
        
        self.isHasTopRadus = hasTopRadius
        self.isHasBottomRadus = hasBottomRadius
    }
    
    
}
