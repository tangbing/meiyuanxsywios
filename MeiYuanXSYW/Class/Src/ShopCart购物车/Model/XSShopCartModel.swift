//
//  XSShopCartModel.swift
//  MeiYuanXSYW
//
//  Created by Tb on 2022/1/19.
//

import Foundation
import HandyJSON


class XSShopCartModel: HandyJSON {
    var count: Int = 0
    var code: Int = 0
    /// 会员状态 0 未购买 1会员 2已失效
    var memberStatus: Int = 0

    var data: [XSShopCartDataModel] = [XSShopCartDataModel]()
   
    
    required init() {
    }
    
}

class XSShopCartDataModel: HandyJSON {
    /// 商品显示信息
    var orderShoppingTrolleyVOList : [XSShopCartTrolleyVOList]?
    var merchantFullReduceVoList: [MerchantFullReduceVoList]?
    var merchantFullReduceVoListStr: String = ""
    /// 0外卖，1私厨，2团购
    var bizType: Int = 0
    var merchantId = ""
    var merchantName: String = ""
    /// 是否失效.0失效1有效
    var isEfficacy: Bool = true
    /// true:在配送范围内,false:不在配送范围内
    var canDistribution: Bool = false
    
    var cellState: XSShopCartCellState = .normal
    
    // 在1.8.0版本之后，HandyJSON提供了didFinishMapping函数作为观察逻辑的切入点
    func didFinishMapping() {
        if canDistribution == false { // 超过配送范围
            cellState = .outBounds
        } else if(isEfficacy == false) {// 已经失效
            cellState = .loseTime
        }  else {
            cellState = .normal
        }
    }
    
    required init() {
    }
    
}

class XSShopCartTrolleyVOList: OrderShoppingTrolleyVOList {
    /// false是否需要选规格.true需要 false否
    var needSpecId: Bool = false
    /// 促销。多件折扣有该值
    var salePromotionStr: String = ""
    /// 团购 规则
    var groupUseRuleStr: String = ""
    
    required init() {
    }
}

/// 商家满减
class MerchantFullReduceVoList: HandyJSON {
    /// 满足金额
    var accordPrice: NSNumber = 0
    /// 适用业务(0:通用;1:外卖;2:团购;3:私厨)
    var businessType: Int = 0
    var createBy: String = ""
    var createTime: String = ""
    var effectEndTime: String = ""
    /// 生效时段开始时间
    var effectStartTime: String = ""
    /// 生效时段类型(0:全天;1:指定时间段)
    var effectType: Int = 0
    var endTime: String = ""
    var id: Int = 0
    /// 是否默认
    var isDefaultUse: Bool = false
    /// 是否可用
    var isUse: Bool = false
    var merchantId: String = ""
    var merchantName: String = ""
    var periodOn: String = ""
    var periodType: Int = 0
    var reducePrice: Int = 0
    var startTime: String = ""
    var updateBy: String = ""
    var updateTime: String = ""
    
    required init() {
        
    }
}


