//
//  WebAPIS.swift
//  SwiftDemo
//
//  Created by sam   on 2020/4/14.
//  Copyright © 2020 sam  . All rights reserved.
//https://github.com/Moya/Moya/blob/master/docs_CN/Examples/Basic.md

import Foundation
import Moya
import UIKit
import SwiftUI
import JKSwiftExtension


enum MerchantService {
    
    /// 用户C端首页获取轮播图和公告数据  广告位置类型（0：首页 1：团购）
    /// 金刚区位置类型 （0：外卖金刚区，1：团购金刚区，2：私厨金刚区
    
    case getIndexPageTopPart(advertiseAreaType: Int?,kingKongAreaType: Int?)
    
    /// 获取首页秒杀和领券列表  0:外卖;1:团购
    case getMarketingHomePageVo(goodsType: Int?)
    
    /// 首页探店获取推荐商品商家数据 flag: 0:外卖 1:团购 2:全部
    case getFrontPageProbeShopRecommend(lat: Double, lng: Double, flag: Int)
    

    /// 用户C端首页商品搜索
    case indexPageGoodsSearch(lat: Double, lng: Double, merchantOrGoodsName: String,businessType: String,page: Int, pageSize: Int )
    
    /// C端首页商家搜索
    case indexPageMerchantSearch(lat: Double, lng: Double, merchantOrGoodsName: String,businessType: String,page: Int, pageSize: Int )
    
    /// 用户C端搜索后底部商品推荐获取
    case getSearchBottomGoods(lat: Double, lng: Double,page: Int, pageSize: Int)

    
    /// C端获取我的优惠券列表
    /// couponStatus 优惠券状态(0正常1无效)
    /// useStatus  优惠券使用状态（0未使用1已使用2已过期）
    case homeGetMyCoupon(couponStatus: Int, useStatus: Int, userId: Int,page: Int, pageSize: Int)
    
    /// C端获取免费领券列表
    case homeGetFreeCoupon(userId: Int,page: Int, pageSize: Int)
    
//    /// 用户附近的店铺
//    case getNearByGoodStore(lat: Double, lng: Double)
    
    
    
    /// 用户C端私厨首页
    case getPrivateChefPage(page: Int, pageSize: Int)
    
    
    /// C端获取秒杀活动列表
    case secKillActivityList(_ dic: [String:Any])
    
    
    /// 获取金刚区和轮播图数据
    case getGroupBuyPageTopPart(kingKongAreaType: Int)
    
    
    /// 点击金刚区跳转获取数据
    case getJumpKingkongDistrictData(bizType: Int, kingkongId: Int, lat: Double, lng: Double)
    
    
    /// C端获取秒杀商品列表
    case secKillActivityGoodsList(businessType: Int, secKillActivityId: Int, lat: Double, lng: Double,page: Int, pageSize: Int)

    
   
    
    
    /// 用户C端首页综合
    
    /*
    administrativeArea    string
    行政区

    bizType    integer($int32)
    业务类型 0:外卖;1:团购;2:私厨

    categoryName    string
    商品品类名称

    deliveryFeeAsc    number
    配送费正序 传0即可

    distance    integer($int32)
    距离优先 传0即可

    goodsPriceMax    integer($int32)
    价格倒序 传0即可

    goodsPriceMin    integer($int32)
    价格正序 传0即可

    goodsSales    integer($int32)
    销量优先 传0即可

    goodsType    integer($int32)
    前端传的业务类型0:外卖;1:团购;2:私厨

    latitude    number($double)
    用户当前纬度

    longitude    number($double)
    用户当前经度

    minpriceAsc    number
    起送费正序 传0即可

    nearbyDistance    integer($int32)
    距离

    page    integer($int32)
    当前页数

    pageSize    integer($int32)
    每页大小

    praise    integer($int32)
    好评优先 传0即可
     
     */
    
