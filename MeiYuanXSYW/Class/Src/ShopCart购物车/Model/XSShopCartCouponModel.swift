//
//  XSShopCartCouponModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2022/2/11.
//

import UIKit
import HandyJSON

class XSShopCartCouponModel: HandyJSON {

    var beginDate: String = ""
    /// 适用业务(0全部通用1外卖2私厨3团购)
    var businessType: Int = 0
    /// 优惠券领取记录id
    var couponHistoryId: Int = 0
    /// 优惠券id
    var couponId: Int = 0
    
    
    
    var couponName: String = ""
    /// 优惠券类型（2会员抵扣券3平台红包5商家券6商品券9会员权益券）
    var couponType: Int = 0
    /// 优惠金额
    var discountAmount: NSNumber = 0
    
    var endDate: String = ""
    /// 满减条件金额
    var fullReductionAmount : Int = 0
    /// 商家升级后的金额
    var merchantAmount: NSNumber = 0
    
    var merchantId: String = ""
    /// 领取状态 0未领取 1已领取 2未兑换 3已兑换
    var receiveStatus: Int = 0
    var remarks: String = ""
    var useCondition: Int = 0
    var useExplain: String = ""
    var useTimeSetting : Int = 0
    var validTime: Int = 0
    
    required init() {
    
    }
}
