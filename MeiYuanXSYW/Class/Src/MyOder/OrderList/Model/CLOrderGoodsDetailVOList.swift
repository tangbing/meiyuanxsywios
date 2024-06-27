//
//  CLOrderGoodsDetailVOList.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/22.
//

import UIKit
import SwiftyJSON

class CLOrderGoodsDetailVOList:CLSwiftyJSONAble{

    var goodNum:Int = 0
    var account:String
//    商品数量
    var activityPrice:Double
//    商品活动价格
    var biztypeOrderSn:String
//    业务订单编号
    var createBy:String
//    创建人
    var createTime:String
//    创建时间
    var discount:String
//    商品折扣
    var discountRate:String
//    商品折扣
    var goodsId:String
//    商品图片
    var topPic:String
//    商品ID
    var goodsName:String
//    商品名称
    var goodsType:Int
//    商品类型 0菜品 1团购套餐券 2代金券
    var id :Int
    var merchantId:String
//    商家ID
    var merchantName:String
//    商家名称
    var merchantOrderSn:String
//    商家订单编号
    var moreDiscountPrice:Double
//    多件折扣的单价
    var moreDiscountRate:Double
//    多件折扣折扣率

    var orderGroupDetailVOList:[CLOrderGroupDetailVOList]
    var orderSn:String
//    使用规则
    var orderUseRuleVO :CLOrderUseRuleVOModel
    var orderVoucherVerificationVOList:[CLOrderVoucherVerificationVOListModel]
    var originalPrice:Double
//    商品原始价格
    var packetAmt:Double
//    包装费
    var salePrice:Double
//    销售价（团购套餐和代金券有）
    var shareAmt:Double
//    单个商品分摊后金额
    var singleDiscountPrice:Double
//    单件折扣商品价格
    var specNature:String
//    规格属性
    var totalAmt:Double
//    销售价（团购套餐和代金券有）
    var totalShareAmt:Double
//    分摊后金额
    var updateBy :String
//    更新人
    var updateTime:String
//    更新时间
    var voucherAmt:Double
//    代金券金额（只有代金券有）
    var voucherCode:String
//    券码
    var voucherCodePic:String
//    二维码
    
    var groupSnapshot :String
    
    
    required init?(jsonData:JSON) {
        account = jsonData["account"].stringValue
        activityPrice = jsonData["activityPrice"].doubleValue
        biztypeOrderSn = jsonData["biztypeOrderSn"].stringValue
        createBy = jsonData["createBy"].stringValue
        createTime = jsonData["createTime"].stringValue
        discount = jsonData["discount"].stringValue
        discountRate = jsonData["discountRate"].stringValue
        goodsId = jsonData["goodsId"].stringValue
        topPic = jsonData["topPic"].stringValue
        goodsName = jsonData["goodsName"].stringValue
        goodsType = jsonData["goodsType"].intValue
        id  = jsonData["id"].intValue
        merchantId = jsonData["merchantId"].stringValue
        merchantName = jsonData["merchantName"].stringValue
        merchantOrderSn = jsonData["merchantOrderSn"].stringValue
        moreDiscountPrice = jsonData["moreDiscountPrice"].doubleValue
        moreDiscountRate = jsonData["moreDiscountRate"].doubleValue
        orderSn = jsonData["orderSn"].stringValue
        orderGroupDetailVOList = jsonData["orderGroupDetailVOList"].arrayValue.map{
            return CLOrderGroupDetailVOList.init(jsonData: $0)!
        }
        orderUseRuleVO =  CLOrderUseRuleVOModel.init(jsonData: jsonData["orderGroupDetailVOList"])
        orderVoucherVerificationVOList = jsonData["orderVoucherVerificationVOList"].arrayValue.map{
           return CLOrderVoucherVerificationVOListModel.init(jsonData: $0)!
        }
        originalPrice = jsonData["originalPrice"].doubleValue
        packetAmt = jsonData["packetAmt"].doubleValue
        salePrice = jsonData["salePrice"].doubleValue
        shareAmt = jsonData["shareAmt"].doubleValue
        singleDiscountPrice = jsonData["singleDiscountPrice"].doubleValue
        specNature = jsonData["specNature"].stringValue
        totalAmt = jsonData["totalAmt"].doubleValue
        totalShareAmt = jsonData["totalShareAmt"].doubleValue
        updateBy  = jsonData["updateBy"].stringValue
        updateTime = jsonData["updateTime"].stringValue
        voucherAmt = jsonData["voucherAmt"].doubleValue
        voucherCode = jsonData["voucherCode"].stringValue
        voucherCodePic = jsonData["voucherCodePic"].stringValue
        groupSnapshot = jsonData["groupSnapshot"].stringValue
    }
}

