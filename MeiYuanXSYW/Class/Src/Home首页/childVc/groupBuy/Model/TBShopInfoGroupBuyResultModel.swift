//
//  TBShopInfoGroupBuyResultModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2022/1/4.
//

import Foundation
import HandyJSON

/*
 "goodsId": "1461596690602377265",
        "goodsName": "清炒莴笋",
        "goodsPic": "https://xsyw-test.oss-cn-shenzhen.aliyuncs.com/%E6%B5%8B%E8%AF%95%E8%8F%9C%E5%93%81%E5%9B%BE/%E7%BA%A2%E7%83%A7%E6%8E%92%E9%AA%A8.jpg",
        "goodsTag": "川菜",
        "praise": 99,
        "isReserve": 1,
        "salesDate": "周一至周日",
        "price": 23,
        "originalPrice": 70,
        "discount": 3.3
 */


class TBShopInfoGroupBuyResultModel: HandyJSON {

    /// 套餐详情
    var comboDetails: [TBComboDetails]?
    
    /// 优惠券详情
    var couponDetails: [TBCouponDetails]?
    
    /// 评价
    var evaluationDetails: TBEvaluationDetails?
    
    /// 外卖详情详情
    var takeoutDetails: TBTakeoutDetails?
    
    var goodsType: String = ""
    
    required init() {}
    
}

class EvaluationGoods {
    var goodsId: String = ""
    
    var goodsName: String = ""
    
    var goodsPic: String = ""
    
    var finalPrice: NSNumber = 0
    
    var originalPrice: NSNumber = 0
    
    required init() {}
}

class EvaluationDetail: HandyJSON {
    var bizType: String = ""

    var commentPicStr: [String]?
    
    var evaluationGoods: EvaluationGoods?
    
    var headImg: String = ""
    
    var merchantReplyComment: String?

    var merchantReplyDate: String = ""
    
    var totalScoreItems = [TBtotalScoreItem]()
    
    var userComment: String = ""

    var userCommentDate: String = ""
    
    var userName: String = ""
    /// 总体评价
    var totalComment: NSNumber = 0
    
    
    var userCommentH: CGFloat {
       // guard let evaluationModel = evaluationModel else { return 0.0 }
        
        let content_height = userComment.jk.rectHeight(font: MYFont(size: 13), size: CGSize(width:repeatContent_width , height: CGFloat(MAXFLOAT)))
        return content_height
    }
 
    //let commentPicStr: [String]?
    
    var commentPicStrH: CGFloat {
        let margin: CGFloat = 5
        let totalColumns = 3
        let itemWidth: CGFloat = (repeat_width - CGFloat((totalColumns - 1)) * margin) / 3
        
        guard let pics = commentPicStr else {
            return 0
        }
        //var height: CGFloat = 0.0
        var row = pics.count / totalColumns
        let col = pics.count % totalColumns
        if col != 0 {
            row += 1
        }
        let height =  CGFloat(row) * (itemWidth + margin)

        return height
    }
    
    
//    var evaluationGoods: EvaluationGoods?
//
//    var merchantReplyComment: String?
//    var merchantReplyDate: String?
    
    var merchantReplyCommentH: CGFloat {
        guard let repeatStr = merchantReplyComment else { return 0 }

        let repeat_height = repeatStr.jk.rectHeight(font: MYBlodFont(size: 12), size:CGSize(width: repeat_width, height: CGFloat(MAXFLOAT)))
        return repeat_height
    }
    

    
    required init() {}
}

class TBEvaluationDetails: HandyJSON {

    /// 评价总数量
    var evaluationSumNum: Int = 0
  
    /// 总体评价
    var totalComment: NSNumber = 0
    
    /// 评价详情
    var evaluationDetails: [EvaluationDetail]?
    
    var totalScoreItems: [TBtotalScoreItem]!
    
    required init() {}
    
}

class TBtotalScoreItem: HandyJSON {
    var scoreName: String = ""
    var scoreNum: NSNumber = 0
    
    init(scoreName: String, scoreNum: NSNumber) {
        self.scoreNum = scoreNum
        self.scoreName = scoreName
    }
    
    required init() {}
}

class TBTakeoutDetails: HandyJSON {
    var details: [GoodsItemVo]!
    var sumNum: Int = 0
    
    required init() {}
}







//class TakeoutDetail: HandyJSON {
//
//    var attributesItem: [AttributesItem]
//    var chooseGoodsNum: Int
//    var discountRate: Int
//    var discountStr: String
//    var distance: Int
//    var finalPrice: Int
//    var goodsId : String
//    var goodsName: String
//    var goodsSales
//    var goodsSort
//    var isChoose: Int
//    var merchantId
//    var merchantName: String
//    var minAmount : Int
//    var originalPrice: Int
//    var picAddress: String
//    var praise: Int
//    var specItem: [SpecItem]
//    var stockItem: [StockItem]
//    var stockStatus : Int
//    var sumStock: Int
//    var topPic: String
//
//    required init() {}
//}
//
//class AttributesItem: HandyJSON {
//
//
//    required init() {}
//}

/*
 availableDays    string
 可用日期

 discount    number
 代金券折扣率

 endTime    string
 结束时间

 goodsId    string
 代金券ID

 goodsName    string
 代金券名

 price    number
 代金券价格

 startTime    string
 开始时间
 */
class TBCouponDetails: HandyJSON {
    /// 可用日期
    var availableDays: String = ""
    
    /// 代金券折扣率
    var discount: String = ""
    
    /// 结束时间
    var endTime: String = ""
    
    /// 代金券ID
    var goodsId: String = ""
    
    /// 代金券名
    var goodsName: String = ""
    
    /// 代金券价格
    var price: NSNumber = 0.0
    
    /// 开始时间
    var startTime: String = ""
    
    required init() {}
    
}


class TBComboDetails: HandyJSON {
    var goodsId: String = ""
    var goodsName: String = ""
    var goodsPic: String = ""
    
    /// 商品标签
    var goodsTag: String = ""
    
    /// 是否预约 0：预约 1：不预约
    var isReserve: Int = 0
    
    /// 原价
    var originalPrice: NSNumber = 0.0
    
    /// 打折
    var discount: NSNumber = 0.0
    
    /// 好评率
    var praise: Int = 0
    
    /// 售价
    var price: NSNumber = 0.0
    
    /// 销售时间
    var salesDate: String = ""
    
    required init() {}
    
}
