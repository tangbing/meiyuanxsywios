//
//  CLCenterDataModel.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2022/3/3.
//

import UIKit
import SwiftyJSON
class CLCenterDataModel: CLSwiftyJSONAble {
    var browseGoodsNum:String
//    浏览商品数

    var collectGoodsNum:String
//    收藏商品数

    var collectMerchantNum:String
//    收藏商家数

    var couponNum:String
//    红包卡券数

    var returnServiceNum:String
//    退款售后数

    var waitCommentNum:String
//    待评价数

    var waitDistributionNum:String
//    待发货数

    var waitPayNum:String
//    待付款数

    var waitReceiveNum:String
//    待收货数
    required init?(jsonData: JSON) {
        browseGoodsNum = jsonData["browseGoodsNum"].stringValue
        collectGoodsNum = jsonData["collectGoodsNum"].stringValue
        collectMerchantNum = jsonData["collectMerchantNum"].stringValue
        couponNum = jsonData["couponNum"].stringValue
        returnServiceNum = jsonData["returnServiceNum"].stringValue
        waitCommentNum = jsonData["waitCommentNum"].stringValue
        waitDistributionNum = jsonData["waitDistributionNum"].stringValue
        waitPayNum = jsonData["waitPayNum"].stringValue
        waitReceiveNum = jsonData["waitReceiveNum"].stringValue

    }

}
