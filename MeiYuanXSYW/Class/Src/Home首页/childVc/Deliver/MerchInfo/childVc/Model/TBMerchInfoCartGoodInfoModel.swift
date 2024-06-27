//
//  TBMerchInfoCartGoodInfoModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/23.
//

import Foundation
import HandyJSON



class TBMerchInfoCartGoodInfoModel : HandyJSON {
    /// <##>0 可下单，有配送费。1不能下单，有差额。2 可下单，免配送费
    var canDistribution: Int = 0
    
    /// <##>差额
    var differenceAmt: Int = 0
    
    /// <##>配送费用
    var distributionAmt: Int = 0
    
    /// 商品总数
    var totalAccount: Int = 0
    
    /// 应付金额
    var payAmt: Double = 0.0
    
    /// 包装费
    var totalPacketAmt: Double = 0.0

    /// 商品总数
    var orderCarGoodsAccountVOList : [OrderCarGoodsAccountVOList]?
    
    /// 商品显示信息
    var orderShoppingTrolleyVOList : [OrderShoppingTrolleyVOList]?
    
    required init() {
        
    }
}


class OrderCarGoodsAccountVOList : HandyJSON {
    /// 数量
    var account: Int = 0
    
    /// 商品ID
    var goodsId: String = ""
    
    /// 是否多规格。0多规格，1 不是多规格
    var moreSpec: Int = 0
    
    required init() {
        
    }
    
}



class MoreDiscounts: HandyJSON {
    var discountRate: NSInteger = 0
    var isDefaultUse: Bool = true
    var isUse: Bool = true
    var num: NSInteger = 0
    
    required init() {
        
    }
}



class OrderShoppingTrolleyVOList: HandyJSON {
    /// <##>商品数量
    var account: UInt = 0
    
    /// 商品活动价格
    var activityPrice: Double = 0.0
    
    /// 属性ID集合
    var attributesIdDetails: String = ""
    
    /// 属性名字集合
    var attributesNameDetails: String = ""
    
    /// 业务类型，0外卖，1私厨，2团购
    var bizType : Int = 0
    
    /// 创建人
    var createBy: String = ""
    
    /// 创建时间
    var createTime: String = ""
    
    /// 商品折扣
    var discount: Double = 0.0
    
    /// 最终价格
    var discountPrice: NSNumber = 0.0
    
    /// 最终价格
    var finalPrice: NSNumber = 0.0
    
    /// 商品ID
    var goodsId: String = ""
    
    /// 商品名称
    var goodsName: String = ""
    
    /// id
    var id: Int = 0
    
    /// 商家ID
    var merchantId: String = ""
    
    /// 商家名称
    var merchantName: String = ""
    

    var moreDiscounts: [MoreDiscounts]?
    
    var originPrice: NSNumber = 0.0

    /// 包装费
    var packetAmt: NSNumber = 0.0
    

    /// 规格
    var specId: String = ""
    
    /// 规格名
    var specName: String = ""
    

    /// 0失效 1 生效
    var status: Int = 1
    
    /// 主图
    var topPic: String = ""
    
    /// 更新人
    var updateBy: String = ""
    

    ///<##>更新时间
    var updateTime: String = ""
    

    /// 用户ID
    var userId: Int = 0
    

    required init() {
        
    }
    
}



/*
"canDistribution":0,
     "differenceAmt":0,
     "distributionAmt":0,
     "orderCarGoodsAccountVOList":[
         {
             "account":0,
             "goodsId":"string",
             "moreSpec":0
         }
     ],
     "orderShoppingTrolleyVOList":[
         {
             "account":0,
             "activityPrice":0,
             "attributesIdDetails":"string",
             "attributesNameDetails":"string",
             "bizType":0,
             "createBy":"string",
             "createTime":"2021-12-23T06:19:34.620Z",
             "discount":0,
             "discountPrice":0,
             "finalPrice":0,
             "goodsId":"string",
             "goodsName":"string",
             "id":0,
             "merchantId":"string",
             "merchantName":"string",
             "moreDiscounts":[
                 {
                     "discountRate":0,
                     "isDefaultUse":true,
                     "isUse":true,
                     "num":0
                 }
             ],
             "originPrice":0,
             "originalPrice":0,
             "packetAmt":0,
             "specId":"string",
             "specName":"string",
             "status":0,
             "topPic":"string",
             "updateBy":"string",
             "updateTime":"2021-12-23T06:19:34.620Z",
             "userId":0
         }
     ],

 */
