//
//  TBMerchantCommentModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/27.
//

import UIKit
import HandyJSON



class TBMerchantCommentModel: HandyJSON {
    var allCount: Int = 0
    
    var code: Int = 0
    
    var count: Int = 0
    
    var commentScore: NSNumber = 0

    var data: [OrderCommentModel]?
    
    var merchantReplyAccount: Int = 0
    
    var picCount: Int = 0
    var lowCount: Int = 0
    var newCount: Int = 0

    
    var orderCommentScoreVO: OrderCommentScoreVO!
    
    var totalScoreItems: [TBtotalScoreItem]!
    
    var bizType: Int = 0
    
    required init() {}
    
}

class OrderCommentModel: HandyJSON {
    var id: Int = 0
    
    var userId: Int = 1
    
    var userName: String = ""
    
    var orderSn: String = ""
    
    /// 业务订单编号
    var biztypeOrderSn: String = ""
    
    var merchantOrderSn: String = ""
    
    /// 0外卖，1团购，2私厨
    var bizType: Int = 1
    
    
    var merchantId: String = ""
    
    var merchantName: String = ""
    
    /// 商家回复内容
    var merchantReplyComment: String?
    
    /// 商家回复时间
    var merchantReplyTime: String = ""

    /// 用户评价内容
    var userComment: String = ""
    
    /// 用户评价时间
    var userCommentTime: String = ""

    /// 用户评价图片
    var commentPic: String = ""
    
    /// 用户评价图片数组
    var commentPicStr: [String]?
    
    /// 口味(评分)
    var tasteComment: NSNumber = 0.0
    
    /// 包装(评分)
    var packComment: NSNumber = 0.0
    
    /// 总体评价
    var totalComment: NSNumber = 0.0
    
    /// 服务
    var serviceComment: NSNumber = 0.0
    
    /// 环境
    var environmentComment: NSNumber = 0.0
    
    /// 评分
    var commentScore: NSNumber = 0.0
    
    /// 审核方式
    var applyWay = ""
    
    /// 审核人
    var applyBy = ""
    
    // 评价状态。0未审核，1已审核，2已展示。3，已屏蔽
    var status: Int = 0
    
    /// 审核时间
    var applyTime: String = ""
    
    /// 预留字段1
    var remark1: String = ""
    
    var remark2: String = ""
    
    var remark3: String = ""
    
    var headImg: String = ""
    
    var merchantReplyDate: String = ""
    
    var userCommentDate: String = ""

    var merchantLogo: String = ""
    
    var perCapita: String = ""

    /// 详细地址
    var address: String = ""
    
    var orderCommentGoodsVOList: OrderCommentGoodsVOList?
    
    var totalScoreItems: [TBtotalScoreItem]!

    
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


class OrderCommentGoodsVOList: HandyJSON {
    var finalPrice: NSNumber = 0
    
    var originalPrice: NSNumber = 0

    var goodsId: String = ""
    
    var goodsName: String = ""

    var id: Int = 0
    
    var merchantId: String = ""
    
    var merchantName: String = ""
    
    var merchantOrderSn: String = ""

    var userId: Int = 0
    var status: Int = 0

    var topPic: String = ""

    
    required init() {}
}


class OrderCommentScoreVO: HandyJSON {
   /// 口味(评分)
    var tasteScore: Double = 0.0
    
    /// 包装(评分)
   var packScore: Double = 0.0
    
    /// 总体评价
   var totalScore: Double = 0.0
    
    /// 服务
   var serviceScore: Double? = 0.0
    
    /// 环境
   var environmentScore: Double = 0.0
    
    /// 按权重比例评分
   var commentScore: Double = 0.0
    
   required init() {}
    
}
