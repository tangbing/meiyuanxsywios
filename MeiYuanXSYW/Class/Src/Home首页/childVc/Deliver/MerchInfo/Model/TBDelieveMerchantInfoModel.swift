//
//  TBDelieveMerchatInfoModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/14.
//

import UIKit

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let tBDelieveMerchantInfoModel = try? newJSONDecoder().decode(TBDelieveMerchantInfoModel.self, from: jsonData)

import HandyJSON

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let tBDelieveMerchantInfoModel = try? newJSONDecoder().decode(TBDelieveMerchantInfoModel.self, from: jsonData)

import Foundation

// MARK: - TBDelieveMerchatInfoModel
class TBDelieveMerchatInfoModel: HandyJSON {
    var avgPrice: Double = 0.0
    var bookTime: String = ""
    var brandStory: String = ""
    var businessType: Int = 0
    var commentScore: Double = 0.0
    var commonCouponVos: [CommonCouponVo]?
    var distance: Double = 0.0
    var distributionAmt: Int = 0
    var merchantStatus: Int = 1
    var foodLicense: [String]?
    var goodsFullReduce: String?
    var isBook: Int = 0
    var isCollect: Bool = false
    var joinUpCoupon: Bool = false
    var merchantAddress : String = ""
    var merchantBackPic: String = ""
    var merchantCFullReduceVoList: [MerchantCFullReduceVoList]?
    var merchantFullReduce: String?
    var merchantId: String = ""
    var merchantLat: Double = 0
    var merchantLicense: [String]?
    var merchantLng: Double = 0
    var merchantLogo: String = ""
    var merchantName: String = ""
    var merchantPhone: [String] = [String]()
    var merchantPlaque: String = ""
    var merchantServe: String = ""
    var merchantTag: [String]?
    var minPrice: Int = 0
    var monthVolume: Int = 0
    var monthlySales: Int = 0
    var newCustomerFullReduce: String?
    var onDuty: Int = 0
    var openingHoursWeekVos: [OpeningHoursWeekVo]?
    var rankInfo : String = ""
    var storeNotice: String = ""
    var todayOpeningHours: String = ""
    var unionActivity: String?
    var weekPeriod: String = ""
    
    required init() {
    
    }

//    enum CodingKeys: String, CodingKey {
//        case avgPrice, bookTime, brandStory, businessType, commentScore, commonCouponVos, distance, distributionAmt, dutyStatus, foodLicense, goodsFullReduce, isBook, isCollect, joinUpCoupon, merchantAddress, merchantBackPic, merchantCFullReduceVoList, merchantFullReduce
//        case merchantID = "merchantId"
//        case merchantLat, merchantLicense, merchantLng, merchantLogo, merchantName, merchantPhone, merchantPlaque, merchantServe, merchantTag, minPrice, monthVolume, newCustomerFullReduce, onDuty, openingHoursWeekVos, rankInfo, storeNotice, todayOpeningHours, unionActivity, weekPeriod
//    }
}

// MARK: - CommonCouponVo
class CommonCouponVo: HandyJSON {
    var beginDate: String = ""
    /// 适用业务(0全部通用1外卖2私厨3团购)
    var businessType: Int = 0
    /// 优惠券领取记录id
    var couponHistoryId: Int = 0
    /// 优惠券id
    var couponId: Int = 0
    
    
    
    var couponName: String = ""
    /// 优惠券类型（2会员抵扣券3平台红包5商家券6商品券9会员权益券）
    var couponType: Int = 0
    /// 优惠金额
    var discountAmount: NSNumber = 0
    
    var endDate: String = ""
    /// 满减条件金额
    var fullReductionAmount : Int = 0
    /// 商家升级后的金额
    var merchantAmount: NSNumber = 0
    
    var merchantId: String = ""
    /// 领取状态 0未领取 1已领取 2未兑换 3已兑换
    var receiveStatus: Int = 0
    var remarks: String = ""
    var useCondition: Int = 0
    var useExplain: String = ""
    var useTimeSetting : Int = 0
    var validTime: Int = 0
    
    required init() {
    
    }

//    enum CodingKeys: String, CodingKey {
//        case beginDate, businessType
//        case couponHistoryID = "couponHistoryId"
//        case couponID = "couponId"
//        case couponName, couponType, discountAmount, endDate, fullReductionAmount, merchantAmount
//        case merchantID = "merchantId"
//        case receiveStatus, remarks, useCondition, useExplain, useTimeSetting, validTime
//    }
    
}

// MARK: - MerchantCFullReduceVoList
// MARK: - 用户C端满减部分返回Vo
class MerchantCFullReduceVoList: HandyJSON {
    /// 适用业务(0:外卖;1:团购;2:私厨;3:通用)
    var businessType:Int = 0
    
    /// 满足金额
    var accordPrice: NSNumber = 0.0
        
    /// 减少金额
    var reducePrice: NSNumber = 0.0
    
    /// 生效周期类型(0:每天;1:指定周期)
    var periodType: Int = 0
    
    /// 生效周期星期一 ——》星期天(1-7)
    var periodOn: String = ""
    
    /// 生效时段类型(0:全天;1:指定时间段)
    var effectType: Int = 0
    
    required init() {}
    
}

// MARK: - OpeningHoursWeekVo
class OpeningHoursWeekVo: HandyJSON {
    var hoursTimesVos: [HoursTimesVo]?
    var weekTime: [String]?
    
    required init() {
    
    }
}

// MARK: - HoursTimesVo
class HoursTimesVo: HandyJSON {
    var endTime: String = ""
    var startTime: String = ""
    
    required init() {
    
    }
}
