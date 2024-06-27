//
//  TBShopInfoPacketDetailInfoModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/17.
//

import Foundation
import UIKit


class TBShopInfoPacketDetailInfoTitleModel: TBMerchInfoModelProtocol {
    
    var style: pinLocationStyle = .packageDetailInfoTitle
    
    var rowHeight: CGFloat {
        return UITableView.automaticDimension
    }
    
    var hasTopRadius: Bool {
        return isHasTopRadus
    }
    
    var hasBottomRadus: Bool {
        return isHasBottomRadus
    }
    
    var nameTitleText: String
 
  
    private var isHasBottomRadus: Bool
    private var isHasTopRadus: Bool
    var nameTitleFont: UIFont
    
    
    init(nameTitleText: String,nameTitleFont: UIFont = MYBlodFont(size: 14),  hasTopRadius: Bool = false, hasBottomRadius: Bool = false) {
        self.nameTitleText = nameTitleText
        self.nameTitleFont = nameTitleFont
        self.isHasTopRadus = hasTopRadius
        self.isHasBottomRadus = hasBottomRadius
    }
    
    
    
}
