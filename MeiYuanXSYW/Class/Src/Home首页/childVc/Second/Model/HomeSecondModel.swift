//
//  HomeSecondModel.swift
//  MeiYuanXSYW
//
//  Created by Tb on 2022/2/28.
//

import Foundation
import HandyJSON
import SwiftyJSON
/*
"activityName": "真难活动",
     "activityNote": "皇天不负有心人啊",
     "activityStatus": 0,
     "applyBeginDate": "2021-11-26 13:53:51",
     "applyEndDate": "2021-12-26 13:53:51",
     "beginDate": "2022-02-28 14:00:00",
     "createBy": 0,
     "createTime": "2021-11-26 13:56:21",
     "dateSegment": "15:00",
     "endDate": "2022-02-28 17:59:00",
     "isDel": false,
     "joinGoodsNum": 0,
     "minDiscountAmt": 10,
     "minStock": 10,
     "orderCount": 0,
     "orderMoneyCount": 0,
     "remarks": "这是啥啊",
     "seckillActivityId": 4,
     "updateTime": "2022-02-28 14:22:46",
     "userCount": 0
*/


class HomeSecondActivityListModel: CLSwiftyJSONAble {
    /// 活动名称
    var activityName: String = ""
    /// 活动须知
    var activityNote: String = ""
    /// 状态(0活动中1未开始2未生效3已结束4已作废5进行中)
    var activityStatusStr: String = ""
    var activityStatus: Int = 0
    var applyBeginDate: String = ""
    var applyEndDate: String = ""
    var createBy: Int = 0
    var createTime: String = ""
    var dateSegment: String = ""
    var endDate: String = ""
    var isDel: Bool = false
    var joinGoodsNum: Int = 0
    var minDiscountAmt: Int = 0
    var minStock: Int = 0
    var orderCount: Int = 0
    var orderMoneyCount: Int = 0
    var remarks: String = ""

    var seckillActivityId: Int = 0

    var updateTime: String = ""
    
    var userCount: Int = 0
    
    var isSelect: Bool = false
    
    
    func getActivityStateString(state: Int) -> String {
        /// 状态(0活动中1未开始2未生效3已结束4已作废5进行中)
        if state == 0 {
            return "活动中"
        } else if(state == 1) {
            return "未开始"
        } else if(state == 2) {
            return "未生效"
        } else if(state == 3) {
            return "已结束"
        } else if(state == 3) {
            return "已作废"
        } else {
            return "进行中"
        }
    }
    
    required init?(jsonData: JSON) {

        activityName = jsonData["activityName"].stringValue
        activityNote = jsonData["activityNote"].stringValue

        activityStatus = jsonData["activityStatus"].intValue
        
        activityStatusStr = getActivityStateString(state: activityStatus)
        
        
        applyBeginDate = jsonData["applyBeginDate"].stringValue
        applyEndDate = jsonData["applyEndDate"].stringValue
        createBy = jsonData["createBy"].intValue
        createTime = jsonData["createTime"].stringValue
        dateSegment = jsonData["dateSegment"].stringValue
        endDate = jsonData["endDate"].stringValue

        isDel = jsonData["isDel"].boolValue
        joinGoodsNum = jsonData["joinGoodsNum"].intValue
        minDiscountAmt = jsonData["minDiscountAmt"].intValue
        minStock = jsonData["minStock"].intValue
        orderCount = jsonData["orderCount"].intValue
        orderMoneyCount = jsonData["orderMoneyCount"].intValue
        remarks = jsonData["remarks"].stringValue

        seckillActivityId = jsonData["seckillActivityId"].intValue

        updateTime = jsonData["updateTime"].stringValue
        userCount = jsonData["userCount"].intValue

    }


}


struct HomeSecondActivityGoodsModel: HandyJSON {
    
    var activityStatus: Int = 0
    var countDown: Int = 0
    var goodsListVoList: [GoodsListVoList] = [GoodsListVoList]()
    var seckillActivityId: Int = 0
}


