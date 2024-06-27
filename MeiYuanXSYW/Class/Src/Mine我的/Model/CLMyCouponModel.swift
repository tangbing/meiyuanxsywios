//
//  CLMyCouponModel.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2022/3/2.
//

import UIKit
import SwiftyJSON

class CLMyCouponModel: CLSwiftyJSONAble {
    var beginDate: String
    var businessType: String
    var couponCode: String
    var couponId:Int
    var couponName: String
    var couponType: Int
    var discountAmount: String
    var endDate: String
    var fullReductionAmount: String
    var merchantAmount: String
    var merchantId: String
    var merchantImageList: [String]
    var merchantName: String
    var receiveStatus: Int
    var remarks : String
    var useCondition: Int
    var useDate: String
    var useExplain: String
    var useStatus: Int
    var useTimeSetting: Int
    var userId: Int
    var validTime: Int

    
    required init?(jsonData: JSON) {
        beginDate = jsonData["beginDate"].stringValue
        businessType = jsonData["businessType"].stringValue
        couponCode = jsonData["couponCode"].stringValue
        couponId = jsonData["couponId"].intValue
        couponName = jsonData["couponName"].stringValue
        couponType = jsonData["couponType"].intValue
        discountAmount = jsonData["discountAmount"].stringValue
        endDate = jsonData["endDate"].stringValue
        fullReductionAmount = jsonData["fullReductionAmount"].stringValue
        merchantAmount = jsonData["merchantAmount"].stringValue
        merchantId = jsonData["merchantId"].stringValue
        merchantImageList =   jsonData["merchantImageList"].arrayValue.compactMap{
            return $0.stringValue
        }
        merchantName = jsonData["merchantName"].stringValue
        receiveStatus = jsonData["receiveStatus"].intValue
        remarks = jsonData["remarks"].stringValue
        useCondition = jsonData["useCondition"].intValue
        useDate = jsonData["useDate"].stringValue
        useExplain = jsonData["useExplain"].stringValue
        useStatus = jsonData["useStatus"].intValue
        useTimeSetting = jsonData["useTimeSetting"].intValue
        userId = jsonData["userId"].intValue
        useTimeSetting = jsonData["useTimeSetting"].intValue
        validTime = jsonData["validTime"].intValue


    }
}
    
