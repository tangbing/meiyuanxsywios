//
//  TBRepeatModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/4.
//

import Foundation
import UIKit



class TBRepeatModel: TBMerchInfoModelProtocol {
    
    var bottomRadius: CGFloat = 0.0
    var style: pinLocationStyle = .evalutate
//    var headImg: String = ""
//    var userName: String = ""
//    var userCommentDate: String = ""
//    var shopScore: Double = 4.0
//    var shopEvalute: String = ""
    var evaluationModel: EvaluationDetail?
    var commentModel : OrderCommentModel?
    
    //var userComment: String = ""
    
    var rowCommentHeight: CGFloat  {
        guard let commentModel = commentModel else { return 0.0 }

        var _cellH: CGFloat = 10.0
        let topViewH: CGFloat = 35
        _cellH += topViewH
        
        
        _cellH += krepeatMargin
        _cellH += commentModel.userCommentH
        
        if let _ = commentModel.commentPicStr {
            _cellH += 7
            _cellH += commentModel.commentPicStrH
        }
        
        
        if let _ = commentModel.orderCommentGoodsVOList {
            _cellH += krepeatMargin
            let infoViewH: CGFloat = krepeat_infoH
            _cellH += infoViewH
        }
        
        if let _ = commentModel.merchantReplyComment {
            _cellH += 2 * krepeatMargin
            _cellH += 33
            _cellH += commentModel.merchantReplyCommentH
            
        }
        
        _cellH = _cellH + 18
        
        return _cellH
    }
    
    
    
    var rowHeight: CGFloat  {
        guard let evaluationModel = evaluationModel else { return 0.0 }

        var _cellH: CGFloat = 10.0
        let topViewH: CGFloat = 35
        _cellH += topViewH
        
        
        _cellH += krepeatMargin
        _cellH += evaluationModel.userCommentH
        
        if let _ = evaluationModel.commentPicStr {
            _cellH += 7
            _cellH += evaluationModel.commentPicStrH
        }
        
        
        if let _ = evaluationModel.evaluationGoods {
            _cellH += krepeatMargin
            let infoViewH: CGFloat = krepeat_infoH
            _cellH += infoViewH
        }
        
        if let _ = evaluationModel.merchantReplyComment {
            _cellH += 2 * krepeatMargin
            _cellH += 33
            _cellH += evaluationModel.merchantReplyCommentH
            
        }
        
        _cellH = _cellH + 18
        
        return _cellH
    }
    
    init(evaluationModel: EvaluationDetail? = nil,commentModel : OrderCommentModel? = nil, botttomRadius: CGFloat = 0) {
        self.evaluationModel = evaluationModel
        self.commentModel = commentModel
        self.bottomRadius = botttomRadius
    }
    
    
    
//    init(shopIcon: String, shopName: String, shopTime: String ,shopScore: Double, evaluate: String, commentContent: String, repeatPics: [String]?, shopInfo_curPrice: String, shopInfo_oldPrice: String, shopRepeat: String?, shopRepeatDate: String? = "111", botttomRadius: CGFloat = 0) {
//
//        self.shopIcon = shopIcon
//        self.shopName = shopName
//        self.shopScore = shopScore
//        self.shopEvalute = evaluate
//        self.commentContent = commentContent
//        self.repeatPics = repeatPics
//        self.shopInfo_curPrice = shopInfo_curPrice
//        self.shopInfo_oldPrice = shopInfo_oldPrice
//        self.shopRepeat = shopRepeat
//        self.shopRepeatDate = shopRepeatDate
//        self.bottomRadius = botttomRadius
//        self.shopTime = shopTime
//    }
    
}
