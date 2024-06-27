//
//  XSMineViewModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/19.
//

import UIKit

class XSMineViewModel: XSBaseViewModel {
    enum ViewModeStyle {
        case ViewModeStyleDefault
        case ViewModeStyleHeader
        case ViewModeStyleHeaderCollection
        case ViewModeStyleOrder
        case ViewModeStyleOrderCollection
        case ViewModeStyleBanner
        case ViewModeStyleTool
        case ViewModeStyleToolCollection
    }
    var style = ViewModeStyle.ViewModeStyleDefault
        

}
class XSSetViewModel: XSBaseViewModel {
    enum ViewModeStyle {
        case ViewModeStyleDefault
        case ViewModeStyleLogout
        case ViewModeStyleCode
    }
    var style = ViewModeStyle.ViewModeStyleDefault
    var type = 0 // 1的时候是版本更新那里
    
}
