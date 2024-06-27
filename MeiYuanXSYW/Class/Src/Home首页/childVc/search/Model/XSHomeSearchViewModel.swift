//
//  XSHomeSearchViewModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2022/2/16.
//

import Foundation
import UIKit

enum TBHomeSearchCellStyle {
    /// 商品搜索
    case goodsSearch
    /// 商家搜索
    case merchInfoSearch
    /// 显示更多搜索
    case moreSearch
    /// 搜索结果少，显示推荐数据
    case resultLessSearch
}

protocol TBHomeSearchProtocol {
    var searchStyle: TBHomeSearchCellStyle { get }
    
    var cellHeight: CGFloat { get }
}

struct TBHomeSearchGoodsModel: TBHomeSearchProtocol {
    
    var searchGoodsModel: XSHomeGoodsSearchData
    var searchStyle: TBHomeSearchCellStyle {
        return .goodsSearch
    }
    var cellHeight: CGFloat {
        return 110
    }
    init(searchGoodsModel: XSHomeGoodsSearchData) {
        self.searchGoodsModel = searchGoodsModel
    }

}

struct TBHomeSearchMerchantModel: TBHomeSearchProtocol {
    
    var searchMerchantModel: XSHomeMerchantData

    var searchStyle: TBHomeSearchCellStyle {
        return .merchInfoSearch
    }
    
    var cellHeight: CGFloat {
        return 272
    }
    
    init(searchMerchantModel: XSHomeMerchantData) {
        self.searchMerchantModel = searchMerchantModel
    }
}

struct TBHomeSearchMoreModel: TBHomeSearchProtocol {
    var searchStyle: TBHomeSearchCellStyle {
        return .moreSearch
    }
    
    var cellHeight: CGFloat {
        return 44
    }
}

struct TBHomeSearchResultLessModel: TBHomeSearchProtocol {
    var searchStyle: TBHomeSearchCellStyle {
        return .resultLessSearch
    }
    
    var cellHeight: CGFloat {
        return 20
    }
}


