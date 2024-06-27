//
//  XSVipViewModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/19.
//

import UIKit

class XSVipViewModel: XSBaseViewModel {
    enum ViewModeStyle {
        case ViewModeStyleDefault
        case ViewModeStyleHeader
        case ViewModeStyleBuy
        case ViewModeStyleSection
        case ViewModeStyleMerchant(model:CLMerchantSimpleVoModel)
        case ViewModeStyleMore
        case ViewModeStyleTicket(model:Any)
        case ViewModeStyleUsed
        case ViewModeStyleBuyAuth
        case ViewModeStyleBuyAuthCollect
        case ViewModeStyleAddBuy

//        case ViewModeStyleToolCollection
    }
    var style = ViewModeStyle.ViewModeStyleDefault
    var type = 0 //ViewModeStyleSection 区分vip 会员商家和加量包头  ViewModeStyleTicket0会员，1商家区分商家红包和会员红包
    var hasLine = true //ViewModeStyleMerchant 是否有下面的分割线
    var hasBottomRadiu = false //ViewModeStyleMerchant 是否有下面的分割线
    var isUsed = false //ViewModeStyleTicket 是否已使用
}

class XSVipTicketModel: XSBaseViewModel {//我的红包卡券
    var ruleExpand = false //

}
