//
//  TBRepeatTotalModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/4.
//

import Foundation
import UIKit


class TBRepeatTotalModel: TBMerchInfoModelProtocol {
    var totalScoreItems : [TBtotalScoreItem]?
    var evaluationDetails: TBEvaluationDetails?
    var commentScore: NSNumber = 0
    
    
    var style: pinLocationStyle = .evalutateTop
    
    var rowHeight: CGFloat {
        return 54
    }
    
    var rowCommentHeight: CGFloat {
        return rowHeight
    }
    
    var hasTopRadius: Bool {
        return isHasTopRadus
    }
    
    var hasBottomRadus: Bool {
        return isHasBottomRadus
    }
    
    var isHasBottomRadus: Bool
    var isHasTopRadus: Bool
    
    
    init(totalScoreItems: [TBtotalScoreItem]? = nil,
         evaluationDetails: TBEvaluationDetails? = nil,
         commentScore: NSNumber = 0,
         hasTopRadius: Bool = true, hasBottomRadius: Bool = false) {
        self.totalScoreItems = totalScoreItems
        self.evaluationDetails = evaluationDetails
        
        self.isHasTopRadus = hasTopRadius
        self.isHasBottomRadus = hasBottomRadius
    }
    
    
//    init(commentScore: OrderCommentScoreVO) {
//        self.scoreModel = commentScore
//    }
//    
//    init() {
//        self.scoreModel = OrderCommentScoreVO()
//    }

//    init(evaluationDetails: TBEvaluationDetails) {
//        self.evaluationDetails = evaluationDetails
//    }
    
    
    
}