    case getComprehensive(administrativeArea: String? = nil, categoryName: String? = nil,deliveryFeeAsc: Int? = nil,
                          distance: Int? = nil, goodsPriceMax: Int? = nil, goodsPriceMin: Int? = nil, goodsSales: Int? = nil,
                          goodsType: Int? = nil, latitude: Double, longitude: Double, minpriceAsc: Int? = nil,
                          nearbyDistance: Int? = nil, praise: Int? = nil, page: Int, pageSize: Int)
    
    /// 用户C端首页发现好菜
    case discoverGoodDishes(administrativeArea: String? = nil, categoryName: String? = nil,deliveryFeeAsc: Int? = nil,
                            distance: Int? = nil, goodsPriceMax: Int? = nil, goodsPriceMin: Int? = nil, goodsSales: Int? = nil,
                            goodsType: Int? = nil, latitude: Double, longitude: Double, minpriceAsc: Int? = nil,
                            nearbyDistance: Int? = nil, praise: Int? = nil, page: Int, pageSize: Int)
    
    
    

    
    
    /// 判断距离是否符合商家配送范围
    case conformUser2MerchantDistance(_ lat1: Double, _ lng1: Double, _ merchantId: String)
    /// C端通过商家Id查询商家详情(头信息)
    case getMerchantPage(_ lat1: Double, _ lng1: Double, _ merchantId: String,bizType: Int)
    /// <##>获取商家详情页领券列表
    case getMerchantCouponList(_ merchantId: String)
    /// C端领取优惠券
    case receiveCoupon(couponId: Int)
    /// C端兑换商家红包 (返回2 表示不是会员)
    case exchangeMerchantCoupon(_ merchantId: String)
    /// 商家首页商品信息
    case getGoodsInfo(_ merchantId: String)
    /// 单规格更改购物车的数量，不要传specId，attributesIdList
    case updateOneSpecShoppingTrolleyCount(_ account: Int, goodsId: String,
                                     merchantId: String)
    /// 多规格更改购物车的数量，要传specId，attributesIdList
    case updateShoppingTrolleyCount(_ account: Int, attributesIdList: String, goodsId: String,
                                     merchantId: String, specId: String)
    
    /// 通过购物车ID更改购物车的数量
    case updateShoppingTrolleyCountById(_ account: UInt, id: Int,
                                         merchantId: String)
    /// 商家进入返回的购物车数据
    case  getOrderMerchantInCarVO(_ merchantId: String)
    
    /// 删除购物车全部商品或者清理无效商品 购物车状态0失效1生效(C端清空无效宝贝需要填该状态)
    
    case delTrolleyOrNoEfficacy(_ merchantId: String, status: Int?)
    
    /// 商家评价分页列表(分页) 全部评价0，晒图1,2获得回复.3低分，4最新。（012是我的评价，0134是商家评价）,（用户C端传入）
    case getMerchantCommentPageResult(_ merchantId: String, page: Int, pageSize: Int, bizType: Int, commentType: Int)
    /// 商家店内搜索商品
    case shopSearchGoods(_merchantId: String, goodsName: String)
    
    /// 保存商家投诉
    case saveMerchantComplaint(_merchantId: String, uploadPicStr: [String]?, remark: String,complaintContent:[Int])
    
    
    /// C端商家详情获取聚合数据- 团购-聚合商家商家详情获取的数据
    case getMerchantDetailPolymerization(_merchantId: String, flag: Int)

    /// 附件好店的商家和商品信息, 团购，聚合商家详情页面的更多商家数据
    case getNearByStoreAndGoods(_businessType: String, lat1: Double, lng1: Double,page: Int, pageSize: Int)
    
    
    ///  商品详情 用户C端获取单个商品详情,业务类型 0:外卖;1:团购;2:私厨;4:优惠券
    case getSingleGoodsItem(_ bizType: Int, goodsId: String)

    ///  商品详情 操作收藏商品    integer($int32)
    ///  goodsType 商品类型 0外卖1私厨2团购 收藏时传
    ///  type 0收藏 1取消收藏
    case saveCollectGoods(_merchantId: String, goodsId: String, goodsType: Int?, type: Int)
    
    
    ///  商家详情 收藏商家
    ///  type   0收藏 1取消收藏
    case saveCollectMerchant(_merchantId: String, type: Int)
    

