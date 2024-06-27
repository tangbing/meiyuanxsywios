//
//  TBHomeDeliverHeaderViewModel.swift
//  MeiYuanXSYW
//
//  Created by Tb on 2022/3/2.
//

import Foundation
import SwiftyJSON


class TBHomeDeliverHeaderViewExplosiveRecommendModel: CLSwiftyJSONAble {
    var discount: Double = 0.0
    var goodsId: String = ""
    var goodsName: String = ""
    var goodsType: Int = 0
    var groupp: Int = 0
    var takeout: Int = 0
    var merchantId: String = ""
    var originalPrice: Double = 0.0
    var minPrice: Double = 0.0
    var topPic: String = ""
    
    required init(jsonData: JSON) {
        discount = jsonData["discount"].doubleValue
        goodsId = jsonData["goodsId"].stringValue
        goodsName = jsonData["goodsName"].stringValue
        goodsType = jsonData["goodsType"].intValue
        groupp = jsonData["groupp"].intValue
        takeout = jsonData["takeout"].intValue
        merchantId = jsonData["merchantId"].stringValue
        originalPrice = jsonData["originalPrice"].doubleValue
        minPrice = jsonData["minPrice"].doubleValue
        topPic = jsonData["topPic"].stringValue


        
    }
}
