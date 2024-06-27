//
//  TBShopInfoBuyMustKnowModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/17.
//

import UIKit


class TBShopInfoBuyMustKnowModel: TBMerchInfoModelProtocol {
    
    var style: pinLocationStyle = .buyMustKnow
    
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
    var contentIcon: String
    var contentText: String?
 
  
    private var isHasBottomRadus: Bool
    private var isHasTopRadus: Bool
    
    
    init(titleText: String, contentIcon: String,contentText: String?, hasTopRadius: Bool = false, hasBottomRadius: Bool = false) {
        self.titleText = titleText
        self.contentIcon = contentIcon
        self.contentText = contentText
        self.isHasTopRadus = hasTopRadius
        self.isHasBottomRadus = hasBottomRadius
    }
    
    
    
}
