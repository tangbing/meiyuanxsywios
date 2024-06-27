//
//  CLOrderSubmitModel.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2022/2/22.
//

import Foundation
import SwiftyJSON

class CLOrderSubmitModel: CLSwiftyJSONAble {
    var cheapAmt:String
    var groupCouponList:[CLCouponListModel]
    var moreDiscountAmt:String
    var orderCarVOList:[CLOrderCarVOList]
    var payAmt:String
    var privateCouponList:[CLCouponListModel]
    var redPacketAmt:String
    var redPacketCouponHistoryVoList:[CLCouponListModel]
    var takeoutCouponList:[CLCouponListModel]
    
    required init?(jsonData: JSON) {
        cheapAmt = jsonData["cheapAmt"].stringValue
        groupCouponList = jsonData["groupCouponList"].arrayValue.compactMap{
            return CLCouponListModel.init(jsonData: $0)
        }
        moreDiscountAmt = jsonData["moreDiscountAmt"].stringValue
        orderCarVOList = jsonData["orderCarVOList"].arrayValue.compactMap{
            return CLOrderCarVOList.init(jsonData: $0)
        }
        payAmt = jsonData["payAmt"].stringValue
        privateCouponList = jsonData["privateCouponList"].arrayValue.compactMap{
            return CLCouponListModel.init(jsonData: $0)
        }
        redPacketAmt = jsonData["redPacketAmt"].stringValue
        redPacketCouponHistoryVoList = jsonData["privateCouponList"].arrayValue.compactMap{
            return CLCouponListModel.init(jsonData: $0)
        }
        takeoutCouponList = jsonData["privateCouponList"].arrayValue.compactMap{
            return CLCouponListModel.init(jsonData: $0)
        }
    }
}


class CLCouponListModel :CLSwiftyJSONAble {
    
    var activityClassify: Int
    var beginDate: String
    var businessType: Int
    var couponHistoryId: Int
    var couponName: String
    var couponNum: Int
    var couponStatus: Int
    
    var couponType: Int
    var discountAmount: String
    var endDate: String
    var fullReductionAmount:String
    var isDefaultUse:Bool
    var isDosageCoupon:Bool
    var isUse:Bool
    var merchantAmount:String
    var merchantId:Int
    var merchantLogo:String
    
    var merchantName: String
    var timeoutDayNum: String
    var upGradeMerchantId:String
    var useCondition:Int
    var useDate:String
    var useRule: String
    var useStatus:Int
    var userId: Int
    
    required init?(jsonData: JSON) {
        activityClassify = jsonData["activityClassify"].intValue
        beginDate = jsonData["beginDate"].stringValue
        businessType = jsonData["businessType"].intValue
        couponHistoryId = jsonData["couponHistoryId"].intValue
        couponName = jsonData["couponName"].stringValue
        couponNum = jsonData["couponNum"].intValue
        couponStatus = jsonData["couponStatus"].intValue
        
        couponType = jsonData["couponType"].intValue
        discountAmount = jsonData["discountAmount"].stringValue
        endDate = jsonData["endDate"].stringValue
        fullReductionAmount = jsonData["fullReductionAmount"].stringValue
        isDefaultUse = jsonData["isDefaultUse"].boolValue
        isDosageCoupon = jsonData["isDosageCoupon"].boolValue
        isUse = jsonData["isUse"].boolValue
        merchantAmount = jsonData["merchantAmount"].stringValue
        merchantId = jsonData["merchantId"].intValue
        merchantLogo = jsonData["merchantLogo"].stringValue
        
        merchantName = jsonData["merchantName"].stringValue
        timeoutDayNum = jsonData["timeoutDayNum"].stringValue
        upGradeMerchantId = jsonData["upGradeMerchantId"].stringValue
        useCondition = jsonData["useCondition"].intValue
        useDate = jsonData["useDate"].stringValue
        useRule = jsonData["useRule"].stringValue
        useStatus = jsonData["useStatus"].intValue
        userId = jsonData["userId"].intValue
    }

}