    ///  购物车 获取购物车商品信息 bizType 0外卖，1团购，2私厨,4会员,
    ///  是否有效 isEfficacy true，有效，false 无效
    case getOrderShoppingVOByUserId(_ bizType: Int?, isEfficacy: Bool, lat: Double, lng: Double,page: Int, pageSize: Int)
    
    ///  购物车 C端获取商品规格属性
    case getGoodsSpecsAttributes(_merchantId: String, goodsId: String)
    
    ///  购物车 C端获取商品规格属性
    case updateShoppingTrolleySpecAttributesId(_ID:Int, goodsId: String,attributesIdList:String, specId: String)
    
    ///  购物车 通过购物车ID批量删除购物车数据
    case delTrolleyByIdList(_idList: [Int])
    
    ///  购物车 计算购物车的金额
    ///  是否结清。购物车时勾选false，结算的时候点击true.结算的时候前端需要传经纬度
    case calculateMoreCarAmt(_idList: [Int], isSettle: Bool)
    
    /// 购物车 获取商家的优惠券
    case getMerchantCoupon(_ merchantId: String)
     

    /// 获取用户信息
    case getUserInfo
    
    /// 修改用户信息
    case updateUserInfo(params: [String : Any])

   /// 修改手机号
    case updateUserMobile(params: [String : Any])

    /// 注销账号
    case userCloseAccount
    
    /// 发送短信
    case sendsms(mobile: String)
    
    
    /// 获取问题列表-分页
    case userQuestionList(page: Int, pageSize: Int)
    
    /// C端登录注册
    /// clientChannel 0app 1小程序 2PC端 3H5
   case loginAuthCode(params: [String : Any])
    
    
    /// 获取所有的反馈类型
    case userFeedbackTypeList
    
    /// 增加用户反馈
    case userFeedbackAdd(params: [String : Any])
   
    
    /// 批量上传图片
    case batchUpload(_ images: [UIImage])
    
    
    
}

extension MerchantService : TargetType {
    
    var baseURL: URL {
        return Api.Moya_baseURL
    }
    