class CLGroupSnapshot:CLSwiftyJSONAble {
    var holidayUse:Bool
    var weekendUse:Bool
    var saleBeginDate:String
    var saleEndDate:String
    var sideLetter:String
    var useTime :String
    var goodsPackageVos:[CLGoodsPackageVos]
    required init?(jsonData: JSON) {
        holidayUse = jsonData["holidayUse"].boolValue
        weekendUse = jsonData["weekendUse"].boolValue
        saleBeginDate = jsonData["saleBeginDate"].stringValue
        saleEndDate = jsonData["saleEndDate"].stringValue
        sideLetter = jsonData["sideLetter"].stringValue
        useTime = jsonData["useTime"].stringValue
        goodsPackageVos = jsonData["goodsPackageVos"].arrayValue.map{
            return CLGoodsPackageVos.init(jsonData: $0)!
         }
    }
}

class CLGoodsPackageVos:CLSwiftyJSONAble{
    var packageName :String
    var goodsPackageItemVos:[CLGoodsPackageItemVos]

    required init?(jsonData: JSON) {
        packageName = jsonData["packageName"].stringValue
        goodsPackageItemVos = jsonData["goodsPackageItemVos"].arrayValue.map{
            return CLGoodsPackageItemVos.init(jsonData: $0)!
         }
    }
}

class CLGoodsPackageItemVos:CLSwiftyJSONAble{
    var itemName:String
    var showPrice:String
    var itemNum:String
    required init?(jsonData: JSON) {
        itemName = jsonData["itemName"].stringValue
        showPrice = jsonData["showPrice"].stringValue
        itemNum = jsonData["itemNum"].stringValue
    }
}

//团购商品套餐
class CLOrderGroupDetailVOList:CLSwiftyJSONAble{
    
    var account:Int
    var goodsIdL:String
    var goodsPrice:Double
    var id:Int
    var itemId : Int
    var itemName:String
    var merchantOrderSn:String
    var totalAmt:Double
    
    required init?(jsonData: JSON) {
        account = jsonData["account"].intValue
        goodsIdL = jsonData["goodsIdL"].stringValue
        goodsPrice = jsonData["goodsPrice"].doubleValue
        id = jsonData["id"].intValue
        itemId = jsonData["itemId"].intValue
        itemName = jsonData["itemName"].stringValue
        merchantOrderSn = jsonData["merchantOrderSn"].stringValue
        totalAmt = jsonData["totalAmt"].doubleValue
    }

}

class CLOrderUseRuleVOModel:CLSwiftyJSONAble{
    var endDate:String
//    结束日期
    var goodsId:String
//    商品ID
    var startDate:String
//    开始日期
    var useProportion:String
//    使用范围
    var useRule:String
//    使用规则
    var useTime:String
//    使用时间
    required init(jsonData:JSON) {
        endDate = jsonData["endDate"].stringValue
        goodsId = jsonData["goodsId"].stringValue
        startDate = jsonData["startDate"].stringValue
        useProportion = jsonData["useProportion"].stringValue
        useRule = jsonData["useRule"].stringValue
        useTime = jsonData["useTime"].stringValue
    }
}
