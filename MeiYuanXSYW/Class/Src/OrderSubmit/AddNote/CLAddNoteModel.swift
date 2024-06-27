//
//  CLAddNoteModel.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2022/1/5.
//

import Foundation
import SwiftyJSON

class CLAddNoteModel:CLSwiftyJSONAble {
    var remark : String
    var id : Int
    
    required init?(jsonData: JSON) {
        remark = jsonData["remark"].stringValue
        id = jsonData["id"].intValue
    }
}