    var path: String {
        switch self {
        case .getIndexPageTopPart:
            return Api.getIndexPageTopPart
        case .getMarketingHomePageVo:
            return Api.getMarketingHomePageVo
        case .getFrontPageProbeShopRecommend:
            return Api.getFrontPageProbeShopRecommend
        case .indexPageGoodsSearch:
            return Api.indexPageGoodsSearch
        case .indexPageMerchantSearch:
            return Api.indexPageMerchantSearch
        case .getSearchBottomGoods:
            return Api.getSearchBottomGoods
        case .homeGetFreeCoupon:
            return Api.homeGetFreeCoupon
        case .homeGetMyCoupon:
            return Api.homeGetMyCoupon
        case .getPrivateChefPage:
            return Api.getPrivateChefPage
        case .secKillActivityList(_):
            return Api.secKillActivityList
            
        case .getGroupBuyPageTopPart:
            return Api.getGroupBuyPageTopPart
        case .getJumpKingkongDistrictData:
            return Api.getJumpKingkongDistrictData
        case .secKillActivityGoodsList:
            return Api.secKillActivityGoodsList
       
        case .getComprehensive:
            return Api.getComprehensive
        case .discoverGoodDishes:
            return Api.discoverGoodDishes
            
            
        /// 判断距离是否符合商家配送范围
        case .conformUser2MerchantDistance(_, _, _):
            return Api.conformUser2MerchantDistance
        case .getMerchantPage(_, _, _, _):
            return Api.getMerchantPage
        case .getMerchantCouponList(_):
            return Api.getMerchantCouponList
        case .receiveCoupon(_):
            return Api.receiveCoupon
        case .exchangeMerchantCoupon(let merchantId):
            return Api.exchangeMerchantCoupon + "\(merchantId)"
        case .getGoodsInfo(_):
            return Api.getGoodsInfo
        case .updateShoppingTrolleyCount(_, _, _, _, _):
            return Api.updateShoppingTrolleyCount
        case .updateShoppingTrolleyCountById:
            return Api.updateShoppingTrolleyCountById
        case .getOrderMerchantInCarVO:
            return Api.getOrderMerchantInCarVO
        case .delTrolleyOrNoEfficacy:
            return Api.delTrolleyOrNoEfficacy
        case .updateOneSpecShoppingTrolleyCount:
            return Api.updateShoppingTrolleyCount
        case .getMerchantCommentPageResult:
            return Api.getMerchantCommentPageResult
        case .shopSearchGoods:
            return Api.shopSearchGoods
        case .saveMerchantComplaint:
            return Api.saveMerchantComplaint
        case .batchUpload:
            return Api.batchUpload
        case .getMerchantDetailPolymerization:
            return Api.getMerchantDetailPolymerization
        case .getNearByStoreAndGoods:
            return Api.getNearByStoreAndGoods
        case .getSingleGoodsItem:
            return Api.getSingleGoodsItem
        case .saveCollectGoods:
            return Api.saveCollectGoods
        case .saveCollectMerchant:
            return Api.saveCollectMerchant

        case .getOrderShoppingVOByUserId:
            return Api.getOrderShoppingVOByUserId
        case .getGoodsSpecsAttributes:
            return Api.getGoodsSpecsAttributes
        case .updateShoppingTrolleySpecAttributesId:
            return Api.updateShoppingTrolleySpecAttributesId
        case .delTrolleyByIdList:
            return Api.delTrolleyByIdList
        case .calculateMoreCarAmt:
            return Api.calculateMoreCarAmt
        case .getMerchantCoupon(let merchantId):
            return Api.getMerchantCoupon + "\(merchantId)"
       
            
        
        case .getUserInfo:
            return Api.getUserInfo
        case .updateUserInfo:
            return Api.updateUserInfo
        case .updateUserMobile:
            return Api.updateUserMobile
        case .userCloseAccount:
            return Api.userCloseAccount
        case .sendsms:
            return Api.sendsms
        case .userQuestionList:
            return Api.userQuestionList
        case .loginAuthCode:
            return Api.loginAuthCode
        case .userFeedbackTypeList:
            return Api.userFeedbackTypeList
        case .userFeedbackAdd:
            return Api.userFeedbackAdd
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .conformUser2MerchantDistance, .getMerchantCouponList,
             .exchangeMerchantCoupon, .getGoodsInfo, .getMerchantCoupon,
             .getMarketingHomePageVo, .getUserInfo, .userCloseAccount,
             .userFeedbackTypeList:
            return .get
        case .delTrolleyOrNoEfficacy, .delTrolleyByIdList:
            return .delete
        case .userFeedbackAdd:
            return .put
        default:
            return .post
        }
    }

