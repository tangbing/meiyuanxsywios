//
//  XSShopCaculateMoreAmtModel.swift
//  MeiYuanXSYW
//
//  Created by Tb on 2022/1/25.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let xSShopCartModel = try XSShopCartModel(json)

import Foundation
import HandyJSON



// MARK: - DataClass
class XSShopCaculateMoreAmtModel: HandyJSON {
   
    
    var orderCarVOList: [OrderCarVOList] = [OrderCarVOList]()
    var takeoutCouponList, privateCouponList, groupCouponList, redPacketCouponHistoryVoList: [CouponHistoryVoCouponHistoryVo]?
    //var merchantAmount, memberCardID: NSNull?
    var isSingleMerchant: Bool?
    var memberStatus: Int?
    var memberCardVo, redPacketAmt: NSNumber?
    var payAmt: NSNumber?
    /// 多件折扣金额
    var moreDiscountAmt: NSNumber?
    /// 优惠金额
    var cheapAmt: NSNumber?
    //var isSettleOrder: NSNull?


    
    required init() {}

}

// MARK: - List
class CouponHistoryVoCouponHistoryVo: HandyJSON {
    
    /// 通过金额计算是否可用
    var isUse: Bool = false
    /// 是否默认使用
    var isDefaultUse: Bool = false
    /// 领取记录id
    var couponHistoryId: Int = 0
    var couponId: Int = 0
    var couponName: String = ""
    var userId: Int = 0
    var couponCode: String = ""
    var useStatus: Int = 0
    var useDate: String = ""
    var couponSnapshot: String = ""
    var beginDate, endDate: String?
    var couponStatus, discountAmount, fullReductionAmount: Int?
    var createTime: String?
    var merchantID: String?
    var upGradeMerchantID, merchantAmount, merchantName, merchantLogo: NSNull?
    var businessType, couponType: Int?
    var activityClassify: Int?
    var isDosageCoupon, timeoutDayNum: NSNull?
    var merchantIDList: [String]?
    var useCondition: NSNull?
    var getType: Int?
    var isDel: Bool?
    var updateTime: String = ""
    var couponNum, useRule: NSNull?

    
    required init() {}

}


// MARK: - OrderCarVOList
class OrderCarVOList: HandyJSON {
    var orderGoodsDetailVOList: [OrderGoodsDetailVOList]?
    var orderCheapInfoVOList: [OrderCheapInfoVOList]?
    
    var couponHistoryId: Int = 0
    var id = 0
    var customerId = 0
    var isSingleMerchant: Bool = false
    //var memberCardListVo: NSNull?
    var orderShoppingTrolleyVOList: [OrderShoppingTrolleyVOList]?
    //var orderGoodsMoreDiscountList: NSNull?
    var merchantFullReduceVoList: [MerchantFullReduceVoList]?
    //var merchantCustomerReduceVo, couponHistoryVoList, merchantCouponHistoryVoList, activityCouponHistoryVoList: NSNull?
    var redPacketCouponHistoryVoList: NSNull?
    var merchantFullReduceVoListStr: String = ""
    /// bizType    integer($int32) 业务类型，0外卖，1团购，2私厨 4会员
    var bizType: Int = 0
    var merchantId: String = ""
    var merchantName: String = ""
    
    var distributionAmt: NSNumber = 0
    var newCustomerAmt: NSNumber = 0
    var merchantCouponAmt: NSNumber = 0
    var distributionCheapAmt: NSNumber = 0
    var activityAmt: NSNumber = 0
    var redPacketAmt: NSNumber = 0
    var packetAmt: NSNumber = 0
    var cheapAmt: NSNumber = 0
    var payAmt: NSNumber = 0
    var moreDiscountAmt: NSNumber = 0
    /// true:达到起送价格,false:未达到可起送价格，差多少起送。
    var isReachMinPrice: Bool = false
    var minPrice: NSNumber = 0
    var diffPrice: NSNumber = 0
    var merchantLng: NSNumber = 0
    var merchantLat: NSNumber = 0
    var distance: Int = 0
    var merchantAddress: String = ""

   
    
    required init() {}

}

