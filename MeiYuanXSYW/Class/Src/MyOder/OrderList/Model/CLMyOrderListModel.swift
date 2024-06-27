//
//  CLMyOrderListModel.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/20.
//

import SwiftyJSON

enum deliverType {
    case merchentDeliver  //商家配送
    case riderDeliver     //骑手配送
    case takeMyself       //自取
}

enum deliverOrderStatus {
    case waitPay //等待支付
    case waitMerchantReceiverOrder  //等待商家接单
    case waitRiderReceiverOrder //等待骑手接单
    case merchentPrepareMeal //商家备餐中
    case waitTakeMeal //待取餐
    case waitUserTakeMeal //等待自取
    case riderDeliver //骑手配送
    case merchantDeliver // 商家配送
    case waitComment //待评价
    case orderFinish1 //已完成1
    case orderFinish2 //已完成2
    case refundReview // 退款审核中
    case refunding   //退款中
    case refundSuccess //退款成功
    case refundReject  //退款被驳回
    case orderClose //订单关闭
}

enum groupBuyOrderStatus {
    case waitPay    //等待支付
    case orderFinish1 //已完成1
    case orderFinish2 //已完成2
    case refundReview // 退款审核中
    case refunding   //退款中
    case refundSuccess //退款成功
    case refundReject  //退款被驳回
    case orderClose //订单关闭
    case waitUse    //待使用
    case waitComment //待评价
}

enum privateKitchenOrderStatus {
    case waitPay    //等待支付
    case orderFinish1 //已完成1
    case orderFinish2 //已完成2
    case waitComment //待评价
    case refundReview // 退款审核中
    case refunding   //退款中
    case refundSuccess //退款成功
    case refundReject  //退款被驳回
    case orderClose //订单关闭
    case waitAppointment //待预约
    case inservice //服务中
    case DoorToDoorService //待上门服务
}

enum memberOrderStatus {
    case memberCard  //会员卡
    case plusPackage //加量包
}

enum allType {
    case waitPay //待支付
    case orderClose //订单关闭
}

//订单支付
class CLOrderPayInfoVO:CLSwiftyJSONAble{
    var biztypeOrderSn:String
//    业务订单编号
    var id:Int
    var merchantOrderSn:String
//    商家订单编号
    var orderSn:String
//    订单编号
    var payAmt:String
//    支付金额
    var payBizSn:String
//    支付ID
    var payStatus:String
//    支付状态
    var payTime:String
//    支付时间
    var payWay:String
//    支付方式
    var totalAmt:String
//    支付方式
    required init?(jsonData: JSON) {
        biztypeOrderSn = jsonData["biztypeOrderSn"].stringValue
        id = jsonData["id"].intValue
        merchantOrderSn = jsonData["merchantOrderSn"].stringValue
        orderSn = jsonData["orderSn"].stringValue
        payAmt = jsonData["payAmt"].stringValue
        payBizSn = jsonData["payBizSn"].stringValue
        payStatus = jsonData["payStatus"].stringValue
        payTime = jsonData["payTime"].stringValue
        payWay = jsonData["payWay"].stringValue
        totalAmt = jsonData["totalAmt"].stringValue

    }
}


//优惠详情模型
class CLOrderCheapInfoVOListModel:CLSwiftyJSONAble{
    var account:Int
//    活动数量
    var activityCheapAmt:String
//    单个活动优惠金额
    var activityInfo:String
//    活动信息
    var activityName:String
//    活动名称
    var activityType:String
//    活动类型
    var appCheapAmt:Double
//    平台承担金额
    var biztypeOrderSn:String
//    业务订单编号
    var createBy:String
//    创建人
    var createTime:String
//    创建时间
    var  goodsId:String
//    商品ID
    var goodsName:String
//    商品名称
    var id :Int
    var merchantCheapAmt:Double
//    商家承担金额
    var merchantId:String
//    商家ID
    var merchantName:String
//    商家名称
    var merchantOrderSn:String
//    商家订单编号
    var orderSn:String
    var updateBy:String
//    更新人
    var updateTime:String
//    更新时间
    required init?(jsonData:JSON) {
        account = jsonData["account"].intValue
        activityCheapAmt = jsonData["activityCheapAmt"].stringValue
        activityInfo = jsonData["activityInfo"].stringValue
        activityName = jsonData["activityName"].stringValue
        activityType = jsonData["activityType"].stringValue
        appCheapAmt = jsonData["appCheapAmt"].doubleValue
        biztypeOrderSn = jsonData["biztypeOrderSn"].stringValue
        createBy = jsonData["createBy"].stringValue
        createTime = jsonData["createTime"].stringValue
        goodsId = jsonData["goodsId"].stringValue
        goodsName = jsonData["goodsName"].stringValue
        id = jsonData["id"].intValue
        merchantCheapAmt = jsonData["merchantCheapAmt"].doubleValue
        merchantId = jsonData["merchantId"].stringValue
        merchantName = jsonData["merchantName"].stringValue
        merchantOrderSn = jsonData["merchantOrderSn"].stringValue
        orderSn = jsonData["orderSn"].stringValue
        updateBy = jsonData["updateBy"].stringValue
        updateTime = jsonData["updateTime"].stringValue
    }
}


