//
//  TBHomeGroupBuyHeaderViewModel.swift
//  MeiYuanXSYW
//
//  Created by Tb on 2022/3/2.
//

import Foundation
import UIKit

enum TBHomeGroupBuyHeaderCellStyle {
    case searchHot /// 搜索推荐
    case kingKongArea /// 金刚图
    case banner /// 轮播图
    case recommand /// 好店推荐
    case killSecond /// 秒杀
}

protocol TBHomeGroupBuyHeaderProtocol {
    var style: TBHomeGroupBuyHeaderCellStyle { get }
    var rowHeight: CGFloat { get }
//    var hasTopRadius: Bool { get }
//    var hasBottomRadus: Bool { get }
}

