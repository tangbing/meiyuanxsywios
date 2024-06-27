//
//  CLMemberUserInfoModel.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2022/2/22.
//

import Foundation
import SwiftyJSON
import HandyJSON

class CLMemberUserInfoModel: CLSwiftyJSONAble {
    var amount:String
    var giveNum:String
    var headImg:String
    var memberBeginDate:String
    var memberCardCouponPrice:String
    var memberCardVo:CLMemberCardVo
    var memberStatus:String
    var mobile:String
    var nearTimeoutDay:String
    var nearTimeoutNum:String
    var nextAmount:String
    var nextGiveNum:String
    var nextMonthDate:String
    var timeoutDate:String
    var userId:String
    
    required init(jsonData:JSON) {
        amount = jsonData["amount"].stringValue
        giveNum = jsonData["giveNum"].stringValue
        headImg = jsonData["headImg"].stringValue
        memberBeginDate = jsonData["memberBeginDate"].stringValue
        memberCardCouponPrice = jsonData["memberCardCouponPrice"].stringValue
        memberCardVo = CLMemberCardVo.init(jsonData: jsonData["memberCardVo"])!
        memberStatus = jsonData["memberStatus"].stringValue
        mobile = jsonData["mobile"].stringValue
        nearTimeoutDay = jsonData["nearTimeoutDay"].stringValue
        nearTimeoutNum = jsonData["nearTimeoutNum"].stringValue
        nextAmount = jsonData["nextAmount"].stringValue
        nextGiveNum = jsonData["nextGiveNum"].stringValue
        nextMonthDate = jsonData["nextMonthDate"].stringValue
        timeoutDate = jsonData["timeoutDate"].stringValue
        userId = jsonData["userId"].stringValue
    }
}

class CLMemberCardVo:CLSwiftyJSONAble{
    var couponId:String
    var memberCardId:String
    var memberCardName:String
    var originalPrice:String
    var price:String
    var ruleGiveNum:String
    var ruleValue:String
    var state:String
    var validTime:String
    var validTimeUnit:String
    
    required init?(jsonData: JSON) {
        couponId = jsonData["couponId"].stringValue
        memberCardId = jsonData["memberCardId"].stringValue
        memberCardName = jsonData["memberCardName"].stringValue
        originalPrice = jsonData["originalPrice"].stringValue
        price = jsonData["price"].stringValue
        ruleGiveNum = jsonData["ruleGiveNum"].stringValue
        ruleValue = jsonData["ruleValue"].stringValue
        state = jsonData["state"].stringValue
        validTime = jsonData["validTime"].stringValue
        validTimeUnit = jsonData["validTimeUnit"].stringValue
    }

}
