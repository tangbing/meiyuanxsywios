//
//  TBPacketModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/4.
//

import Foundation
import UIKit


class TBPacketModel: TBMerchInfoModelProtocol {
    
    var comboDetail: TBComboDetails

    var style: pinLocationStyle = .package
    
    var rowHeight: CGFloat {
        return 120
    }
    
    init(comboDetail: TBComboDetails) {
        self.comboDetail = comboDetail
    }
    
  
    
    
}