// MARK: - GoodsListVoList
struct GoodsListVoList: HandyJSON {
    var activityGoodsRelationId: Int = 0
    var buyLimit: Int = 0
    var costStock: Int = 0
    var createTime: String = ""
    var discount: Int = 0
    var goodsId: String = ""
    var goodsItemVo: GoodsItemVo = GoodsItemVo()
    var goodsStatus: Int = 0
    var goodsType: Int = 0
    var joinType: Int = 0
    var merchantId: String = ""
    var merchantVo: MerchantVo = MerchantVo()
    var orderCount: Int = 0
    var orderTotalMoney: NSNumber = 0
    var originalPrice: NSNumber = 0
    var seckillActivityId: Int = 0
    var seckillPrice: NSNumber = 0
    var seckillStock: Int = 0
    var targetType: Int = 0
}

//// MARK: - GoodsItemVo
//struct GoodsItemVo: Codable {
//    var anytimeRetreat: Int
//    var attributesItem: [AttributesItem]
//    var businessType: Int
//    var categoryItem: [CategoryItem]
//    var createBy: String
//    var createTime: String
//    var discountRate: Int
//    var distance: Int
//    var expiredRetreat: Int
//    var goodsID: String
//    var goodsImageList: [String]
//    var goodsName: String
//    var goodsPackageVos: [GoodsPackageVo]
//    var goodsSales: Int
//    var goodsSort: Int
//    var goodsStatus: Int
//    var goodsType: Int
//    var groupItem: [GroupItem]
//    var holidayUse: Int
//    var id: Int
//    var isDel: Int
//    var isDiscount: Int
//    var isGroup: Int
//    var isReserve: Int
//    var isSeckill: Int
//    var material: String
//    var maxBuyDayNum: Int
//    var maxBuyNum: Int
//    var merchantDesc: String
//    var merchantID: String
//    var merchantName: String
//    var minAmount: Int
//    var minPrice: Int
//    var originalPrice: Int
//    var overlayNum: Int
//    var overlayStatus: Int
//    var packageMaxPrice: Int
//    var packageMinPrice: Int
//    var peopleNum: String
//    var picAddress: String
//    var praise: Int
//    var saleBeginDate: String
//    var saleEndDate: String
//    var salesItem: [SalesItem]
//    var sellPeriod: String
//    var sideLetter: String
//    var specItem: [SpecItem]
//    var stock: Int
//    var stockItem: [StockItem]
//    var tagItem: [TagItem]
//    var topPic: String
//    var totalNum: Int
//    var updateTime: String
//    var usableScope: String
//    var validDate: String
//    var validDay: Int
//    var voucherAmt: Int
//    var weekendUse: Int
//
//    enum CodingKeys: String, CodingKey {
//        case anytimeRetreat
//        case attributesItem
//        case businessType
//        case categoryItem
//        case createBy
//        case createTime
//        case discountRate
//        case distance
//        case expiredRetreat
//        case goodsID
//        case goodsImageList
//        case goodsName
//        case goodsPackageVos
//        case goodsSales
//        case goodsSort
//        case goodsStatus
//        case goodsType
//        case groupItem
//        case holidayUse
//        case id
//        case isDel
//        case isDiscount
//        case isGroup
//        case isReserve
//        case isSeckill
//        case material
//        case maxBuyDayNum
//        case maxBuyNum
//        case merchantDesc
//        case merchantID
//        case merchantName
//        case minAmount
//        case minPrice
//        case originalPrice
//        case overlayNum
//        case overlayStatus
//        case packageMaxPrice
//        case packageMinPrice
//        case peopleNum
//        case picAddress
//        case praise
//        case saleBeginDate
//        case saleEndDate
//        case salesItem
//        case sellPeriod
//        case sideLetter
//        case specItem
//        case stock
//        case stockItem
//        case tagItem
//        case topPic
//        case totalNum
//        case updateTime
//        case usableScope
//        case validDate
//        case validDay
//        case voucherAmt
//        case weekendUse
//    }
//}


// MARK: - CategoryItem
struct CategoryItem: HandyJSON {
    var categoryID: String = ""
    var categoryName: String = ""

}

// MARK: - GoodsPackageVo
struct GoodsPackageVo: HandyJSON {
    var goodsID: String = ""
    var goodsPackageItemVos: [GoodsPackageItemVo] = [GoodsPackageItemVo]()
    var packageID: Int = 0
    var packageName: String = ""
    var packageNum: Int = 0
    var packageType: Int = 0

}

