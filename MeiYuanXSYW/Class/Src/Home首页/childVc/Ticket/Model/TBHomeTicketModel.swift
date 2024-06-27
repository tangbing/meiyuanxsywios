//
//  TBHomeTicketModel.swift
//  MeiYuanXSYW
//
//  Created by Tb on 2022/2/22.
//

import Foundation
import HandyJSON

struct TBHomeMyTicketModel: HandyJSON {
    var couponNum: Int = 0
    var couponVoList: [FreeCouponVoData] = [FreeCouponVoData]()
    
}