class CLMyOrderListModel: CLSwiftyJSONAble {
    var arriveTime:String
    //送达时间/自取时间
    var bizType:String
    //业务类型，0外卖，1私厨，2团购
    var biztypeOrderSn:String
    //业务订单编号
    var cheapAmt:String
    //优惠金额
    var createBy:String
    //创建人
    var createTime:String
    //创建时间
    var crossStoreActivityAmt:String
    //跨店活动金额(联盟券和平台券互斥)
    var distributionAmt:String
    //配送费用
    var distributionCheapAmt:String
    //配送减免金额（运费优惠）
    var distributionWay:String
    //配送方式
    var endCreatTime:String
    //结束时间
    var goodsCheapAmt:String
    //商品特价和商品活动价格优惠金额
    var goodsCouponAmt :String
    //商品券金额（商品优惠券）
    var id :String
    var memberDiscountsAmt:String
    //会员折扣金额
    var merchantCheapAmt:String
    //商家承担的优惠金额
    var merchantCouponAmt:String
    //商家券金额（商家优惠券）
    var merchantId:String
    //商家ID
    var merchantName:String
    //商家名称
    var merchantOrderSn:String
    //商家订单编号
    var merchantReduceAmt:String
    //店铺满减
    var moreDiscountsAmt:String
    //多件折扣金额
    var newCustomerAmt:String
    //新客立减金额
    var orderCheapInfoVOList:[CLOrderCheapInfoVOListModel]
    var orderGoodsDetailVOList:[CLOrderGoodsDetailVOList]
    var orderPayInfoVO:CLOrderPayInfoVO
//    orderResource    string
//    订单来源

    var orderReturnVOList:[CLOrderReturnVOModel]
    var orderSn:String
    //订单编号
    var orderStatus:String
//    0待支付（剩余支付时长）,1待评价 ,2已完成 ,3退款售后,4订单关闭,5待商家接单（团购）,6待骑手接单（团购）,7商家备餐中（团购）,8配送中（团购）,9骑手配送中(外卖),10待取餐（团购）,11等待自取（团购）,12待使用（私厨和团购）,13待上门服务（私厨）,14服务中（私厨）15即将到期（团购）16是否能够申请售后，20退款审核中，21退款中，22退款成功，23退款被驳回 97催单 98取消订单 99删除订单
    var orderTime:String
//    下单时间
    var originalAmt:String
//    原始金额
    var packetAmt:String
    //包装费
    var payAmt:String
    //应付金额
    var payStatus:String
    //支付状态
    var payWay:String
    //付款方式
    var platformAmt:String
    //平台服务费
    var platformCheapAmt:String
    //平台承担的优惠金额
    var platformRate:String
    //平台服务费率
    var receiverCity:String
    //收货人城市
    var receiverDetailAddress:String
    //收货人详细地址
    var receiverName:String
    //收货人姓名
    var receiverPhone:String
    //收货人电话
    var receiverProvince:String
    //收货人省份/直辖市
    var receiverRegion:String
    //收货人区域
    var redPacket:String
   // 红包金额（平台红包和会员红包互斥）
    var remark:String
//    备注
    var riderName:String
//    骑手姓名
    var riderPhone:String
//    骑手电话
    var serviceStatus:String
//    售后状态
    var startCreatTime:String
//    开始时间
    var updateBy:String
//    更新人
    var updateTime:String
//    更新时间
    var userId:String
//    会员ID
    var userName:String
//    用户姓名
    var waitPayTime:String
//    待支付剩余时间

