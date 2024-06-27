//
//  CLAddPackageModel.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2022/2/25.
//

import SwiftyJSON

class CLAddPackageModel: CLSwiftyJSONAble {
    var addPackageId:String
//    加量包id

    var buyLimit :String
//    限购次数

    var buyStatus:Bool
//    购买状态 是否可买

    var discount:String
//    折扣

    var discountAmt:String
//    优惠价

    var faceValue:String
//    单张面值

    var memberCardRuleId:String
//    权益id

    var originalAmt:String
//    原价

    var packageNum:String
//    张数

    var ruleContent:String
//    规则说明（仅在加量包购买详情页面中使用）

    var ruleDetail :String
//    加量包详情（仅在加量包购买详情页面中使用）
    required init?(jsonData: JSON) {

        addPackageId = jsonData["addPackageId"].stringValue
        buyLimit = jsonData["buyLimit"].stringValue
        buyStatus = jsonData["buyStatus"].boolValue
        discount = jsonData["discount"].stringValue
        discountAmt = jsonData["discountAmt"].stringValue
        faceValue = jsonData["faceValue"].stringValue
        memberCardRuleId = jsonData["memberCardRuleId"].stringValue
        originalAmt = jsonData["originalAmt"].stringValue
        packageNum = jsonData["packageNum"].stringValue
        ruleContent = jsonData["ruleContent"].stringValue
        ruleDetail  = jsonData["ruleDetail"].stringValue
    }

}
