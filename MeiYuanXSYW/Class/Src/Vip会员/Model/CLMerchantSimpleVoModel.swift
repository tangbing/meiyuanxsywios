//
//  CLMerchantSimpleVoModel.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2022/2/28.
//

import UIKit
import SwiftyJSON

class CLMerchantSimpleVoModel: CLSwiftyJSONAble {
    var avgPrice:String
    var commentScore:String
    var deliveryTime:String
    var distance:String
    var distributionAmt:String
    var merchantId:String
    var merchantLogo:String
    var merchantName:String
    var merchantPhone:String
    var minPrice:String
    var monthlySales:String
    var rankInfo:String
    var upAmt:String
    var privateChef:Int
    var takeout:Int
    var groupp:Int
    
    required init?(jsonData: JSON) {
        avgPrice = jsonData["avgPrice"].stringValue
        commentScore = jsonData["commentScore"].stringValue
        deliveryTime = jsonData["deliveryTime"].stringValue
        distance = jsonData["distance"].stringValue
        distributionAmt = jsonData["distributionAmt"].stringValue
        merchantId = jsonData["merchantId"].stringValue
        merchantLogo = jsonData["merchantLogo"].stringValue
        merchantName = jsonData["merchantName"].stringValue
        merchantPhone = jsonData["merchantPhone"].stringValue
        minPrice = jsonData["minPrice"].stringValue
        monthlySales = jsonData["monthlySales"].stringValue
        rankInfo = jsonData["rankInfo"].stringValue
        upAmt = jsonData["upAmt"].stringValue

        privateChef = jsonData["privateChef"].intValue
        takeout = jsonData["takeout"].intValue
        groupp = jsonData["groupp"].intValue

    }
}
