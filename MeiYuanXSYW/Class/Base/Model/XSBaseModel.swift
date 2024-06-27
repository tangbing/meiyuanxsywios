//
//  XSBaseModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/19.
//

import HandyJSON
import JKSwiftExtension



/*
"data": {
   stateType: true:
 }},
 
"resp_code": 0,
"resp_msg": "string",
"systemMillisecond": 0
 */




//struct XSResponseData<T: Codable> : Codable {
//    var resp_code: Int = 0
//    var resp_msg: String = ""
//    var systemMillisecond: CLongDouble = 0
//    var data: XSReutrnData<T>?
//
//    enum CodingKeys: String, CodingKey {
//        case data
//        case respCode = "resp_code"
//        case respMsg = "resp_msg"
//        case systemMillisecond
//    }
//
//}

//requestData: {"data":{"trueOrFalse":0},"resp_code":0,"resp_msg":"","systemMillisecond":1639532030032}

extension Array: HandyJSON{}
extension String: HandyJSON{}
//protocol Data: HandyJSON {}

// MARK: - XSResponseData
struct XSResponseData<T: HandyJSON>: HandyJSON {
    var data: T?
    var resp_code: Int = 0
    var resp_msg: String = ""
    var systemMillisecond: Int = 0
}


//struct XSResponseData<T: HandyJSON>: HandyJSON {
//    var data: T?
//    var resp_code: Int = 0
//    var resp_msg: String = ""
//    var systemMillisecond: Int = 0
//}

struct XSMerchInfoHandlerModel: HandyJSON {
    var trueOrFalse: Int = 0
}


struct TBUploadResultModel: HandyJSON {
    
    var id: String = ""
    var name: String = ""
    var path: String = ""
    var source: String = ""
    var tenantId: String = ""
    var updateTime: String = ""
    var url: String = ""
    var size: Int = 0
    var isImg: Int = 0
    

}

