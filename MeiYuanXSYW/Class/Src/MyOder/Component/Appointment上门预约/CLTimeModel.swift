//
//  CLTimeModel.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2022/2/10.
//

import Foundation
import SwiftyJSON

class CLTimeModel: CLSwiftyJSONAble {

    var sendImmediatelyTime:String
    var distributionAmt :Double
    var merchantId:String
    var timeVOList:[TimeVOListModel]
    
    required init?(jsonData: JSON) {
        sendImmediatelyTime = jsonData["sendImmediatelyTime"].stringValue
        distributionAmt = jsonData["distributionAmt"].doubleValue
        merchantId = jsonData["merchantId"].stringValue
        timeVOList = jsonData["timeVOList"].arrayValue.map{
            return TimeVOListModel.init(jsonData: $0)!
        }
    }
}

class TimeVOListModel:CLSwiftyJSONAble{
    var weekStr :String
    var timeList:[String]
    
    required init?(jsonData: JSON) {
        weekStr  = jsonData["weekStr"].stringValue
        timeList = jsonData["timeList"].arrayValue.map{
            return $0.stringValue
        }
    }
}

