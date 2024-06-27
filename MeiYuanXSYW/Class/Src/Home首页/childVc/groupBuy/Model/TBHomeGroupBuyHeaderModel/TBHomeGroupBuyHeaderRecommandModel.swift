//
//  TBHomeGroupBuyHeaderRecommandModel.swift
//  MeiYuanXSYW
//
//  Created by Tb on 2022/3/2.
//

import Foundation
import UIKit


class TBHomeGroupBuyHeaderRecommandModel: TBHomeGroupBuyHeaderProtocol {
    var style: TBHomeGroupBuyHeaderCellStyle {
        return .recommand
    }
    
    var rowHeight: CGFloat {
        return 120
    }
    private var shopRecommand: ProbeShopDetail?

    
    
}
