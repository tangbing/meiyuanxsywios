//
//  CLOrderVoucherVerificationVOListModel.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/22.
//

import UIKit
import SwiftyJSON
//团购代金券和套餐卷码信息
class CLOrderVoucherVerificationVOListModel: CLSwiftyJSONAble {
    var createTime:String
//    创建时间
    var faceValue:Double
//    面值
    var goodsId:String
//    商品ID
    var id:Int
    var isDel:Int
//    0正常1删除
    var merchantId:String
//    核销门店id
    var merchantOrderSn:String
//    商家订单编号
    var operatorId: Int
//    操作人id
    var operatorName:String
//    操作员姓名
//    var orderReturnVO:订单退款{...}
//    orderServiceLogVO    售后日志{...}
    var status:Int
//    0待核销 1已核销 2已过期 3退款中 4退款失败 5已退款
    var topPic:String
//    图片
    var userId:Int
//    下单用户
    var verificationSn:String
//    核销流水号
    var verificationTime:String
//    核销时间
    var voucherAmt:Double
//    代金券金额
    var voucherCode:Int
//    券码
    
    required init?(jsonData: JSON) {
        createTime = jsonData["createTime"].stringValue
        faceValue = jsonData["faceValue"].doubleValue
        goodsId = jsonData["goodsId"].stringValue
        id = jsonData["id"].intValue
        isDel = jsonData["isDel"].intValue
        merchantId = jsonData["merchantId"].stringValue
        merchantOrderSn = jsonData["merchantOrderSn"].stringValue
        operatorId = jsonData["operatorId"].intValue
        operatorName = jsonData["operatorName"].stringValue
        status = jsonData["status"].intValue
        topPic = jsonData["topPic"].stringValue
        userId = jsonData["userId"].intValue
        verificationSn = jsonData["verificationSn"].stringValue
        verificationTime = jsonData["verificationTime"].stringValue
        voucherAmt = jsonData["voucherAmt"].doubleValue
        voucherCode = jsonData["voucherCode"].intValue
    }
}

//退款订单
class CLOrderReturnVOModel :CLSwiftyJSONAble {
    var applyTime:String
//    申请时间
    var bizType:Int
//    业务类型
    var biztypeOrderSn:String
//    业务订单编号
    var certificate:String
//    凭证
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
    var orderTime:String
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
    
    required init?(jsonData: JSON) {
        applyTime = jsonData["applyTime"].stringValue
        bizType = jsonData["bizType"].intValue
        biztypeOrderSn = jsonData["biztypeOrderSn"].stringValue
        certificate = jsonData["certificate"].stringValue
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

//   订单退款商品详情信息

class CLOrderReturnGoodsDetailVOListModel: CLSwiftyJSONAble {
    
    var account:Int
//    商品数量
    var activityPrice:Double
//    商品活动价格

    var biztypeOrderSn:String
//    业务订单编号
    var createBy:String
//    创建人
    var createTime:String
//    创建时间
    var discount:Double
//    商品折扣
    var goodsId:String
//    商品ID
    var goodsName:String
//    商品名称
    var goodsStatus:Int
//    商品状态
    var id:Int
    var merchantId:String
//    商家ID
    var merchantName:String
//    商家名称
    var merchantOrderSn:String
//    商家订单编号
    var moreDiscountPrice:Double
//    多件折扣的单价
    var moreDiscountRate:Double
//    多件折扣折扣率
    var orderSn:String
//    订单编号
    var originalPrice:Double
//    商品原始价格
    var packetAmt:Double
//    包装费
    var returnAccount:Int
//    退款数量
    var shareAmt:Double
//    单个商品分摊后金额
    var singleDiscountPrice: Double
//    单件折扣商品价格
    var specNature:String
//    规格属性
    var totalReturnAmt:Double
//    退款总金额
    var totalShareAmt:Double
//    分摊后金额
    var updateBy:String
//    更新人
    var updateTime:String
//    更新时间
    required init?(jsonData: JSON) {
        account = jsonData["account"].intValue
        activityPrice  = jsonData["activityPrice"].doubleValue
        biztypeOrderSn = jsonData["biztypeOrderSn"].stringValue
        createBy = jsonData["createBy"].stringValue
        createTime = jsonData["createTime"].stringValue
        discount = jsonData["discount"].doubleValue
        goodsId = jsonData["goodsId"].stringValue
        goodsName = jsonData["goodsName"].stringValue
        goodsStatus = jsonData["goodsStatus"].intValue
        id = jsonData["id"].intValue
        merchantId = jsonData["merchantId"].stringValue
        merchantName = jsonData["merchantName"].stringValue
        merchantOrderSn = jsonData["merchantOrderSn"].stringValue
        moreDiscountPrice = jsonData["moreDiscountPrice"].doubleValue
        moreDiscountRate = jsonData["moreDiscountRate"].doubleValue
        orderSn = jsonData["orderSn"].stringValue
        originalPrice = jsonData["originalPrice"].doubleValue
        packetAmt = jsonData["packetAmt"].doubleValue
        returnAccount = jsonData["returnAccount"].intValue
        shareAmt = jsonData["shareAmt"].doubleValue
        singleDiscountPrice = jsonData["singleDiscountPrice"].doubleValue
        specNature = jsonData["specNature"].stringValue
        totalReturnAmt = jsonData["totalReturnAmt"].doubleValue
        totalShareAmt = jsonData["totalShareAmt"].doubleValue
        updateBy = jsonData["updateBy"].stringValue
        updateTime = jsonData["updateTime"].stringValue
    }
}


class CLOrderServiceLogVOListModel:CLSwiftyJSONAble{
    var createBy:String
    var createTime:String
    var id:String
    var operateBy:String
    var operateByType:Int
    var operateRemark:String
    var operateType:Int
    var serviceSn:Int
    var updateBy:String
    var updateTime:String
    
    required init?(jsonData: JSON) {
        createBy = jsonData["createBy"].stringValue
        createTime = jsonData["createTime"].stringValue
        id = jsonData["id"].stringValue
        operateBy = jsonData["operateBy"].stringValue
        operateByType = jsonData["operateByType"].intValue
        operateRemark = jsonData["operateRemark"].stringValue
        operateType = jsonData["operateType"].intValue
        serviceSn = jsonData["serviceSn"].intValue
        updateBy = jsonData["updateBy"].stringValue
        updateTime = jsonData["updateTime"].stringValue
    }
}
