//
//  TBHomeGroupBuyHeaderBannerModel.swift
//  MeiYuanXSYW
//
//  Created by Tb on 2022/3/2.
//

import Foundation
import UIKit


class TBHomeGroupBuyHeaderBannerModel: TBHomeGroupBuyHeaderProtocol {
    var style: TBHomeGroupBuyHeaderCellStyle {
        return .banner
    }
    
    var rowHeight: CGFloat {
        return 120
    }
    private var advertiseDetails: [AdvertiseDetail] = [AdvertiseDetail]()


    
    
}
