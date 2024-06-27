//
//  CLMemberBuyRecordListModel.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2022/2/28.
//

import UIKit
import SwiftyJSON

class CLMemberBuyRecordListModel: CLSwiftyJSONAble {
    var title:String
    var createTime:String
    var payAmt:String
    var endTime:String
    
    required init?(jsonData: JSON) {
        title = jsonData["title"].stringValue
        createTime = jsonData["createTime"].stringValue
        payAmt = jsonData["payAmt"].stringValue
        endTime = jsonData["endTime"].stringValue

        
    }
}
