//
//  CLOrderCommentModel.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2022/2/17.
//

import UIKit
import SwiftyJSON

class CLOrderCommentModel: CLSwiftyJSONAble {
    var goodsDetailList:[CLGoodsDetailList]
    var merchantId:String
    var merchantLog:String
    var merchantName:String
    required init?(jsonData: JSON) {
        goodsDetailList = jsonData["goodsDetailList"].arrayValue.map{
            return CLGoodsDetailList.init(jsonData: $0)!
        }
        merchantId = jsonData["merchantId"].stringValue
        merchantLog = jsonData["merchantLog"].stringValue
        merchantName = jsonData["merchantName"].stringValue
    }
}


class CLGoodsDetailList:CLSwiftyJSONAble {
    var goodsId:String
    var goodsName:String
    var topPic:String
    required init?(jsonData: JSON) {
        goodsId = jsonData["goodsId"].stringValue
        goodsName = jsonData["goodsName"].stringValue
        topPic = jsonData["topPic"].stringValue
    }
}

class CLOtherGetCommentVOList :CLSwiftyJSONAble {
    var merchantId:String
    var merchantLog:String
    var merchantName:String
    var merchantOrderSn:String
    var receiveGoodsTime:String

    required init?(jsonData: JSON) {
        self.merchantId = jsonData["merchantId"].stringValue
        self.merchantLog = jsonData["merchantLog"].stringValue
        self.merchantName = jsonData["merchantName"].stringValue
        self.merchantOrderSn = jsonData["merchantOrderSn"].stringValue
        self.receiveGoodsTime = jsonData["receiveGoodsTime"].stringValue

    }
}
