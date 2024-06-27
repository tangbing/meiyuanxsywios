//
//  CLUserBrowseRecordModel.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2022/3/2.
//

import UIKit
import SwiftyJSON

class CLUserBrowseRecordModel: CLSwiftyJSONAble {
    var browseDate :String
    var goodsList:[CLGoodListModel]
    
    required init?(jsonData: JSON) {
        browseDate = jsonData["browseDate"].stringValue
        goodsList =  jsonData["goodsList"].arrayValue.compactMap{
            return CLGoodListModel.init(jsonData:$0)
        }
    }

}
class CLGoodListModel:CLSwiftyJSONAble {
    var goodsId:String
    var goodsName:String
    var goodsType:Int
    var minPrice:String
    var originalPrice:String
    var praise:String
    var topPic:String
    
    required init?(jsonData: JSON) {
        goodsId = jsonData["goodsId"].stringValue
        goodsName = jsonData["goodsName"].stringValue
        goodsType = jsonData["goodsType"].intValue
        minPrice = jsonData["minPrice"].stringValue
        originalPrice = jsonData["originalPrice"].stringValue
        praise = jsonData["praise"].stringValue
        topPic = jsonData["topPic"].stringValue

    }
}