    //    这个是做单元测试模拟的数据，必须要实现，只在单元测试文件中有作用
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }

    //    该条请API求的方式,把参数之类的传进来
    var task: Task {
        switch self {
            
        case .getIndexPageTopPart(let advertiseAreaType, let kingKongAreaType):
            return .requestParameters(parameters: ["advertiseAreaType": advertiseAreaType,"kingKongAreaType": kingKongAreaType], encoding: JSONEncoding.default)
            
        case .conformUser2MerchantDistance(let lat1, let lng1, let merchantId):
            return .requestParameters(parameters: ["lat1": lat1, "lng1": lng1, "merchantId": merchantId], encoding: URLEncoding.default)
            
        case .getMarketingHomePageVo(let goodsType):
            if let goodsType = goodsType {
                return .requestParameters(parameters: ["goodsType": goodsType], encoding: URLEncoding.default)
            } else {
                return .requestPlain
            }
            
        
        case .getJumpKingkongDistrictData(let bizType, let kingkongId, let lat, let lng):
            var params: [String: Any] = [:]
            params["bizType"] = bizType
            params["kingkongId"] = kingkongId
            params["lat"] = lat
            params["lng"] = lng
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
           
            
        
        case .getFrontPageProbeShopRecommend(let lat, let lng, let flag):
            var params: [String: Any] = [:]
            params["lat"] = lat
            params["lng"] = lng
            params["flag"] = flag
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
        
        case .indexPageMerchantSearch(let lat, let lng, let merchantOrGoodsName, let businessType, let page, let pageSize):
            var params: [String: Any] = [:]
            params["latitude"] = lat
            params["longitude"] = lng
            params["page"] = page
            params["pageSize"] = pageSize
            params["businessType"] = businessType
            params["merchantOrGoodsName"] = merchantOrGoodsName
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
            
        case .indexPageGoodsSearch(let lat, let lng, let merchantOrGoodsName, let businessType, let page, let pageSize):
            var params: [String: Any] = [:]
            params["latitude"] = lat
            params["longitude"] = lng
            params["page"] = page
            params["pageSize"] = pageSize
            params["businessType"] = businessType
            params["merchantOrGoodsName"] = merchantOrGoodsName
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
        
        case .getSearchBottomGoods(let lat, let lng, let page, let pageSize):
            var params: [String: Any] = [:]
            params["latitude"] = lat
            params["longitude"] = lng
            params["page"] = page
            params["pageSize"] = pageSize
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
            
        case .homeGetFreeCoupon(let userId, let page, let pageSize):
            var params: [String: Any] = [:]
            params["userId"] = userId
            params["page"] = page
            params["pageSize"] = pageSize
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
        case .homeGetMyCoupon(let couponStatus, let useStatus, let userId, let page, let pageSize):
            var params: [String: Any] = [:]
            params["couponStatus"] = couponStatus
            params["useStatus"] = useStatus
            params["userId"] = userId
            params["page"] = page
            params["pageSize"] = pageSize
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
            
        case .getPrivateChefPage(let page, let pageSize):
            var params: [String: Any] = [:]
            params["page"] = page
            params["pageSize"] = pageSize
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
   
        
        case .secKillActivityList:
            let params: [String: Any] = [:]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)

            //return .requestPlain
            
        case .secKillActivityGoodsList(let businessType, let secKillActivityId, let lat, let lng, let page, let pageSize):
            var params: [String: Any] = [:]
            params["businessType"] = businessType
            params["secKillActivityId"] = secKillActivityId
            params["lat"] = lat
            params["lng"] = lng
            params["page"] = page
            params["pageSize"] = pageSize
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)

            
            
        case .getGroupBuyPageTopPart(let kingKongAreaType):
            var params: [String: Any] = [:]
            params["kingKongAreaType"] = kingKongAreaType
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
            
       
            
            
        case .getComprehensive(let administrativeArea, let categoryName, let deliveryFeeAsc, let distance, let goodsPriceMax, let goodsPriceMin, let goodsSales, let goodsType, let latitude, let longitude, let minpriceAsc, let nearbyDistance, let praise, let page, let pageSize):
            var params: [String: Any] = [:]
            params["administrativeArea"] = administrativeArea
            params["categoryName"] = categoryName
            params["deliveryFeeAsc"] = deliveryFeeAsc
            params["distance"] = distance
            params["goodsPriceMax"] = goodsPriceMax
            params["goodsPriceMin"] = goodsPriceMin
            
            params["goodsSales"] = goodsSales
            params["goodsType"] = goodsType
            params["minpriceAsc"] = minpriceAsc
            params["nearbyDistance"] = nearbyDistance
            params["praise"] = praise


            params["longitude"] = longitude
            params["latitude"] = latitude
            params["pageSize"] = pageSize
            params["page"] = page
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
        
        case .discoverGoodDishes(let administrativeArea, let categoryName, let deliveryFeeAsc, let distance, let goodsPriceMax, let goodsPriceMin, let goodsSales, let goodsType, let latitude, let longitude, let minpriceAsc, let nearbyDistance, let praise, let page, let pageSize):
            var params: [String: Any] = [:]
            params["administrativeArea"] = administrativeArea
            params["categoryName"] = categoryName
            params["deliveryFeeAsc"] = deliveryFeeAsc
            params["distance"] = distance
            params["goodsPriceMax"] = goodsPriceMax
            params["goodsPriceMin"] = goodsPriceMin
            
            params["goodsSales"] = goodsSales
            params["goodsType"] = goodsType
            params["minpriceAsc"] = minpriceAsc
            params["nearbyDistance"] = nearbyDistance
            params["praise"] = praise


            params["longitude"] = longitude
            params["latitude"] = latitude
            params["pageSize"] = pageSize
            params["page"] = page
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
            
            
            
            
        case .getMerchantPage(let userLat, let userLng, let merchantId, let bizType):
            return .requestParameters(parameters: ["userLat": userLat, "userLng": userLng, "merchantId": merchantId,"bizType": bizType], encoding: JSONEncoding.default)
        case .getMerchantCouponList(let merchantId):
            return .requestParameters(parameters: ["merchantId": merchantId], encoding: URLEncoding.default)
        case .receiveCoupon(let couponId):
            return .requestParameters(parameters: ["couponId": couponId], encoding: JSONEncoding.default)
        case .exchangeMerchantCoupon(_):
            return .requestPlain
        case .getGoodsInfo(let merchantId):
            return .requestParameters(parameters: ["merchantId": merchantId], encoding: URLEncoding.default)
        
        case .getOrderMerchantInCarVO(let merchantId):
            return .requestParameters(parameters: ["merchantId": merchantId], encoding: JSONEncoding.default)

        case .updateShoppingTrolleyCount(let account, let attributesIdList, let goodsId, let merchantId , let specId):
            return .requestParameters(parameters: ["account": account,"attributesIdList": attributesIdList,"goodsId": goodsId,
                                                   "merchantId": merchantId,"specId": specId], encoding: JSONEncoding.default)
        
        case .updateOneSpecShoppingTrolleyCount(let account, let goodsId, let merchantId):
            return .requestParameters(parameters: ["account": account,"goodsId": goodsId,
                                                            "merchantId": merchantId], encoding: JSONEncoding.default)
        case .updateShoppingTrolleyCountById(let account, let id, let merchantId):
            return .requestParameters(parameters: ["account": account,
                                                   "id": id,
                                                   "merchantId": merchantId], encoding: JSONEncoding.default)
        
        case .delTrolleyOrNoEfficacy(let merchantId, let status):
            var params: [String: Any] = [:]
            params["merchantId"] = merchantId
            params["status"] = status
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)

        //merchantId, page: 1, pageSize: 10, bizType: 0, commentType: 0
        case .getMerchantCommentPageResult(let merchantId, let page, let pageSize , let bizType, let commentType):
            return .requestParameters(parameters: ["merchantId": merchantId,"bizType": bizType,"commentType": commentType,"page": page,"pageSize": pageSize], encoding: JSONEncoding.default)
            
        case .shopSearchGoods(let merchantId, let goodsName):
            return .requestParameters(parameters: ["merchantId": merchantId,"goodsName": goodsName], encoding: JSONEncoding.default)
            
        case .saveMerchantComplaint(let merchantId, let uploadPicStr, let remark, let complaintContent):
            
            var params: [String: Any] = [:]
            params["merchantId"] = merchantId
            params["uploadPicStr"] = uploadPicStr
            params["remark"] = remark
            params["complaintContentInt"] = complaintContent
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
        
        case .getMerchantDetailPolymerization(let merchantId, let flag):
            var params: [String: Any] = [:]
            params["merchantId"] = merchantId
            params["flag"] = flag
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        
        
        case .getNearByStoreAndGoods(let businessType, let lat1, let lng1, let page, let pageSize):
            var params: [String: Any] = [:]
            params["businessType"] = businessType
            params["lat1"] = lat1
            params["lng1"] = lng1
            params["page"] = page
            params["pageSize"] = pageSize
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
        
        case .saveCollectGoods( let merchantId, let goodsId, let goodsType, let type):
            var params: [String: Any] = [:]
            params["merchantId"] = merchantId
            params["goodsId"] = goodsId
            params["goodsType"] = goodsType
            params["type"] = type
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
        case .saveCollectMerchant(let merchantId, let type):
            var params: [String: Any] = [:]
            params["merchantId"] = merchantId
            params["type"] = type
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        
        
        case .getSingleGoodsItem(let bizType, let goodsId):
            var params: [String: Any] = [:]
            params["bizType"] = bizType
            params["goodsId"] = goodsId
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            

        case .getOrderShoppingVOByUserId(let bizType, let isEfficacy, let lat, let lng, let page, let pageSize):
            var params: [String: Any] = [:]
            params["bizType"] = bizType
            params["isEfficacy"] = isEfficacy
            params["lat"] = lat
            params["lng"] = lng
            params["page"] = page
            params["pageSize"] = pageSize
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
            
        case .getGoodsSpecsAttributes(let merchantId, let goodsId):
            var params: [String: Any] = [:]
            params["merchantId"] = merchantId
            params["goodsId"] = goodsId
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)

            
        case .updateShoppingTrolleySpecAttributesId(let ID, let goodsId, let attributesIdList, let specId):
            var params: [String: Any] = [:]
            params["goodsId"] = goodsId
            params["attributesIdList"] = attributesIdList
            params["specId"] = specId
            params["id"] = ID
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
        case .delTrolleyByIdList(let idList):
            var params: [String: Any] = [:]
            for idValue in idList {
                params["idList"] = idValue
            }
            return .requestParameters(parameters: params, encoding: URLEncoding.default)

        
        case .calculateMoreCarAmt(let idList, let isSettle):
            var params: [String: Any] = [:]
            params["idList"] = idList
            params["isSettle"] = isSettle
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
        case .getMerchantCoupon(_):
            return .requestPlain
        
            
            
        case .getUserInfo:
            return .requestPlain
            
        case .userCloseAccount:
            return .requestPlain
            
        case .updateUserMobile(let params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        
        case .updateUserInfo(let params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)

        case .sendsms(let mobile):
            return .requestParameters(parameters: ["mobile" : mobile], encoding: JSONEncoding.default)

        
        case .userQuestionList(let page, let pageSize):
            var params: [String: Any] = [:]
            params["page"] = page
            params["pageSize"] = pageSize
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        
        case .loginAuthCode(let params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
       
        
        case .userFeedbackTypeList:
            return .requestPlain
            
        case .userFeedbackAdd(let params):
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        
            
        case .batchUpload(let images):
            var formDataArray = [MultipartFormData]()
            
            for (index, image) in images.enumerated() {
                //图片转成Data
                let data = image.jpegData(compressionQuality: 0.6)!
                let date = Date()
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd-HH:mm:ss"
                var dateStr = formatter.string(from: date)
                dateStr = dateStr.appendingFormat("-%i.png", index)
                let formData = MultipartFormData(provider: .data(data), name: "files", fileName: dateStr, mimeType: "image/jpeg") // image/png
                formDataArray.append(formData)
            }
            
            return .uploadMultipart(formDataArray)

            
        }
    
    }

    var headers: [String : String]? {
        //var token = ""
        var params: [String: String] = [:]
        
        if XSAuthManager.shared.isLoginEd { // 已经登录
            let tokenStr = XKeyChain.get(XSYWTOKEN)
            params["Authorization"] = "Bearer \(tokenStr)"
        } else { // 未登录
            //params["Authorization"] = "Bearer access_token"
        }
        
        params["ip"] =  JKGlobalTools.getIPAddress()// "120.78.9.137"

        
//        params["x-userid-header"] = "1"
//        //params["x-userid-header"] = "11"
//        params["x-account-type-header"] = "user"
        uLog("请求头header参数：\(params)")
        return params
    }
 
}
