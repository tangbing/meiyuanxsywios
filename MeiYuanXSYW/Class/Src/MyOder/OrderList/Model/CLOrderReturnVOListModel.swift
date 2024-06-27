//
//  CLOrderReturnVOListModel.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/22.
//

import UIKit
import SwiftyJSON
class CLOrderReturnVOListModel: CLSwiftyJSONAble {
    var applyTime:String
//    申请时间
    var bizType:Int
//    业务类型
    var biztypeOrderSn:String
//    业务订单编号
    var certificate:String
//    凭证
    var distributionReason:String
//配送不满意原因。0配送员服务恶劣1外卖乱放2残损严重3超时15分钟以上4超时30分钟以上5超时1小时以上
    var goodsProblem:String
//    食品问题说明
    var handleMan:String
//    处理人
    var handleRemark:String
//    处理说明
    var handleTime:String
//    处理时间
    var id:Int
    var merchantId:String
//    商家ID
    var merchantName:String
//    商家名称
    var merchantOrderSn:String
//    商家订单编号
    var orderRemark:String
//    订单备注
    var orderReturnGoodsDetailVOList:[CLOrderReturnGoodsDetailVOListModel]
    var orderServiceLogVOList:[CLOrderServiceLogVOListModel]
    var orderSn:String
//    订单编号
    var orderTime :String
//    下单时间
    var otherAdd:String
//    其他补充
    var payWay:String
//    支付方式
    var returnAmt:Double
//    退款金额
    var returnReason:String
//    退款原因
    var returnSn:String
//    退款流水
    var returnStatus:Int
//    退款状态。0退款审核中，1退款申请被驳回，2退款中，3退款成功
    var returnWay:String
//    退款方式
    var serviceSn:String
//    售后单号
    var userId:Int
//    用户ID
    var userName:String
//    用户姓名
    
    required init?(jsonData: JSON) {
        applyTime = jsonData["applyTime"].stringValue
        bizType = jsonData["bizType"].intValue
        biztypeOrderSn = jsonData["biztypeOrderSn"].stringValue
        certificate = jsonData["certificate"].stringValue
        distributionReason = jsonData["distributionReason"].stringValue
        goodsProblem = jsonData["goodsProblem"].stringValue
        handleMan = jsonData["handleMan"].stringValue
        handleRemark = jsonData["handleRemark"].stringValue
        handleTime = jsonData["handleTime"].stringValue
        id = jsonData["id"].intValue
        merchantId = jsonData["merchantId"].stringValue
        merchantName = jsonData["merchantName"].stringValue
        merchantOrderSn = jsonData["merchantOrderSn"].stringValue
        orderRemark = jsonData["orderRemark"].stringValue
        orderReturnGoodsDetailVOList =  jsonData["orderReturnGoodsDetailVOList"].arrayValue.map{
            return CLOrderReturnGoodsDetailVOListModel.init(jsonData: $0)!
        }
        orderServiceLogVOList = jsonData["orderServiceLogVOList"].arrayValue.map{
            return CLOrderServiceLogVOListModel.init(jsonData: $0)!
        }
        orderSn = jsonData["orderSn"].stringValue
        orderTime = jsonData["orderTime"].stringValue
        otherAdd = jsonData["otherAdd"].stringValue
        payWay = jsonData["payWay"].stringValue
        returnAmt = jsonData["returnAmt"].doubleValue
        returnReason = jsonData["returnReason"].stringValue
        returnSn = jsonData["returnSn"].stringValue
        returnStatus = jsonData["returnStatus"].intValue
        returnWay = jsonData["returnWay"].stringValue
        serviceSn = jsonData["serviceSn"].stringValue
        userId = jsonData["userId"].intValue
        userName = jsonData["userName"].stringValue
    }
}
