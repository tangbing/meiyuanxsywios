//
//  TBShopInfoPacketDetailInfoContentModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/17.
//

import UIKit

class TBShopInfoPacketDetailInfoContentModel: TBMerchInfoModelProtocol {
    
    var style: pinLocationStyle = .packageDetailInfoContent
    
    var rowHeight: CGFloat {
        return 25
    }
    
    var hasTopRadius: Bool {
        return isHasTopRadus
    }
    
    var hasBottomRadus: Bool {
        return isHasBottomRadus
    }
    
    var nameTitleText: String
    var priceTitleText: String
    var numShop: Int
 
  
    private var isHasBottomRadus: Bool
    private var isHasTopRadus: Bool
    
    
    init(nameTitleText: String,numShop: Int, priceTitleText: String,hasTopRadius: Bool = false, hasBottomRadius: Bool = false) {
        self.numShop = numShop
        self.nameTitleText = nameTitleText
        self.priceTitleText = priceTitleText
        self.isHasTopRadus = hasTopRadius
        self.isHasBottomRadus = hasBottomRadius
    }
    
    
    
}
