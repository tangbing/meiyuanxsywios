//
//  XSHomePrivateKitchenModel.swift
//  MeiYuanXSYW
//
//  Created by Tb on 2022/2/23.
//

import Foundation
import HandyJSON

/*
 "avgPrice": 30,
        "merchantId": "14677131",
        "merchantName": "行善超大市3",
        "merchantPlaque": "https://xsyw-test.oss-cn-shenzhen.aliyuncs.com/2021/12/24/e2bed819-4550-46b0-9078-8d1f51e37cb0.jpg",
        "merchantRecommend": "这是商家介绍！",
        "merchantTag": [
          "string"
        ]
 */

struct XSHomePrivateKitchenModel: HandyJSON {
    var code: Int = 0
    var count: Int = 0
    var data: [XSHomePrivateKitchenData] = [XSHomePrivateKitchenData]()
}

struct XSHomePrivateKitchenData: HandyJSON  {
    var avgPrice: NSNumber = 0
    var merchantId: String = ""
    var merchantName: String = ""
    var merchantPlaque: String = ""
    var merchantRecommend: String = ""
    var merchantTag: [String] = [String]()
}
