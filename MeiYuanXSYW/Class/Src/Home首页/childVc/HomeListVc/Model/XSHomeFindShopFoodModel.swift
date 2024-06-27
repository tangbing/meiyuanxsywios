//
//  XSHomeFindShopFoodModel.swift
//  MeiYuanXSYW
//
//  Created by Tb on 2022/3/3.
//

import Foundation
import HandyJSON

/*
 XSHomeFindShopFoodModel
 */
struct XSHomeFindFoodModel: HandyJSON {
    var code: Int = 0
    var count: Int = 0
    var data: [XSHomeFindFoodData] = [XSHomeFindFoodData]()
}



struct XSHomeFindFoodData: HandyJSON {
    var businessType: String = ""
    var discountRate: NSNumber = 0
    var distance: NSNumber = 0
    var goodsId: String = ""
    var goodsName: String = ""
    var goodsType: Int = 0
    var merchantAddress: String = ""
    var merchantId: String = ""
    var merchantLogo: String = ""
    var minPrice: NSNumber = 0
    var originalPrice: NSNumber = 0
    var picAddress: String = ""
    var praise: NSNumber = 0
    var tagName: String = ""
    var topPic: String = ""
    
}

enum XSHomeFindShopFoodViewModelStyle {
    /// 外卖
    case delieve
    /// 到店
    case groupBuy
    /// 私厨
    case privateKit
    /// 聚合
    case other
}

struct XSHomeFindShopFoodModel: HandyJSON {
    var code: Int = 0
    var count: Int = 0
    var data: [XSHomeFindShopFoodData] = [XSHomeFindShopFoodData]()
    
}

struct XSHomeFindShopFoodData: HandyJSON {
       /// 业务类型（0：商家加商品，1：单商家 2：单商品 3：优惠券）
       var bizType: Int = 0
       /// 优惠券金额
       var couponAmount: NSNumber = 0
       /// 配送时间
       var deliveryTime: Int = 0
       var details: [Detail] = [Detail]()
       /// 折扣率
       var discountRate: NSNumber = 0
       var distance: NSNumber = 0
       /// 好评率
       var favorableRate: Int = 0
       var finalPrice: NSNumber = 0
       var goodsId: String = ""
       var goodsName: String = ""
       var goodsPic: String = ""
       /// 0:外卖;1:团购;2:私厨;5:代金券
       var goodsType: Int = 0
       /// 团购业务(0:未开通;1:已开通;2:已关闭)
       var group: Int = 0
       var merchantId: String = ""
       var merchantLogo: String = ""
       var merchantName: String = ""
       /// 月销
       var monthlySales: Int = 0
       var originalPrice: NSNumber = 0
        /// 人均消费
       var perCapita: Int = 0
       /// 私厨业务(0:未开通;1:已开通;2:已关闭)
       var privateChef: Int = 0
       /// 商家评分
       var score: NSNumber = 0
        /// 起送费
       var startDelivery: Int = 0
       var tagName: [String] = [String]()
       /// 外卖业务(0:未开通;1:已开通;2:已关闭)
       var takeout: Int = 0
       /// 商品主图
       var topPic: String = ""
    
       var style: XSHomeFindShopFoodViewModelStyle = .delieve
    
    
    var cellHeight: CGFloat {
        let name = (bizType != 2 ? merchantName : goodsName)
        
        let nameH: CGFloat = name.jk.heightAccording(width: homeW - 10, font: MYBlodFont(size: 14))
        let commonH = homeW * 0.75 + nameH + kFindMargin
        
        switch style {
        case .privateKit:
            if bizType == 0 {
                return commonH + 15 + kFindMargin + kFindViewH + 10
            }
            return commonH + 10 + kFindMargin + kFindViewH
        case .delieve:
            if bizType == 0 {
                return commonH + (kFindMargin + kFindViewH) * 2 + kFindMargin + kshopProductViewH + 10
            }
            return commonH + (kFindMargin + kFindViewH) * 2 + 10
        case .groupBuy:
            if bizType == 0 {
                return commonH + kFindMargin * 2 + kFindViewH + kFindTipImageH + 10
            }
            return commonH + (kFindMargin + kFindViewH) * 2 + 10
        case .other:
            if bizType == 0 {
                return commonH + (kFindMargin + kFindViewH ) * 3 + kFindMargin + kshopProductViewH + 10
            }
            return commonH + (kFindMargin + kFindViewH ) * 2 + 10 + kFindViewH
        }
    }
    
    // 在1.8.0版本之后，HandyJSON提供了didFinishMapping函数作为观察逻辑的切入点
    mutating func didFinishMapping() {
        
        if ((takeout == 1 && group == 1) ||
            (takeout == 1 && privateChef == 1) ||
            (group == 1 && privateChef == 1) ||
            (group == 1 && privateChef == 1 && takeout == 1)) {
                style = .other
        }else if(group == 1){
            style = .groupBuy
        } else if(privateChef == 1) {
            style = .privateKit
        } else {
            style = .delieve
        }
    }
    
}


struct XSHomeFindShopFoodDetail: HandyJSON {
    var finalPrice: NSNumber = 0
    var goodsId: String = ""
    var goodsName: String = ""
    var goodsType: Int = 0
    var originalPrice: NSNumber = 0
    var topPic: String = ""
}
