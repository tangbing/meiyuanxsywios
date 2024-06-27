//
//  TBss.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/4.
//

import Foundation
import UIKit

class TBDiscountModel: TBMerchInfoModelProtocol {
    var couponDetail: TBCouponDetails
    
    var style: pinLocationStyle = .discount
    
    var rowHeight: CGFloat {
        return 90
    }
    
    init(couponDetail: TBCouponDetails) {
        self.couponDetail = couponDetail
    }
    
    
    
}
