//
//  TBShopInfoPacketDetailMoreModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/18.
//

import Foundation
import UIKit


class TBShopInfoPacketDetailMoreModel : TBMerchInfoModelProtocol {
    var style: pinLocationStyle = .packageDetailMore

    var rowHeight: CGFloat {
        return 80
    }
    
    var hasTopRadius: Bool {
        return isHasTopRadus
    }
    
    var hasBottomRadus: Bool {
        return isHasBottomRadus
    }
    
    private var isHasBottomRadus: Bool
    private var isHasTopRadus: Bool
    var priceText: String

    
    init(priceText: String, hasTopRadius: Bool = false, hasBottomRadius: Bool = false) {
        self.priceText = priceText
        self.isHasTopRadus = hasTopRadius
        self.isHasBottomRadus = hasBottomRadius
    }
    
   
}
