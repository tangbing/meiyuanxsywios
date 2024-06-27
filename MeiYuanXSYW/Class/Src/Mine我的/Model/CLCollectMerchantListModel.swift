//
//  CLCollectMerchantListModel.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2022/3/1.
//

import UIKit
import SwiftyJSON

class CLCollectMerchantListModel: CLSwiftyJSONAble {
    var avgPrice:String
    var commentScore:String
//    var commonCouponVos
    var deliveryTime:String
    var details:[CLGoodsDetailsVo]
    var distance:String
    var distributionAmt:String
    var groupp:Int
    var joinUpCoupon:Bool
    var merchantId:String
    var merchantLat:Double
    var merchantLng:Double
    var merchantLogo:String
    var merchantName:String
    var merchantPhone:String
    var minPrice:String
    var monthlySales:String
    var privateChef:Int
    var takeout:Int
    
    required init?(jsonData: JSON) {
        avgPrice = jsonData["avgPrice"].stringValue
        commentScore = jsonData["commentScore"].stringValue
        deliveryTime = jsonData["deliveryTime"].stringValue
        details = jsonData["details"].arrayValue.compactMap{
            return CLGoodsDetailsVo.init(jsonData: $0)
        }

        distance = jsonData["distance"].stringValue
        distributionAmt = jsonData["distributionAmt"].stringValue
        groupp = jsonData["groupp"].intValue
        joinUpCoupon = jsonData["joinUpCoupon"].boolValue
        merchantId = jsonData["merchantId"].stringValue
        merchantLat = jsonData["merchantLat"].doubleValue
        merchantLng = jsonData["merchantLng"].doubleValue
        merchantLogo = jsonData["merchantLogo"].stringValue
        merchantName = jsonData["merchantName"].stringValue
        merchantPhone = jsonData["merchantPhone"].stringValue
        minPrice = jsonData["minPrice"].stringValue
        monthlySales = jsonData["monthlySales"].stringValue
        privateChef = jsonData["privateChef"].intValue
        takeout = jsonData["takeout"].intValue
    }
}


class CLCommonCouponVos:CLSwiftyJSONAble {
    
    required init?(jsonData: JSON) {
        
    }
}

class CLGoodsDetailsVo:CLSwiftyJSONAble {
    
    var goodsId:String
    var goodsName:String
    var merchantId:String
    var minPrice:String
    var originalPrice:String
    var picAddress:String
    var topPic:String
    
    required init?(jsonData: JSON) {
        goodsId = jsonData["goodsId"].stringValue
        goodsName = jsonData["goodsName"].stringValue
        merchantId = jsonData["merchantId"].stringValue
        minPrice = jsonData["minPrice"].stringValue
        originalPrice = jsonData["originalPrice"].stringValue
        picAddress = jsonData["picAddress"].stringValue
        topPic = jsonData["topPic"].stringValue

    }
}
