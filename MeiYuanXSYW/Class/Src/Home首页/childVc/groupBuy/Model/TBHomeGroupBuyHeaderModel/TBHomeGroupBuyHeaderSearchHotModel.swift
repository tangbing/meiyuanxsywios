//
//  TBHomeGroupBuyHeaderSearchHotModel.swift
//  MeiYuanXSYW
//
//  Created by Tb on 2022/3/2.
//

import Foundation
import UIKit

class TBHomeGroupBuyHeaderSearchHotModel: TBHomeGroupBuyHeaderProtocol {
    var style: TBHomeGroupBuyHeaderCellStyle {
        return .searchHot
    }
    
    var rowHeight: CGFloat {
        return 36
    }
    private var searchDiscoverSigns: [String] = [String]()
    
    
    
}
