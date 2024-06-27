//
//  File.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/10/27.
//

import Foundation
import UIKit

enum TBHomeStyle {
    /// 首页聚合
    case homeDefault
    /// 外卖
    case delivery
    /// 团购
    case groupBy
    /// 私厨
    case privateKitchen

    /// 秒杀界面秒杀颜色
    var secondColor: UIColor {
        switch self {
        case .homeDefault:
            return UIColor.hex(hexString: "#F6094C")
        case .delivery:
            return UIColor.hex(hexString: "#0A9FFB")
        case .groupBy:
            return UIColor.hex(hexString: "#A46EFF")
        default:
            return UIColor.red
        }
    }
    
    /// 秒杀界面背景图片
    var image: UIImage? {
        switch self {
            case .homeDefault:
                return UIImage(named: "home_second_bg_icon")
            case .delivery:
                return UIImage(named: "home_deliver_second_bg")
            case .groupBy:
                return UIImage(named: "home_groupBuy_second_bg")
            default:
                return UIImage(named: "home_second_bg_icon")
            }
    }

}
