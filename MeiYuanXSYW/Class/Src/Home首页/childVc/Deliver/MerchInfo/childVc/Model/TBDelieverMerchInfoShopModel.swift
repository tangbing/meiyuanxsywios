//
//  TBDelieverMerchInfoShopModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/21.
//

import Foundation
import HandyJSON

// MARK: - TBDelieverMerchInfoShopModel
class TBDelieverMerchInfoShopModel: HandyJSON {
    /// 分类名称
    var groupName: String = ""
    var goodsItemVos: [GoodsItemVo] = [GoodsItemVo]()
    
    required init() {
        
    }
    
}
/// 库存状态（0：有库存 1：已售罄）
enum StockStatus: Int, HandyJSONEnum {
    case stockEnough = 0
    case soldOut = 1
}

/// 可选规格 0：可选 1：不可选
enum SpecIsChoose: Int, HandyJSONEnum {
    case isChoose = 0
    case notChoose = 1
}

enum TBDeliverMerchInfoShopState {
    /// 加入购物车
    case normal
    /// 已售罄
    case buyOut
    /// 多份起售
    case selectMulti
    /// 选规格
    case selectStandard
    /// PlusReduce
    case plusReduce
    /// 暂停营业
    case pauseBusiness
}

// MARK: - GoodsItemVo
class GoodsItemVo: HandyJSON {
    /// 商品id
    var goodsId: String = ""
    
    /// 商品名称
    var goodsName: String = ""
    
    /// 商家id
    var merchantId: String = ""
    
    /// 商家名称
    var merchantName: String = ""
    
    /// 图片地址
    var picAddress: String = ""
    
    /// 主图地址
    var topPic: String = ""
    
    /// 最终价格
    var finalPrice: NSNumber = 0
    
    /// 原价
    var originalPrice: NSNumber = 0
    
    /// 好评率
    var praise: Int = 0
    
    /// 商品排序
    var goodsSort: Int = 0
    
    /// 商品销量
    var goodsSales: Int = 0
    
    /// 最小购买量
    var minAmount: Int = 0
    
    /// 可选规格 0：可选 1：不可选
    var isChoose: SpecIsChoose = .notChoose
    
    /// 多件折扣字符串
    var discountStr: String?
    
    /// 折扣率
    var discountRate: Double = 0.0
    
    /// 距离
    var distance: String = ""
    
    /// 库存状态（0：有库存 1：已售罄）
    var stockStatus: StockStatus = .stockEnough
    
    /// 该商品的总库存
    var sumStock: Int = 0
    
    /// 标记字段（用户添加商品的数量）
    var chooseGoodsNum: Int = 0
    
    /// 规格明细
    var specItem: [SpecItem]?
    
    /// 属性明细
    var attributesItem: [AttributesItem]?
    
    /// 库存明细
    var stockItem: [StockItem]?
    
    var merchInfoShopState: TBDeliverMerchInfoShopState = .normal
    
    /// 该商品买了多少
    var buyOfNum: UInt = 0 
    
    /// 判断选择在购物车的商品是否规则一样。0多规格，1 不是多规格
    var moreSpec: NSInteger = 1

   
    
    // 在1.8.0版本之后，HandyJSON提供了didFinishMapping函数作为观察逻辑的切入点
    func didFinishMapping() {
        if isChoose == .isChoose {
             merchInfoShopState = .selectStandard
        } else if(stockStatus == .soldOut) {
            merchInfoShopState = .buyOut
        } else if(minAmount != 0) {
            merchInfoShopState = .selectMulti
        } else {
            merchInfoShopState = .normal
        }
    }
    
    init(_ goodsName: String, picAddress: String, finalPrice: NSNumber,
         originalPrice: NSNumber,discountStr: String, merchantId: String,
         goodsId: String,specItem: [SpecItem]?, attributesItem: [AttributesItem]?) {
        self.goodsName = goodsName
        self.picAddress = picAddress
        self.finalPrice = finalPrice
        self.originalPrice = originalPrice
        self.discountStr = discountStr
        self.specItem = specItem
        self.attributesItem = attributesItem
        self.merchantId = merchantId
        self.goodsId = goodsId
    }
    
    
//    {
//        get {
//            if isChoose == .isChoose {
//                return .selectStandard
//            } else if(stockStatus == .soldOut) {
//                return .buyOut
//            } else if(minAmount != 0) {
//                return .selectMulti
//            } else {
//                return .normal
//            }
//        }
//        set {
//
//        }
//
//    }

    required init() {
        
    }
}

// MARK: - AttributesItem
class AttributesItem: HandyJSON {
    /// 属性值详情
    var attributesValueItems: [AttributesValueItem]?
    
    /// 属性名
    var attributesName: String = ""
    
    /// 选中的属性ID
    var selectAttrId = [String]()
    /// 是否是多选，0为单选，1为多选
    var attributesRule: Int = 0
    required init() {}
    
    init(attributesName: String, selectAttrId: [String], attributesValueItems:[AttributesValueItem]?, attributesRule: Int) {
        self.attributesName = attributesName
        self.selectAttrId = selectAttrId
        self.attributesValueItems = attributesValueItems
        self.attributesRule = attributesRule
    }
    
    
    
//    func mapping(mapper: HelpingMapper) {
//        // 指定 id 字段用 "cat_id" 去解析
//        mapper.specify(property: &selectAttrId, name: "selectAttrID")
//    }
}


// MARK: - AttributesValueItem
class AttributesValueItem: HandyJSON {
    var attributesId: String = ""
    var attributesValue: String = ""
    var isSelect: Bool = false
    required init() {}
    
    init(attributesId: String, attributesValue: String, isSelect: Bool) {
        self.attributesId = attributesId
        self.attributesValue = attributesValue
        self.isSelect = isSelect
    }
    
}

// MARK: - SpecItem
class SpecItem: HandyJSON {
    /// 规格ID
    var specId: String = ""
    
    /// 最终价格
    var finalPrice: NSNumber = 0.0
    
    /// 原价
    var originalPrice: NSNumber = 0.0
    
    /// 包装费
    var packingMoney: Int = 0
    
    /// 是否自动补齐
    var isAuto: Int = 0
    
    /// 规格名称
    var specName: String = ""

    init(specId: String, specName: String, finalPrice: NSNumber) {
        self.specId = specId
        self.specName = specName
        self.finalPrice = finalPrice
    }
    
    required init() {
        
    }

}

// MARK: - StockItem
class StockItem: HandyJSON {
    /// 库存ID
    var stockId: String = ""
    
    ///  规格ID
    var specId: String = ""
    
    /// 库存状态（0：有库存 1：已售罄）
    var stockStatus: StockStatus?
    
    /// 剩余库存
    var remainNum: Int = 0
    required init() {
        
    }
}

