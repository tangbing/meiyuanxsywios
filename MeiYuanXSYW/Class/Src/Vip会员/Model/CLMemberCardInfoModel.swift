//
//  CLMemberCardInfoModel.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2022/2/28.
//

import UIKit
import SwiftyJSON

class CLMemberCardInfoModel: CLSwiftyJSONAble {
    
    var couponHistoryVoList:[CLCouponListModel]
    var headImg:String
    var memberBeginDate:String
    var memberCardVo:[CLMemberCardVo]
    var timeoutDate:String
    var userId:String
    var userMobile:String
    var validDate:String

    
    required init?(jsonData: JSON) {
        couponHistoryVoList = jsonData["couponHistoryVoList"].arrayValue.compactMap{
            return CLCouponListModel.init(jsonData: $0)
        }
        headImg = jsonData["headImg"].stringValue
        memberBeginDate = jsonData["memberBeginDate"].stringValue
        memberCardVo = jsonData["memberCardVo"].arrayValue.compactMap{
            return CLMemberCardVo.init(jsonData: $0)
        }
        timeoutDate = jsonData["timeoutDate"].stringValue
        userId = jsonData["userId"].stringValue
        userMobile = jsonData["userMobile"].stringValue
        validDate = jsonData["validDate"].stringValue
        
    }

}