/*
// MARK: - MerchantFullReduceVoList
class MerchantFullReduceVoList {
    var id: Int?
    var isUse, isDefaultUse: Bool?
    var businessType, accordPrice, reducePrice: Int?
    var merchantID, merchantName, startTime, endTime: String?
    var effectStartTime, effectEndTime: String?
    var periodType: Int?
    var periodOn: String?
    var effectType: Int?
    var createTime, createBy, updateTime, updateBy: String?

    init(id: Int?, isUse: Bool?, isDefaultUse: Bool?, businessType: Int?, accordPrice: Int?, reducePrice: Int?, merchantID: String?, merchantName: String?, startTime: String?, endTime: String?, effectStartTime: String?, effectEndTime: String?, periodType: Int?, periodOn: String?, effectType: Int?, createTime: String?, createBy: String?, updateTime: String?, updateBy: String?) {
        self.id = id
        self.isUse = isUse
        self.isDefaultUse = isDefaultUse
        self.businessType = businessType
        self.accordPrice = accordPrice
        self.reducePrice = reducePrice
        self.merchantID = merchantID
        self.merchantName = merchantName
        self.startTime = startTime
        self.endTime = endTime
        self.effectStartTime = effectStartTime
        self.effectEndTime = effectEndTime
        self.periodType = periodType
        self.periodOn = periodOn
        self.effectType = effectType
        self.createTime = createTime
        self.createBy = createBy
        self.updateTime = updateTime
        self.updateBy = updateBy
    }
}

 */

// MARK: - OrderCheapInfoVOList
class OrderCheapInfoVOList: HandyJSON {
    var id, orderSn, biztypeOrderSn, merchantOrderSn: NSNull?
    var activityName, activityInfo: String?
    var activityCheapAmt: Int?
    var account, goodsID, goodsName, merchantID: NSNull?
    var merchantName, activityType: NSNull?
    var appCheapAmt, merchantCheapAmt: Int?
    var createTime, createBy, updateTime, updateBy: NSNull?

    init(id: NSNull?, orderSn: NSNull?, biztypeOrderSn: NSNull?, merchantOrderSn: NSNull?, activityName: String?, activityInfo: String?, activityCheapAmt: Int?, account: NSNull?, goodsID: NSNull?, goodsName: NSNull?, merchantID: NSNull?, merchantName: NSNull?, activityType: NSNull?, appCheapAmt: Int?, merchantCheapAmt: Int?, createTime: NSNull?, createBy: NSNull?, updateTime: NSNull?, updateBy: NSNull?) {
        self.id = id
        self.orderSn = orderSn
        self.biztypeOrderSn = biztypeOrderSn
        self.merchantOrderSn = merchantOrderSn
        self.activityName = activityName
        self.activityInfo = activityInfo
        self.activityCheapAmt = activityCheapAmt
        self.account = account
        self.goodsID = goodsID
        self.goodsName = goodsName
        self.merchantID = merchantID
        self.merchantName = merchantName
        self.activityType = activityType
        self.appCheapAmt = appCheapAmt
        self.merchantCheapAmt = merchantCheapAmt
        self.createTime = createTime
        self.createBy = createBy
        self.updateTime = updateTime
        self.updateBy = updateBy
    }
    
    required init() {}

}

// MARK: - OrderGoodsDetailVOList
class OrderGoodsDetailVOList: HandyJSON {
    var goodsItemDetailVo, orderVoucherVerificationVOList, id, orderSn: NSNull?
    var biztypeOrderSn, merchantOrderSn: NSNull?
    var bizType: Int?
    var merchantID, merchantName, goodsID, goodsName: String?
    var specID, attributesIDList: NSNull?
    var originalPrice: Int?
    var activityPrice, singleDiscountPrice: NSNull?
    var finalPrice: Int?
    var discount, discountRate, moreDiscountPrice: NSNull?
    var packetAmt, account: Int?
    var specNature: NSNull?
    var shareAmt, totalShareAmt: Double?
    var goodsType, voucherAmt: NSNull?
    var salePrice, totalAmt: Double?
    var validTimeUnit, groupSnapshot, createTime, createBy: NSNull?
    var updateTime, updateBy, topPic: NSNull?

