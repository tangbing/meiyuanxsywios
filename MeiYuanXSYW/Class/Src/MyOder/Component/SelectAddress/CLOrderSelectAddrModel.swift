//
//  CLOrderSelectAddrModel.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2022/2/10.
//

import UIKit
import SwiftyJSON

class CLOrderSelectAddrModel: CLSwiftyJSONAble {
    
    var id:Int
    var receiverName :String
    var receiverSex:Int
    var receiverPhone:String
    var receiverProvince:String
    var receiverCity:String
    var receiverRegion: String
    var receiverDetailAddress:String
    var isDefaultAddress:Bool
    var canDistribution:Bool
    
    var lat :Double
    var lnt :Double
    var userId:Int
    var receiverLabel:Int
    
    required init?(jsonData: JSON) {
        id = jsonData["id"].intValue
        receiverName = jsonData["receiverName"].stringValue
        receiverSex = jsonData["receiverSex"].intValue
        receiverPhone = jsonData["receiverPhone"].stringValue
        receiverProvince = jsonData["receiverProvince"].stringValue
        receiverCity = jsonData["receiverCity"].stringValue
        receiverRegion = jsonData["receiverRegion"].stringValue
        receiverDetailAddress = jsonData["receiverDetailAddress"].stringValue
        isDefaultAddress = jsonData["isDefaultAddress"].boolValue
        canDistribution = jsonData["canDistribution"].boolValue
        
        lat = jsonData["lat"].doubleValue
        lnt = jsonData["lnt"].doubleValue
        userId = jsonData["userId"].intValue
        receiverLabel = jsonData["receiverLabel"].intValue

    }
}


