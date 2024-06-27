//
//  XSaa.swift
//  MeiYuanXSYW
//
//  Created by admin on 2022/1/11.
//

import UIKit

class TBGoodsInfoHeaderPiclModel: TBMerchInfoModelProtocol {
    
    private var isHasBottomRadus: Bool
    private var isHasTopRadus: Bool
    var picAddress: [String]
    
    var style: pinLocationStyle = .goodsInfoPicArray
    
    var rowHeight: CGFloat {
        return screenWidth * 3 / 4
    }
    
    var hasTopRadius: Bool {
        return isHasTopRadus
    }

    var hasBottomRadus: Bool {
        return isHasBottomRadus
    }
    
    init(picAddress: [String],hasTopRadius: Bool = false, hasBottomRadius: Bool = false) {
        self.picAddress = picAddress
        self.isHasBottomRadus = hasTopRadius
        self.isHasTopRadus = hasBottomRadius
    }
    
    
//    var hasTopRadius: Bool {
//        return isHasTopRadus
//    }
//
//    var hasBottomRadus: Bool {
//        return isHasBottomRadus
//    }
//
//    var titleText: String
//    var titleContent: String
//
//    var isHasBottomRadus: Bool
//    var isHasTopRadus: Bool
//
//    init(titleText: String, titleContent: String, hasTopRadius: Bool = false, hasBottomRadius: Bool = false) {
//        self.titleText = titleText
//        self.titleContent = titleContent
//        self.isHasTopRadus = hasTopRadius
//        self.isHasBottomRadus = hasBottomRadius
//    }
    
    
    
}
