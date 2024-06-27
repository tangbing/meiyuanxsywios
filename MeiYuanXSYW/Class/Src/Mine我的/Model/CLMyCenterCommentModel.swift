//
//  CLMyCenterCommentModel.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2022/3/4.
//

import UIKit
import SwiftyJSON

class CLMyCenterCommentModel: CLSwiftyJSONAble {
    var allCommentAccount:Int
    var code:Int
    var count:Int
    var data:[CLCommentModel]
    var merchantReplyAccount:Int
    var picAccount:Int
    
    required init?(jsonData: JSON) {
        allCommentAccount = jsonData["allCommentAccount"].intValue
        code = jsonData["code"].intValue
        count = jsonData["count"].intValue
        data = jsonData["data"].arrayValue.compactMap{
            return CLCommentModel.init(jsonData: $0)
        }
        merchantReplyAccount = jsonData["merchantReplyAccount"].intValue
        picAccount = jsonData["picAccount"].intValue

    }
}


class CLCommentModel:CLSwiftyJSONAble {
    var address:String
    var applyBy:String
    var applyTime:String
    var applyWay:String
    var bizType:String
    var biztypeOrderSn:String
    var commentPic:String
    var commentPicStr:[String]
    var commentScore:String
    var environmentComment:String
    var headImg:String
    var id :Int
    var merchantId:String
    var merchantLogo:String
    var merchantName:String
    var merchantOrderSn:String
    var merchantReplyComment:String
    var merchantReplyDate:String
    var merchantReplyTime:String
//    var orderCommentGoodsVOList
    var orderSn:String
    var packComment:String
    var perCapita:String
    var remark1:String
    var remark2:String
    var remark3:String
    var serviceComment:String
    var status:Int
    var tasteComment:String
    var totalComment:Double
    var totalScoreItems:[CLTotalScoreItems]
    var userComment:String
    var userCommentDate:String
    var userCommentTime:String
    var userId:String
    var userName:String
    var voucherCode:String
    
    
    required init?(jsonData: JSON) {
        address = jsonData["address"].stringValue
        applyBy = jsonData["applyBy"].stringValue
        applyTime = jsonData["applyTime"].stringValue
        applyWay = jsonData["applyWay"].stringValue
        bizType = jsonData["bizType"].stringValue
        biztypeOrderSn = jsonData["biztypeOrderSn"].stringValue
        commentPic = jsonData["commentPic"].stringValue
        commentPicStr  = jsonData["commentPicStr"].arrayValue.compactMap{
            return $0.stringValue
        }
        commentScore = jsonData["commentScore"].stringValue
         environmentComment = jsonData["environmentComment"].stringValue
       headImg = jsonData["headImg"].stringValue
        id  = jsonData["id"].intValue
       merchantId = jsonData["merchantId"].stringValue
         merchantLogo = jsonData["merchantLogo"].stringValue
        merchantName = jsonData["merchantName"].stringValue
         merchantOrderSn = jsonData["merchantOrderSn"].stringValue
         merchantReplyComment = jsonData["merchantReplyComment"].stringValue
        merchantReplyDate = jsonData["merchantReplyDate"].stringValue
         merchantReplyTime = jsonData["merchantReplyTime"].stringValue
    //    var orderCommentGoodsVOList
        orderSn = jsonData["orderSn"].stringValue
       packComment = jsonData["packComment"].stringValue
       perCapita = jsonData["perCapita"].stringValue
         remark1 = jsonData["remark1"].stringValue
        remark2 = jsonData["remark2"].stringValue
        remark3 = jsonData["remark3"].stringValue
        serviceComment = jsonData["serviceComment"].stringValue
        status = jsonData["status"].intValue
        tasteComment = jsonData["tasteComment"].stringValue
        totalComment = jsonData["totalComment"].doubleValue
        totalScoreItems = jsonData["totalScoreItems"].arrayValue.compactMap{
            return CLTotalScoreItems.init(jsonData: $0)
        }
        userComment = jsonData["userComment"].stringValue
         userCommentDate = jsonData["userCommentDate"].stringValue
         userCommentTime = jsonData["userCommentTime"].stringValue
        userId = jsonData["userId"].stringValue
         userName = jsonData["userName"].stringValue
         voucherCode = jsonData["voucherCode"].stringValue
    }
}


class CLTotalScoreItems:CLSwiftyJSONAble {
    var scoreName:String
    var scoreNum:String
    
    required init?(jsonData: JSON) {
        scoreName = jsonData["scoreName"].stringValue
        scoreNum = jsonData["scoreNum"].stringValue

        
    }
}
