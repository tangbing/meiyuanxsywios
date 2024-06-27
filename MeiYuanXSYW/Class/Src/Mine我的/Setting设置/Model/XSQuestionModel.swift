//
//  XSQuestionModel.swift
//  MeiYuanXSYW
//
//  Created by Tb on 2022/3/9.
//

import Foundation
import HandyJSON
import SwiftyJSON

struct XSQuestionListModel: HandyJSON {
    var code: Int = 0
    var count: Int = 0
    var data: [XSQuestionDataModel] = [XSQuestionDataModel]()
}

struct XSQuestionDataModel: HandyJSON {
    var content: String = ""
    var id: Int = 0
    var title: String = ""
    var url: String = ""
}

class XSQuestionDetailModel: CLSwiftyJSONAble {
    var content: String
    var title: String
    var id: Int
    var url: String
    
    required init?(jsonData: JSON) {
        self.content = jsonData["content"].stringValue
        self.title = jsonData["title"].stringValue
        self.url = jsonData["url"].stringValue
        self.id = jsonData["id"].intValue
    }
}

