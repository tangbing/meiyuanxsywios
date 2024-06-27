//
//  TBHomeGroupBuyHeaderKingKongAreaModel.swift
//  MeiYuanXSYW
//
//  Created by Tb on 2022/3/2.
//

import Foundation
import UIKit

class TBHomeGroupBuyHeaderKingKongAreaModel: TBHomeGroupBuyHeaderProtocol {
    var style: TBHomeGroupBuyHeaderCellStyle {
        return .kingKongArea
    }
    
    var rowHeight: CGFloat {
        return 165
    }
    private var kingkongDetals: [KingkongDetal] = [KingkongDetal]()

    
    
}
