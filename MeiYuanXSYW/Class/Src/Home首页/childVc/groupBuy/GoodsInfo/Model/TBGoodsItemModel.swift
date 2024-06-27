//
//  TBGoodsModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2022/1/10.
//

import UIKit
import HandyJSON

class TBGoodsItemModel: HandyJSON {

    var groupBuyGoodsItem: TBGroupBuyGoodsItem?
    var privateKitchenGoodsItem: TBTakeoutGoodsItem?
    var takeoutGoodsItem: TBTakeoutGoodsItem?
    var voucherGoodsItem: TBVoucherGoodsItem?
    
    required init() {}
    
}

class TBGoodsCommonCouponVo: CommonCouponVo {
    /// 活动类型 1联盟活动 2平台满减活动 3推广活动
    var activityClassify: Int = 0
    
    
}

class TBGroupBuyGoodsItem: HandyJSON {
    
    var commonCouponVos: [TBGoodsCommonCouponVo] = [TBGoodsCommonCouponVo]()
    /// 优惠券
    var couponDtail: String = ""
    /// 折扣率
    var discountRate: Int = 0
    
    var evaluationDetails: TBEvaluationDetails?
    var finalPrice: NSNumber = 0
    var goodsId: String = ""
    var goodsName: String = ""
    var goodsPackageVos: [GoodsPackageVo] = [GoodsPackageVo]()
    var isChoose: Int = 0
    var isCollect: Int = 0
    var isReserve: Int = 0
    var merchantAddress: String = ""
    var merchantId: String = ""
    var merchantLogo: String = ""
    var merchantName: String = ""
    var merchantScore: NSNumber = 0
    var merchantTel: [String] = [""]
    var monthlySales: Int = 0
    /// 原价
    var originalPrice: NSNumber = 0
    
    var picAddress: [String] = [String]()
    var praise: Int = 0
    var promotion : String = ""
    var scopeOfApplication: String = ""
    var serviceDesc : [String] = [String]()
    var tagName: [String] = [String]()
    var termOfValidity: String = ""
    var useRule: String = ""
    var useTime: String = ""
    
    
    required init() {}
}


// MARK: - GoodsPackageItemVo
class GoodsPackageItemVo: HandyJSON {
    required init() {
        
    }
    
    var itemID: Int = 0
    var itemName: String = ""
    var itemNum: Int = 0
    var packageID : Int = 0
    var showPrice: NSNumber = 0

}

class TBPrivateKitchenGoodsItem: HandyJSON {

    var commonCouponVos: [TBGoodsCommonCouponVo] = [TBGoodsCommonCouponVo]()
    /// 优惠券
    var couponDtail: String = ""
    /// 折扣率
    var discountRate: NSNumber = 0
    var evaluationDetails: TBEvaluationDetails?
    var finalPrice: NSNumber = 0
    var goodsId : String = ""
    var goodsName: String = ""
    /// 可选规格 0：可选 1：不可选
    var isChoose: Int = 0
    /// 是否收藏 0：是 1：否
    var isCollect: Int = 0
    /// 原材料
    var material: String = ""
    /// 掌柜描述
    var merchantDesc: String = ""
    var merchantId: String = ""
    /// 月销
    var monthlySales: Int = 0
    var originalPrice: NSNumber = 0
    var picAddress: [String] = [""]
    var praise : Int = 0
    var preLimit: Int = 0
    /// NSNumber
    var promotion: String = ""
    /// 标签
    var tagName: [String] = [""]
    
    required init() {}
    
}

class TBTakeoutGoodsItem: HandyJSON {
    var attributesItem: [AttributesItem]?
    var commonCouponVos: [TBGoodsCommonCouponVo] = [TBGoodsCommonCouponVo]()
    /// 优惠券
    var couponDtail: String = ""
    /// 折扣率
    var discountRate: NSNumber = 0
    var evaluationDetails: TBEvaluationDetails?
    var finalPrice: NSNumber = 0
    var goodsId : String = ""
    var goodsName: String = ""
    var isChoose: Int = 0
    /// 是否收藏 0：是 1：否
    var isCollect: Int = 0
    var material: String = ""
    var merchantDesc: String = ""
    var monthlySales: Int = 0
    var originalPrice: NSNumber = 0
    var picAddress: [String] = [""]
    var praise: Int = 0
    var preLimit: Int = 0
    var promotion: String = ""
    var specItem: [SpecItem]?
    var tagName: [String] = [""]
    
    required init() {}
    
   
    
}

class TBVoucherGoodsItem: HandyJSON {
    
    var commonCouponVos: [TBGoodsCommonCouponVo] = [TBGoodsCommonCouponVo]()
    var discountRate: Int = 0
    var evaluationDetails: TBEvaluationDetails?
    var finalPrice: Int = 0
    var goodsId: String = ""
    var goodsName: String = ""
    var isChoose: Int = 0
    var isCollect: Int = 0
    var merchantAddress: String = ""
    var merchantId: String = ""
    var merchantLogo: String = ""
    var merchantName: String = ""
    var merchantScore: Int = 0
    var merchantTel: [String] = [""]
    var monthlySales: Int = 0
    var originalPrice: Int = 0
    var praise: Int = 0
    var scopeOfApplication: String = ""
    var serviceDesc: [String] = [""]
    var tagName: [String] = [""]
    var termOfValidity: String = ""
    var useRule: String = ""
    var useTime: String = ""
    var voucherAmt: Int = 0
    
    required init() {}
}

class TBCommonCouponVos: HandyJSON {
    var activityClassify: Int = 0
    
    var beginDate: String = ""
    
    var businessType: Int = 0

    var couponHistoryId: Int = 0

    var couponId: Int = 0

    var couponName: String = ""

    var couponType: Int = 0
    
    var discountAmount: Int = 0
    
    var endDate: String = ""

    var fullReductionAmount: Int = 0

    var issueTotalCount: Int = 0

    var merchantAmount: Int = 0
    
    var merchantId: String = ""


    var obtEndDate: String = ""

    var perLimit: Int = 0
    var receiveStatus: Int = 0
    var receivedNum: Int = 0

    var remarks: String = ""

    var useCondition: Int = 0
    
    var useExplain: String = ""


    var useTimeSetting: Int = 0
    
    
    var validTime: Int = 0

    
    required init() {}
}


//// MARK: - AttributesValueItem
//class AttributesValueItem: HandyJSON {
//    var attributesId, attributesValue: String
//
//    init(attributesID: String, attributesValue: String) {
//        self.attributesId = attributesID
//        self.attributesValue = attributesValue
//    }
//}
//
//// MARK: - SpecItem
//class SpecItem: Codable {
//    var finalPrice, isAuto, originalPrice, packingMoney: Int
//    var specID, specName: String
//
//
//    init(finalPrice: Int, isAuto: Int, originalPrice: Int, packingMoney: Int, specID: String, specName: String) {
//        self.finalPrice = finalPrice
//        self.isAuto = isAuto
//        self.originalPrice = originalPrice
//        self.packingMoney = packingMoney
//        self.specID = specID
//        self.specName = specName
//    }
//}