//// MARK: - GoodsPackageItemVo
//struct GoodsPackageItemVo: HandyJSON {
//    var itemId: Int = 0
//    var itemName: String = ""
//    var itemNum: Int = 0
//    var packageId: Int = 0
//    var packageName: String = ""
//    var showPrice: NSNumber = 0
//
//}

// MARK: - GroupItem
struct GroupItem: HandyJSON {
    var goodsAmount: Int = 0
    var groupId: String = ""
    var groupName: String = ""
    var sort: Int = 0

}

// MARK: - SalesItem
struct SalesItem: HandyJSON {
    var salesId: String = ""
    var salesNum: Int = 0
    var specId: String = ""
}


// MARK: - TagItem
struct TagItem: HandyJSON {
    var tagId: String = ""
    var tagName: String = ""
}

// MARK: - MerchantVo
struct MerchantVo: HandyJSON {
    var avgPrice: Int = 0
    var bookTime: String = ""
    var brandStory: String = ""
    var businessType: Int = 0
    var commentScore: Int = 0
    var commonCouponVos: [CommonCouponVo] = [CommonCouponVo]()
    var distance: Int = 0
    var distributionAmt: Int = 0
    var foodLicense: [String] = [String]()
    var goodsFullReduce: String = ""
    var isBook: Int = 0
    var isCollect: Bool = false
    var joinUpCoupon: Bool = false
    var merchantAddress: String = ""
    var merchantBackPic: String = ""
    var merchantCFullReduceVoList: [MerchantCFullReduceVoList] = [MerchantCFullReduceVoList]()
    var merchantFullReduce: String = ""
    var merchantID: String = ""
    var merchantLat: Int = 0
    var merchantLicense: [String] = [String]()
    var merchantLng: Int = 0
    var merchantLogo: String = ""
    var merchantName: String = ""
    var merchantPhone: [String] = [String]()
    var merchantPlaque: String = ""
    var merchantServe: String = ""
    var merchantStatus: Int = 0
    var merchantTag: [String] = [String]()
    var minPrice: Int = 0
    var monthlySales: Int = 0
    var newCustomerFullReduce: String = ""
    var openingHoursWeekVos: [OpeningHoursWeekVo] = [OpeningHoursWeekVo]()
    var rankInfo: String = ""
    var storeNotice: String = ""
    var todayOpeningHours: String = ""
    var unionActivity: String = ""
    var weekPeriod: String = ""

}

//// MARK: - CommonCouponVo
//struct CommonCouponVo: HandyJSON {
//    var activityClassify: Int = 0
//    var beginDate: String = ""
//    var businessType: Int = 0
//    var couponHistoryId: Int = 0
//    var couponId: Int = 0
//    var couponName: String = ""
//    var couponType: Int = 0
//    var discountAmount: Int = 0
//    var endDate: String = ""
//    var fullReductionAmount: Int = 0
//    var issueTotalCount: Int = 0
//    var merchantAmount: Int = 0
//    var merchantID: String = ""
//    var obtEndDate: String = ""
//    var perLimit: Int = 0
//    var receiveStatus: Int = 0
//    var receivedNum: Int = 0
//    var remarks: String = ""
//    var useCondition: Int = 0
//    var useExplain: String = ""
//    var useTimeSetting: Int = 0
//    var validTime: Int = 0
//
//}

//// MARK: - MerchantCFullReduceVoList
//struct MerchantCFullReduceVoList: HandyJSON {
//    var accordPrice: NSNumber = 0
//    var businessType: Int = 0
//    var effectType: Int = 0
//    var periodOn: String = ""
//    var periodType: Int = 0
//    var reducePrice: NSNumber = 0
//}
//
//// MARK: - OpeningHoursWeekVo
//struct OpeningHoursWeekVo: HandyJSON {
//    var hoursTimesVos: [HoursTimesVo] = [HoursTimesVo]()
//    var weekTime: [String] = [String]()
//
//}
//
//// MARK: - HoursTimesVo
//struct HoursTimesVo: HandyJSON {
//    var endTime: String = ""
//    var startTime: String = ""
//
//}

 

