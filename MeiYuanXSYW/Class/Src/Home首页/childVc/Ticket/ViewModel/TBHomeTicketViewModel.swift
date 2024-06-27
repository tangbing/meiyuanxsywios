//
//  TBHomeTicketViewModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/21.
//

import UIKit
import Foundation


class TBHomeTicketViewModel: XSBaseViewModel {
    enum ViewModeStyle {
        case ViewModeStyleDefault
        case ViewModeStyleHeader
        case ViewModeStyleSection
        case ViewModeStyleTicketBySelf
    }
    var style = ViewModeStyle.ViewModeStyleDefault
    var type = 0 //ViewModeStyleSection 区分vip 会员商家和加量包头  ViewModeStyleTicket0会员，1商家区分商家红包和会员红包
    var hasLine = true //ViewModeStyleMerchant 是否有下面的分割线
    var hasBottomRadiu = false //ViewModeStyleMerchant 是否有下面的分割线
    var isUsed = false //ViewModeStyleTicket 是否已使用
    
}

