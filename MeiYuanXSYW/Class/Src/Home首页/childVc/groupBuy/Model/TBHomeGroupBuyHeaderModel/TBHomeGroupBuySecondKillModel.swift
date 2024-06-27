//
//  TBHomeGroupBuySecondKillModel.swift
//  MeiYuanXSYW
//
//  Created by Tb on 2022/3/2.
//

import Foundation
import UIKit

class TBHomeGroupBuySecondKillModel: TBHomeGroupBuyHeaderProtocol {
    var style: TBHomeGroupBuyHeaderCellStyle {
        return .killSecond
    }
    
    var rowHeight: CGFloat {
        return 160
    }
    private var secKillGoods: [SecKillGoodsVos] = [SecKillGoodsVos]()
    
    
}
