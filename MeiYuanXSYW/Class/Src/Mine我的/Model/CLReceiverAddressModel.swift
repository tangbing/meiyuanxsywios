//
//  CLReceiverAddressModel.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2022/3/1.
//

import UIKit
import SwiftyJSON

class CLReceiverAddressModel: CLSwiftyJSONAble {
    var canDistribution:Bool = false
    var id:Int = 0
    var isDefaultAddress:Int = 0
    var lat:Double = 0.0
    var lng:Double = 0.0
    var receiverCity:String = ""
    var receiverDetailAddress:String = ""
    var receiverLabel:Int = 0
    var receiverName:String = ""
    var receiverPhone:String = ""
    var receiverProvince:String = ""
    var receiverRegion:String = ""
    var receiverSex:Int = 0
    var userId:String = ""
    // 距离
    var distance: String = ""
    var name: String = ""
    var isSelect: Bool = false
    

    
    init(lat: Double, lng: Double,distance: String, name: String, receiverDetailAddress: String,province: String = "",city: String = "", district: String = "") {
        self.lat = lat
        self.lng = lng
        self.distance = distance
        self.name = name
        self.receiverProvince = province
        self.receiverCity = city
        self.receiverRegion = district
        self.receiverDetailAddress = receiverDetailAddress
    }
    
    required init?(jsonData: JSON) {
        canDistribution = jsonData["canDistribution"].boolValue
        id = jsonData["id"].intValue
        isDefaultAddress = jsonData["isDefaultAddress"].intValue
        lat = jsonData["lat"].doubleValue
        lng = jsonData["lng"].doubleValue
        receiverCity = jsonData["receiverCity"].stringValue
        receiverDetailAddress = jsonData["receiverDetailAddress"].stringValue
        receiverLabel = jsonData["receiverLabel"].intValue
        receiverName = jsonData["receiverName"].stringValue
        receiverPhone = jsonData["receiverPhone"].stringValue
        receiverProvince = jsonData["receiverProvince"].stringValue
        receiverRegion = jsonData["receiverRegion"].stringValue
        receiverSex = jsonData["receiverSex"].intValue
        userId =  jsonData["userId"].stringValue
        
    }
}
