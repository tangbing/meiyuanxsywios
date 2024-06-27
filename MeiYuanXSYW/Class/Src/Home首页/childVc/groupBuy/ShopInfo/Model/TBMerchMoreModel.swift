//
//  TBMerchMore.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/4.
//

import Foundation
import UIKit
import HandyJSON


class TBMerchMoreModel: TBMerchInfoModelProtocol {
    
    var data: Datum
    
    var style: pinLocationStyle = .merchMore
    
    var count: Int = 0

    var code: Int = 0
    
    //var data: [Datum]!
    
    var rowHeight: CGFloat {
        return 272
    }
    
    init(data: Datum, count: Int, code: Int) {
        self.data = data
        self.count = count
        self.code = code
    }
    
    //required init() {}
    
}

class TBCommendShopDataModel: HandyJSON {

    var count: Int = 0
    
    var code: Int = 0
    
    var data: [Datum] = [Datum]()
    
    
    required init() {}
  

}


// MARK: - Datum
class Datum: HandyJSON {
    var merchantLogo: String = ""
    var merchantId: String = ""
    var merchantName: String = ""
    var merchantType: Int = 0
    var merchantCFullReduceVoList: [MerchantCFullReduceVoList]?
    
    /// 外卖业务(0:未开通;1:已开通;2:已关闭)
    var takeout: Int = 0
    
    /// 团购业务(0:未开通;1:已开通;2:已关闭)
    var group: Int = 0
    
    /// 私厨业务(0:未开通;1:已开通;2:已关闭)
    var privateChef: Int = 0
    var distance: Double = 0.0
    /// 月销
    var monthlySales : Int = 0
    
    /// 商家评分
    var merchantScore : NSNumber = 0
    /// 人均消费
    var perCapita : Int = 0
    /// 起送费
    var startDelivery: NSNumber = 0
    
    /// 配送时间
    var deliveryTime: Int = 0
    
    /// 是否参与红包升级活动
    var joinUpCoupon: Bool = false
    
    /// 商家优惠券列表
    var commonCouponVos: [CommonCouponVo]?
    
    /// 商品详情数据集合
    var details: [Detail]?

    
   
//    init(merchantLogo: String, merchantId: String, merchantName: String, merchantType: Int, merchantCFullReduceVoList: [MerchantCFullReduceVoList], takeout: Int, group: Int, privateChef: Int, distance: Double, monthlySales: Int, merchantScore: Int, perCapita: Int, startDelivery: Int, deliveryTime: Int, joinUpCoupon: Bool, commonCouponVos: [CommonCouponVo]?, details: [Detail]) {
//        self.merchantLogo = merchantLogo
//        self.merchantId = merchantId
//        self.merchantName = merchantName
//        self.merchantType = merchantType
//        self.merchantCFullReduceVoList = merchantCFullReduceVoList
//        self.takeout = takeout
//        self.group = group
//        self.privateChef = privateChef
//        self.distance = distance
//        self.monthlySales = monthlySales
//        self.merchantScore = merchantScore
//        self.perCapita = perCapita
//        self.startDelivery = startDelivery
//        self.deliveryTime = deliveryTime
//        self.joinUpCoupon = joinUpCoupon
//        self.commonCouponVos = commonCouponVos
//        self.details = details
//    }
    
    required init() {}
    
}

//// MARK: - CommonCouponVo
//class CommonCouponVo: HandyJSON {
//    var couponId: Int?
//    var couponHistoryId: Int?
//    var couponName: String?
//    var couponType: Int
//    var activityClassify: Int?
//    var remarks: String?
//    var businessType: Int?
//    var useCondition: Int
//    var fullReductionAmount, discountAmount, merchantAmount, useTimeSetting: Int?
//    var validTime: Int?
//    var beginDate, endDate, obtEndDate, useExplain: String?
//    var merchantId: String?
//    var receiveStatus: Int
//    var perLimit, issueTotalCount, receivedNum: Int?
//
//    required init() {}
//
//    init(couponId: Int?, couponHistoryId: Int?, couponName: String?, couponType: Int, activityClassify: Int?, remarks: String?, businessType: Int?, useCondition: Int, fullReductionAmount: Int?, discountAmount: Int?, merchantAmount: Int?, useTimeSetting: Int?, validTime: Int?, beginDate: String?, endDate: String?, obtEndDate: String?, useExplain: String?, merchantId: String?, receiveStatus: Int, perLimit: Int?, issueTotalCount: Int?, receivedNum: Int?) {
//        self.couponId = couponId
//        self.couponHistoryId = couponHistoryId
//        self.couponName = couponName
//        self.couponType = couponType
//        self.activityClassify = activityClassify
//        self.remarks = remarks
//        self.businessType = businessType
//        self.useCondition = useCondition
//        self.fullReductionAmount = fullReductionAmount
//        self.discountAmount = discountAmount
//        self.merchantAmount = merchantAmount
//        self.useTimeSetting = useTimeSetting
//        self.validTime = validTime
//        self.beginDate = beginDate
//        self.endDate = endDate
//        self.obtEndDate = obtEndDate
//        self.useExplain = useExplain
//        self.merchantId = merchantId
//        self.receiveStatus = receiveStatus
//        self.perLimit = perLimit
//        self.issueTotalCount = issueTotalCount
//        self.receivedNum = receivedNum
//    }
//}

// MARK: - Detail
class Detail: HandyJSON {
    var goodsId: String = ""
    var goodsName: String = ""
    var topPic: String = ""
    var picAddress: String = ""
    ///  售价
    var minPrice: NSNumber = 0.0
    
    var originalPrice: NSNumber = 0.0
    /// 商品类型 0：外卖 1：团购 2：私厨
    var goodsType: Int = 0

    required init() {}

//    init(goodsId: String, goodsName: String, topPic: String, picAddress: String, minPrice: Int, originalPrice: Int, goodsType: Int) {
//        self.goodsId = goodsId
//        self.goodsName = goodsName
//        self.topPic = topPic
//        self.picAddress = picAddress
//        self.minPrice = minPrice
//        self.originalPrice = originalPrice
//        self.goodsType = goodsType
//    }
    
}


