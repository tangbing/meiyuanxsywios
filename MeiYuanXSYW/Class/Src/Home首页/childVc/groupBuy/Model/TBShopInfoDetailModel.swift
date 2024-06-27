//
//  TBShopInfoDetailModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/16.
//

import Foundation
import UIKit


class TBShopInfoDetailModel: TBMerchInfoModelProtocol {
    
    var style: pinLocationStyle = .detainInfo
    
    var rowHeight: CGFloat {
        return UITableView.automaticDimension
    }
    
    var hasTopRadius: Bool {
        return isHasTopRadus
    }
    
    var hasBottomRadus: Bool {
        return isHasBottomRadus
    }
    
    var titleText: String
    var titleContent: String
  
    var isHasBottomRadus: Bool
    var isHasTopRadus: Bool
    
    init(titleText: String, titleContent: String, hasTopRadius: Bool = false, hasBottomRadius: Bool = false) {
        self.titleText = titleText
        self.titleContent = titleContent
        self.isHasTopRadus = hasTopRadius
        self.isHasBottomRadus = hasBottomRadius
    }
    
    
    
}