class CLOrderCarVOList:CLSwiftyJSONAble {
    var activityAmt:String
    var activityCouponHistoryVoList:[CLCouponListModel]
    var bizType:String
    var cheapAmt:String
    var couponHistoryVoList:[CLCouponListModel]
    var customerId:String
    var diffPrice:String
    var distance:String
    var distributionAmt:String
    var distributionCheapAmt:String
    var id:String
    var isReachMinPrice:Bool
    var isSingleMerchant:Bool
//    var memberCardListVo:CLMemberCardVo
    var merchantAddress:String
    var merchantCouponAmt:String
    var merchantCouponHistoryVoList:[CLCouponListModel]
//    var merchantCustomerReduceVo:[]
    var merchantFullReduceVoList:[CLMerchantFullReduceVoList]
    var merchantFullReduceVoListStr:String
    var merchantId:String
    var merchantLat:String
    var merchantLng:String
    var merchantName:String
    var minPrice:String
    var moreDiscountAmt:Double
    var newCustomerAmt:String
    var orderCheapInfoVOList:[CLOrderCheapInfoVOListModel]
    var orderGoodsDetailVOList:[CLOrderGoodsDetailVOList]
//    var orderGoodsMoreDiscountList
//    var orderShoppingTrolleyVOList:
    var packetAmt:String
    var payAmt:String
    var redPacketAmt:String
    var redPacketCouponHistoryVoList:[CLCouponListModel]
    required init?(jsonData: JSON) {
        activityAmt = jsonData["activityAmt"].stringValue
        activityCouponHistoryVoList = jsonData["activityCouponHistoryVoList"].arrayValue.compactMap{
            return  CLCouponListModel.init(jsonData: $0)
        }
        bizType = jsonData["bizType"].stringValue
        cheapAmt = jsonData["cheapAmt"].stringValue
        couponHistoryVoList = jsonData["couponHistoryVoList"].arrayValue.compactMap{
            return  CLCouponListModel.init(jsonData: $0)
        }
        customerId = jsonData["customerId"].stringValue
        diffPrice = jsonData["diffPrice"].stringValue
        distance = jsonData["distance"].stringValue
        distributionAmt = jsonData["distributionAmt"].stringValue
        distributionCheapAmt = jsonData["distributionCheapAmt"].stringValue
        id = jsonData["id"].stringValue
        isReachMinPrice = jsonData["isReachMinPrice"].boolValue
        isSingleMerchant = jsonData["isSingleMerchant"].boolValue
//        memberCardListVo:CLMemberCardVo
        merchantAddress = jsonData["merchantAddress"].stringValue
        merchantCouponAmt = jsonData["merchantCouponAmt"].stringValue
        merchantCouponHistoryVoList = jsonData["merchantCouponHistoryVoList"].arrayValue.compactMap{
            return  CLCouponListModel.init(jsonData: $0)
        }
    //    var merchantCustomerReduceVo:[]
        merchantFullReduceVoList = jsonData["merchantFullReduceVoList"].arrayValue.compactMap{
            return  CLMerchantFullReduceVoList.init(jsonData: $0)
        }
        merchantFullReduceVoListStr = jsonData["merchantFullReduceVoListStr"].stringValue
        merchantId = jsonData["merchantId"].stringValue
        merchantLat = jsonData["merchantLat"].stringValue
        merchantLng = jsonData["merchantLng"].stringValue
        merchantName = jsonData["merchantName"].stringValue
        minPrice = jsonData["minPrice"].stringValue
        moreDiscountAmt = jsonData["moreDiscountAmt"].doubleValue
        newCustomerAmt = jsonData["newCustomerAmt"].stringValue
        orderCheapInfoVOList = jsonData["orderCheapInfoVOList"].arrayValue.compactMap{
            return  CLOrderCheapInfoVOListModel.init(jsonData: $0)
        }
        orderGoodsDetailVOList = jsonData["orderGoodsDetailVOList"].arrayValue.compactMap{
            return  CLOrderGoodsDetailVOList.init(jsonData: $0)
        }
    //    var orderGoodsMoreDiscountList
    //    var orderShoppingTrolleyVOList:
        packetAmt = jsonData["packetAmt"].stringValue
        payAmt = jsonData["payAmt"].stringValue
        redPacketAmt = jsonData["redPacketAmt"].stringValue
        redPacketCouponHistoryVoList = jsonData["redPacketCouponHistoryVoList"].arrayValue.compactMap{
            return  CLCouponListModel.init(jsonData: $0)
        }
    }
}


class CLMerchantFullReduceVoList:CLSwiftyJSONAble{
    required init?(jsonData: JSON) {
        accordPrice = jsonData["accordPrice"].stringValue
        businessType = jsonData["businessType"].stringValue
        createBy = jsonData["createBy"].stringValue
        createTime = jsonData["createTime"].stringValue
        effectEndTime = jsonData["effectEndTime"].stringValue
        effectStartTime = jsonData["effectStartTime"].stringValue
        effectType = jsonData["effectType"].stringValue
        endTime = jsonData["endTime"].stringValue
        id = jsonData["id"].stringValue
        isDefaultUse = jsonData["isDefaultUse"].boolValue
        isUse = jsonData["isUse"].boolValue
        merchantId = jsonData["merchantId"].stringValue
        merchantName = jsonData["merchantName"].stringValue
        periodOn = jsonData["periodOn"].stringValue
        periodType = jsonData["periodType"].stringValue
        reducePrice = jsonData["reducePrice"].stringValue
        startTime = jsonData["startTime"].stringValue
        updateBy = jsonData["updateBy"].stringValue
        updateTime = jsonData["updateTime"].stringValue
    }
    
    var accordPrice:String
    var businessType:String
    var createBy:String
    var createTime:String
    var effectEndTime:String
    var effectStartTime:String
    var effectType:String
    var endTime:String
    var id:String
    var isDefaultUse:Bool
    var isUse:Bool
    var merchantId:String
    var merchantName:String
    var periodOn:String
    var periodType:String
    var reducePrice:String
    var startTime:String
    var updateBy:String
    var updateTime:String
}

