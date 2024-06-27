//
//  HomeModel.swift
//  MeiYuanXSYW
//
//  Created by admin on 2022/2/15.
//

import Foundation
import HandyJSON

struct XSHomeBannerAndNoticModel: HandyJSON {
    var advertiseDetails: [AdvertiseDetail] = [AdvertiseDetail]()
    var noticeDetails: [NoticeDetail] = [NoticeDetail]()
    var kingkongDetals: [KingkongDetal] = [KingkongDetal]()
}

/// 金刚区详情
struct KingkongDetal: HandyJSON {
    /// 金刚区图标
    var icon: String = ""
    
    /// 公告ID
    var id: Int = 0
    
    /// 跳转地址
    var linkAddr: String = ""
    
    /// 金刚区名\
    var name: String = ""
    
    /// 序号，越小代表越靠前
    var serialNumber: Int = 0
    
    /// 金刚区，聚合首页本地图标
    var loacalIcon: String = ""

}

struct AdvertiseDetail: HandyJSON {
    var advertiseLink: String = ""
    var advertiseName: String = ""
    var advertisePic: String = ""
    var id: Int = 0
}

struct NoticeDetail: HandyJSON {
    var content: String = ""
    var title: String = ""
    var id: Int = 0
}


struct XSHomeSecondAndTicketModel: HandyJSON {
    var secKillHomePageVo: SecKillHomePageVo?
    var freeCouponVos: [FreeCouponVoData] = [FreeCouponVoData]()
}

class FreeCouponVoData: HandyJSON {
    var beginDate: String = ""
    /// 适用业务(0全部通用1外卖2私厨3团购)
    var businessType: Int = 0
    /// 优惠券id
    var couponId: Int = 0
    var couponName: String = ""
    /// 优惠券类型（2会员抵扣券3平台红包5商家券6商品券9会员权益券）
    var couponType: Int = 0
    /// 优惠金额
    var discountAmount: NSNumber = 0
    var endDat: String = ""
    /// 满减条件金额
    var fullReductionAmount: NSNumber = 0
    /// 发行状态（0领取中1未开始2已结束4已抢完）
    var issueStatus: Int = 0
    /// 发放总量
    var issueTotalCount: Int = 0
    var marketingActivityId: Int = 0
    var merchantId: String = ""
    /// 商家图片集合
    var merchantImageList: [String] = [String]()
    var merchantName: String = ""
    /// 领券结束时间
    var obtEndDate: String = ""
    /// 已领取数
    var receivedNum: Int = 0
    /// 使用门槛（0无门槛1满减2月卡可用3季卡可用4年卡可用）
    var useCondition: Int = 0
    /// 使用说明
    var useExplain: String = ""
    
    /// 使用状态（0未使用1已使用2已过期）
    var useStatus: Int = 0
    
    var endDate: String = ""
    
    var isSelect: Bool = false

    
    var height: CGFloat {
        get {
            if isSelect {
                return 160
            } else {
                return 100
            }
        }
        set {
            
        }
    }
    
    required init() {
        
    }

}

struct SecKillHomePageVo: HandyJSON {
    /// 秒杀场次
    var dateSegment: String = ""
    var secKillGoodsVos: [SecKillGoodsVos] = [SecKillGoodsVos]()
    /// 秒杀活动id
    var seckillActivityId: Int = 0
    /// 倒计时 秒
    var countDown: Int = 0
}

struct SecKillGoodsVos: HandyJSON {
    var discount: NSNumber = 0
    var goodsId: String = ""
    var goodsName: String = ""
    var goodsType: Int = 0
    var merchantId: String = ""
    var merchantLogo: String = ""
    var originalPrice: NSNumber = 0
    var seckillPrice: NSNumber = 0
    var topPic: String = ""
}


struct XSHomeHeaderShopReommand: HandyJSON {
    /// 探店详情
    var probeShopDetails: [ProbeShopDetail] = [ProbeShopDetail]()
    /// 探店时间类型
    var timeType: String = ""
}

struct ProbeShopDetail: HandyJSON {
    var bizType: String = ""
    var probeShopMerchantDetails: [ProbeShopMerchantDetail] = [ProbeShopMerchantDetail]()
}

struct ProbeShopMerchantDetail: HandyJSON {
    var merchantId: String = ""
    var merchantLogo: String = ""
    var merchantName: String = ""
    var topPic: String = ""
}



struct XSHomeSearchDiscoverModel: HandyJSON {
    var data: String = ""
}
