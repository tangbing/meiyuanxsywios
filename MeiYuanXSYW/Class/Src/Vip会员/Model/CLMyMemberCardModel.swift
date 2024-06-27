//
//  CLMyMemberCardModel.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2022/3/1.
//

import SwiftyJSON

class CLMyMemberCardModel: CLSwiftyJSONAble {
    var couponHistoryVoList:[CLCouponListModel]
    var headImg:String
    var memberBeginDate:String
    var memberStatus:Int
//    会员状态 0 未购买 1会员 2已失效
    var monthDiscountAmt:String
    var nickname:String
    var remainingCouponNum:String
    var timeoutDate:String
    var totalCouponNum:String
    var userId:Int
    var userMobile:String
    
    required init?(jsonData: JSON) {
        couponHistoryVoList = jsonData["couponHistoryVoList"].arrayValue.compactMap{
            return CLCouponListModel.init(jsonData: $0)
        }
        headImg = jsonData["headImg"].stringValue
        memberBeginDate = jsonData["memberBeginDate"].stringValue
        memberStatus = jsonData["memberStatus"].intValue
    //    会员状态 0 未购买 1会员 2已失效
        monthDiscountAmt = jsonData["monthDiscountAmt"].stringValue
        nickname = jsonData["nickname"].stringValue
        remainingCouponNum = jsonData["remainingCouponNum"].stringValue
        timeoutDate = jsonData["timeoutDate"].stringValue
        totalCouponNum = jsonData["totalCouponNum"].stringValue
        userId = jsonData["userId"].intValue
        userMobile = jsonData["userMobile"].stringValue
    }

}
