//
//  TBGoodsInfoHeaderKillSecondModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2022/1/11.
//

import UIKit

class TBGoodsInfoHeaderKillSecondModel: TBShopInfoModelProtocol {
    
    var style: TBGoodsInfoHeaderStyle = .killSecond
    
    var rowHeight: CGFloat {
        return UITableView.automaticDimension
    }
    
    var hasTopRadius: Bool {
        return false
    }

    var hasBottomRadus: Bool {
        return false
    }
}
