//
//  CLMyCollectGoodsListModel.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2022/3/1.
//

import UIKit
import SwiftyJSON

class CLMyCollectGoodsListModel: CLSwiftyJSONAble {
    var businessType:Int
//    商品类型（0菜品 1团购套餐券 2代金券）

    var deliveryTime:Int
//    配送时间 单位：分钟

    var discountRate:String
//    折扣率

    var distance:String
//    距离

    var goodsId:String
//    商品ID

    var goodsName:String
//    商品名称

    var goodsState:Int
//    商品状态 0正常 1已失效 2已抢完

    var goodsType:Int
//    商品类型（0外卖1私厨2团购）

    var merchantAddress:String
//    商家地址

    var merchantId :String
//    商家ID

    var merchantLogo: String
//    商家logo

    var minPrice:String
//    售价

    var originalPrice:String
//    原价

    var picAddress:String
//    图片地址

    var praise:String
//    好评率

    var tagName:String
//    商品标签

    var topPic:String
//    商品主图

    var userCollectGoodsId:Int
//    收藏商品主键id
    required init?(jsonData: JSON) {
        businessType = jsonData["businessType"].intValue
        deliveryTime = jsonData["deliveryTime"].intValue
        discountRate = jsonData["discountRate"].stringValue
        distance = jsonData["distance"].stringValue
        goodsId = jsonData["goodsId"].stringValue
        goodsName = jsonData["goodsName"].stringValue
        goodsState = jsonData["goodsState"].intValue
        goodsType = jsonData["goodsType"].intValue
        merchantAddress = jsonData["merchantAddress"].stringValue
        merchantId = jsonData["merchantId"].stringValue
        merchantLogo = jsonData["merchantLogo"].stringValue
        minPrice = jsonData["minPrice"].stringValue
        originalPrice = jsonData["originalPrice"].stringValue
        picAddress = jsonData["picAddress"].stringValue
        originalPrice = jsonData["originalPrice"].stringValue
        picAddress = jsonData["picAddress"].stringValue
        praise = jsonData["praise"].stringValue
        tagName = jsonData["tagName"].stringValue
        topPic = jsonData["topPic"].stringValue
        userCollectGoodsId = jsonData["userCollectGoodsId"].intValue
    }
}