    required init?(jsonData: JSON) {
        self.arriveTime = jsonData["arriveTime"].stringValue
        self.bizType = jsonData["bizType"].stringValue
        self.biztypeOrderSn = jsonData["biztypeOrderSn"].stringValue
        self.cheapAmt = jsonData["cheapAmt"].stringValue
        self.createBy = jsonData["createBy"].stringValue
        self.createTime = jsonData["createTime"].stringValue
        self.crossStoreActivityAmt = jsonData["crossStoreActivityAmt"].stringValue
        self.distributionAmt = jsonData["distributionAmt"].stringValue
        self.distributionCheapAmt = jsonData["distributionCheapAmt"].stringValue
        self.distributionWay = jsonData["distributionWay"].stringValue
        self.endCreatTime = jsonData["endCreatTime"].stringValue
        self.goodsCheapAmt = jsonData["goodsCheapAmt"].stringValue
        self.goodsCouponAmt = jsonData["goodsCouponAmt"].stringValue
        self.id  = jsonData["id"].stringValue
        self.memberDiscountsAmt = jsonData["memberDiscountsAmt"].stringValue
        self.merchantCheapAmt = jsonData["merchantCheapAmt"].stringValue
        self.merchantCouponAmt = jsonData["merchantCouponAmt"].stringValue
        self.merchantId = jsonData["merchantId"].stringValue
        self.merchantName = jsonData["merchantName"].stringValue
        self.merchantOrderSn = jsonData["merchantOrderSn"].stringValue
        self.merchantReduceAmt = jsonData["merchantReduceAmt"].stringValue
        self.moreDiscountsAmt = jsonData["moreDiscountsAmt"].stringValue
        self.newCustomerAmt = jsonData["newCustomerAmt"].stringValue
        self.orderCheapInfoVOList = jsonData["orderCheapInfoVOList"].arrayValue.map{
            return CLOrderCheapInfoVOListModel.init(jsonData: $0)!
        }
        self.orderGoodsDetailVOList = jsonData["orderGoodsDetailVOList"].arrayValue.map{
            return CLOrderGoodsDetailVOList.init(jsonData: $0)!
        }
        self.orderPayInfoVO = CLOrderPayInfoVO.init(jsonData:jsonData["orderPayInfoVO"])!
        self.orderSn = jsonData["orderSn"].stringValue
        self.orderReturnVOList = jsonData["orderReturnVOList"].arrayValue.map{
            return CLOrderReturnVOModel.init(jsonData: $0)!
        }
        self.orderStatus = jsonData["orderStatus"].stringValue
        self.orderTime = jsonData["orderTime"].stringValue
        self.originalAmt = jsonData["originalAmt"].stringValue
        self.packetAmt = jsonData["packetAmt"].stringValue
        self.payAmt = jsonData["payAmt"].stringValue
        self.payStatus = jsonData["payStatus"].stringValue
        self.payWay = jsonData["payWay"].stringValue
        self.platformAmt = jsonData["platformAmt"].stringValue
        self.platformCheapAmt = jsonData["platformCheapAmt"].stringValue
        self.platformRate = jsonData["platformRate"].stringValue
        self.receiverCity = jsonData["receiverCity"].stringValue
        self.receiverDetailAddress = jsonData["receiverDetailAddress"].stringValue
        self.receiverName = jsonData["receiverName"].stringValue
        self.receiverPhone = jsonData["receiverPhone"].stringValue
        self.receiverProvince = jsonData["receiverProvince"].stringValue
        self.receiverRegion = jsonData["receiverRegion"].stringValue
        self.redPacket = jsonData["redPacket"].stringValue
        self.remark = jsonData["remark"].stringValue
        self.riderName = jsonData["riderName"].stringValue
        self.riderPhone = jsonData["riderPhone"].stringValue
        self.serviceStatus = jsonData["serviceStatus"].stringValue
        self.startCreatTime = jsonData["startCreatTime"].stringValue
        self.updateBy = jsonData["updateBy"].stringValue
        self.updateTime = jsonData["updateTime"].stringValue
        self.userId = jsonData["userId"].stringValue
        self.userName = jsonData["userName"].stringValue
        self.waitPayTime = jsonData["waitPayTime"].stringValue
    }
}
