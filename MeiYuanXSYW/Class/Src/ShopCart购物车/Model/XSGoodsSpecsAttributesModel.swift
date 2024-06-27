//
//  XSGoodsSpecsAttributesModel.swift
//  MeiYuanXSYW
//
//  Created by Tb on 2022/1/20.
//

import Foundation
import HandyJSON

class XSGoodsSpecsAttributesModel: HandyJSON {
    var goodsId: String = ""
    var goodsName: String = ""
    var topPic: String = ""
    var picAddress: String = ""
    var merchantId: String = ""
    var moreDiscount: String = ""
    var specDetails: [SpecDetail] = [SpecDetail]()
    var attributesDetails: [AttributesDetail] = [AttributesDetail]()

    required init() {
        
    }
}

// MARK: - AttributesDetail
class AttributesDetail: HandyJSON {
    var attributesName: String = ""
    var attributesValues: [AttributesValue] = [AttributesValue]()

    required init() {
        
    }
}

// MARK: - AttributesValue
class AttributesValue: HandyJSON {
    var attributesId: String = ""
    var attributesValue: String = ""

    required init() {
        
    }
}

// MARK: - SpecDetail
class SpecDetail: HandyJSON {
    var specId: String = ""
    var specName: String = ""
    var price: NSNumber = 0

    required init() {
        
    }
}
