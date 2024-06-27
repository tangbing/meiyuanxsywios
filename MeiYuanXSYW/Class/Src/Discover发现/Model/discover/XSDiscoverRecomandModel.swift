//
//  XSDiscoverRecomendModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/2.
//

import UIKit

class XSDiscoverRecomandModel: XSDiscoverModelProtocol {
    
    var style: XSDiscoverType = .recommand
    
    var rowHeight: CGFloat {
        return contentHeight + photoViewHeight + 54.0 + 6 + 6 + 42 + 90 + 15 + 10
    }
    
    var hasTopRadius: Bool
    var hasBottomRadius: Bool
    var content: String
    var pics: [String]?
    let contentW = screenWidth - 60
    let kImageContainerWidth = screenWidth - 20 - 60
    let kPhotoMargin : CGFloat = 5

    
    
    var contentHeight: CGFloat {
        let content_height = content.jk.rectHeight(font: MYFont(size: 13), size: CGSize(width:contentW , height: CGFloat(MAXFLOAT)))
        return content_height
    }
    
    var kPhotoSizeW: CGFloat {
        return (kImageContainerWidth - (CGFloat(3)) * kPhotoMargin) / CGFloat(3)
    }
    
    var photoViewHeight : CGFloat {
      
        if let pics = pics {
            let maxCount = getMaxColCount()
            let totalCol = pics.count % maxCount
            let totalRow = totalCol != 0  ? pics.count / maxCount + 1 : pics.count / maxCount
            let height = CGFloat(totalRow) * (kPhotoSizeW + kPhotoMargin) - kPhotoMargin;
            return height
        } else {
            return 0
        }
       
    }
    
    func getMaxColCount() -> Int {
        if let pics = pics {
           return pics.count == 4 ? 2 : 3
        }
        return 0
    }
    
    init(content:String, pics: [String]?, hasTopRadius: Bool = false, hasBottomRadius: Bool = false) {
        self.content = content
        self.pics = pics
        
        self.hasTopRadius = hasTopRadius
        self.hasBottomRadius = hasBottomRadius
    }
    
}
