//
//  XSHomeSearchModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2022/2/16.
//

import Foundation
import HandyJSON
import SwiftyJSON

struct XSHomeMerchantSearchModel: HandyJSON {
    var code: Int = 0
    var count: Int = 0
    var data: [XSHomeMerchantData] = [XSHomeMerchantData]()
    
}

struct XSHomeMerchantData: HandyJSON {
    var commonCouponVos: [CommonCouponVo]?
    var merchantCFullReduceVoList: [MerchantCFullReduceVoList]?

    /// 配送费
    var deliveryFee: NSNumber = 0
    /// 配送时间 单位：分钟
    var deliveryTime: Int = 0
    /// 商品详情数据集合
    var details: [Detail] = [Detail]()
    var distance: Int = 0
    /// 团购业务(0:未开通;1:已开通;2:已关闭)
    var group: Int = 0
    var merchantId: String = ""
    var merchantName: String = ""
    var merchantLogo: String = ""
    /// 商家评分
    var merchantScore: Int = 0
    /// 月销
    var monthlySales: Int = 0
    /// 人均消费
    var perCapita: Int = 0
    /// 私厨业务(0:未开通;1:已开通;2:已关闭)
    var privateChef: Int = 0
    /// 点评榜单
    var reviews: String = ""
    /// 起送费
    var startDelivery: NSNumber = 0
    /// <##>外卖业务(0:未开通;1:已开通;2:已关闭)
    var takeout: Int = 0
    /// 商家标签
    var tagName: [String] = [String]()
    var joinUpCoupon: Bool = false
    /// 新客立减
    var newCustomerReduce: NSNumber = 0
}

struct XSHomeMerchantDetails: HandyJSON {
    var goodsId: String = ""
    var goodsName: String = ""
    var minPrice: NSNumber = 0
    var originalPrice: NSNumber = 0
    var picAddress: String = ""
    var topPic: String = ""
}



struct XSHomeGoodsSearchModel: HandyJSON {
    var code: Int = 0
    var count: Int = 0
    var data: [XSHomeGoodsSearchData] = [XSHomeGoodsSearchData]()
}

class XSHomeGoodsSearchData: HandyJSON, CLSwiftyJSONAble {
    required init() {}
    
    /// 配送时间 单位：分钟
    var deliveryTime: Int = 0
    /// 折扣率
    var discountRate: String = ""
    var distance: Int = 0
    var goodsId: String = ""
    var goodsName: String = ""
    /// 商品类型(0:外卖;1:团购;2:私厨)
    var goodsType: Int = 0
    var merchantAddress: String = ""
    var merchantId: String = ""
    var merchantLogo: String = ""
    var merchantName: String = ""
    var minPrice: String = ""
    var originalPrice: String = ""
    /// 好评率
    var praise: String = ""
    /// 商家标签
    var tagName: String = ""
    var topPic: String = ""
    
    
    required init?(jsonData: JSON) {
        
        deliveryTime = jsonData["deliveryTime"].intValue
        discountRate = jsonData["discountRate"].stringValue
        distance = jsonData["distance"].intValue
        goodsId = jsonData["goodsId"].stringValue
        goodsName = jsonData["goodsName"].stringValue
        goodsType = jsonData["goodsType"].intValue
        merchantAddress = jsonData["merchantAddress"].stringValue
        merchantId = jsonData["merchantId"].stringValue
        merchantLogo = jsonData["merchantLogo"].stringValue
        merchantName = jsonData["merchantName"].stringValue
        
        minPrice = jsonData["minPrice"].stringValue
        originalPrice = jsonData["originalPrice"].stringValue
        praise = jsonData["praise"].stringValue
        
        tagName = jsonData["tagName"].stringValue
        topPic = jsonData["topPic"].stringValue
        
        
    }
}


//class XSHomeBottomGoodsSearchData: CLSwiftyJSONAble {
//    /// 配送时间 单位：分钟
//    var deliveryTime: Int = 0
//    /// 折扣率
//    var discountRate: Double = 0
//    var distance: Int = 0
//    var goodsId: String = ""
//    var goodsName: String = ""
//    /// 商品类型(0:外卖;1:团购;2:私厨)
//    var goodsType: Int = 0
//    var merchantAddress: String = ""
//    var merchantId: String = ""
//    var merchantLogo: String = ""
//    var merchantName: String = ""
//    var minPrice: Double = 0
//    var originalPrice: Double = 0
//    /// 好评率
//    var praise: Double = 0
//    /// 商家标签
//    var tagName: String = ""
//    var topPic: String = ""
//
//
//
//
//}