    init(goodsItemDetailVo: NSNull?, orderVoucherVerificationVOList: NSNull?, id: NSNull?, orderSn: NSNull?, biztypeOrderSn: NSNull?, merchantOrderSn: NSNull?, bizType: Int?, merchantID: String?, merchantName: String?, goodsID: String?, goodsName: String?, specID: NSNull?, attributesIDList: NSNull?, originalPrice: Int?, activityPrice: NSNull?, singleDiscountPrice: NSNull?, finalPrice: Int?, discount: NSNull?, discountRate: NSNull?, moreDiscountPrice: NSNull?, packetAmt: Int?, account: Int?, specNature: NSNull?, shareAmt: Double?, totalShareAmt: Double?, goodsType: NSNull?, voucherAmt: NSNull?, salePrice: Double?, totalAmt: Double?, validTimeUnit: NSNull?, groupSnapshot: NSNull?, createTime: NSNull?, createBy: NSNull?, updateTime: NSNull?, updateBy: NSNull?, topPic: NSNull?) {
        self.goodsItemDetailVo = goodsItemDetailVo
        self.orderVoucherVerificationVOList = orderVoucherVerificationVOList
        self.id = id
        self.orderSn = orderSn
        self.biztypeOrderSn = biztypeOrderSn
        self.merchantOrderSn = merchantOrderSn
        self.bizType = bizType
        self.merchantID = merchantID
        self.merchantName = merchantName
        self.goodsID = goodsID
        self.goodsName = goodsName
        self.specID = specID
        self.attributesIDList = attributesIDList
        self.originalPrice = originalPrice
        self.activityPrice = activityPrice
        self.singleDiscountPrice = singleDiscountPrice
        self.finalPrice = finalPrice
        self.discount = discount
        self.discountRate = discountRate
        self.moreDiscountPrice = moreDiscountPrice
        self.packetAmt = packetAmt
        self.account = account
        self.specNature = specNature
        self.shareAmt = shareAmt
        self.totalShareAmt = totalShareAmt
        self.goodsType = goodsType
        self.voucherAmt = voucherAmt
        self.salePrice = salePrice
        self.totalAmt = totalAmt
        self.validTimeUnit = validTimeUnit
        self.groupSnapshot = groupSnapshot
        self.createTime = createTime
        self.createBy = createBy
        self.updateTime = updateTime
        self.updateBy = updateBy
        self.topPic = topPic
    }
    
    required init() {}

}

/*
// MARK: - OrderShoppingTrolleyVOList
class OrderShoppingTrolleyVOList {
    var id, userID, bizType: Int?
    var merchantID, merchantName, goodsID, goodsName: String?
    var anytimeRetreat, expiredRetreat, isReserve: Int?
    var sellPeriod: String?
    var account: Int?
    var specID, specName, attributesIDDetails, attributesNameDetails: String?
    var discountRate: Int?
    var status, createTime, createBy, updateTime: NSNull?
    var updateBy: NSNull?
    var originPrice: Int?
    var activityPrice: NSNull?
    var packetAmt: Int?
    var discount, discountPrice: NSNull?
    var finalPrice: Int?
    var topPic: String?
    var needSpecID: Bool?
    var salePromotionStr, groupUseRuleStr, moreDiscounts: NSNull?

    init(id: Int?, userID: Int?, bizType: Int?, merchantID: String?, merchantName: String?, goodsID: String?, goodsName: String?, anytimeRetreat: Int?, expiredRetreat: Int?, isReserve: Int?, sellPeriod: String?, account: Int?, specID: String?, specName: String?, attributesIDDetails: String?, attributesNameDetails: String?, discountRate: Int?, status: NSNull?, createTime: NSNull?, createBy: NSNull?, updateTime: NSNull?, updateBy: NSNull?, originPrice: Int?, activityPrice: NSNull?, packetAmt: Int?, discount: NSNull?, discountPrice: NSNull?, finalPrice: Int?, topPic: String?, needSpecID: Bool?, salePromotionStr: NSNull?, groupUseRuleStr: NSNull?, moreDiscounts: NSNull?) {
        self.id = id
        self.userID = userID
        self.bizType = bizType
        self.merchantID = merchantID
        self.merchantName = merchantName
        self.goodsID = goodsID
        self.goodsName = goodsName
        self.anytimeRetreat = anytimeRetreat
        self.expiredRetreat = expiredRetreat
        self.isReserve = isReserve
        self.sellPeriod = sellPeriod
        self.account = account
        self.specID = specID
        self.specName = specName
        self.attributesIDDetails = attributesIDDetails
        self.attributesNameDetails = attributesNameDetails
        self.discountRate = discountRate
        self.status = status
        self.createTime = createTime
        self.createBy = createBy
        self.updateTime = updateTime
        self.updateBy = updateBy
        self.originPrice = originPrice
        self.activityPrice = activityPrice
        self.packetAmt = packetAmt
        self.discount = discount
        self.discountPrice = discountPrice
        self.finalPrice = finalPrice
        self.topPic = topPic
        self.needSpecID = needSpecID
        self.salePromotionStr = salePromotionStr
        self.groupUseRuleStr = groupUseRuleStr
        self.moreDiscounts = moreDiscounts
    }
}

*/
