//
//  TBMerchantCouponListModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/16.
//

import HandyJSON

class TBMerchantCouponListModel: HandyJSON {
    /// 是否参与红包升级活动
    var joinUpCoupon: Bool = false
    var upAmt: Int = 0
    var memberStatus: Int = 0
    var freeCouponList: [FreeCouponList]?
    var myCouponVoList: [FreeCouponList]?
    /// 我的会员红包列表
    var myMemberCouponVoList: [FreeCouponList]?
    /// 可购买的会员卡列表
    var memberCardVoList: [MemberCardVoList]?
    
    required init() {
        
    }
    
}

class MemberCardVoList: HandyJSON {
    /// <##>折扣
    var discount: Double = 0.0
    
    /// 优惠券金额
    var discountAmount: Double = 0.0
    
    /// 赠送张数
    var giveNum: Int = 0
    
    /// 会员卡id
    var memberCardId: Int = 0
    
    /// 会员卡名称
    var memberCardName: String = ""
    
    /// 原价
    var originalPrice: Double = 0.0
    
    /// 售卖价格
    var price: Double = 0.0
    
    /// 有效时长周期 天
    var validTime: Int = 0
    
    /// 有效时长单位：1周2月3季4年
    var validTimeUnit: Int = 0
    
    /// 是否展开折叠
    var ruleExpand: Bool = false
    var redPacketType: TBTicketRedPacketType = .memberCard
    
    required init() {
        
    }
}

// MARK: - FreeCouponList
class FreeCouponList: HandyJSON {
    var couponId: Int = 0
    var couponHistoryId: String?
    var couponName: String = ""
    var couponType: Int = 0
    var remarks: String = ""
    var businessType: Int = 0
    var useCondition: Int = 0
    var fullReductionAmount: Int = 0
    var discountAmount: Int = 0
    var merchantAmount: Int = 0
    var useTimeSetting: Int = 0
    var validTime: Int = 0
    var beginDate: String = ""
    var endDate: String = ""
    var useExplain: String = ""
    var merchantId: String?
    var receiveStatus : Int = 0
    var perLimit: Int = 0
    /// 是否展开折叠
    var ruleExpand: Bool = false
    var btnTitle: String = ""
    var redPacketType: TBTicketRedPacketType = .myRedMemberPacket

    required init() {
        
    }
}


//// MARK: - MyCouponVoList
//struct MyCouponVoList: HandyJSON {
//    var couponID, userID: Int
//    var couponName: String
//    var couponType: Int
//    var remarks: String?
//    var businessType, useCondition: Int
//    var fullReductionAmount: Int?
//    var discountAmount: Int
//    var merchantAmount: Int?
//    var useTimeSetting, validTime: Int
//    var beginDate, endDate, useExplain, couponCode: String
//    var useStatus: Int
//    var useDate, merchantImageList: String?
//    var merchantID: String?
//    var merchantName: JSONNull?
//    var receiveStatus: Int
//
//}

