//
//  APi.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/14.
//

import Foundation

enum Api {
    
    // baseUrl: 'http://120.78.9.137:7052',
     // baseUrl: 'http://172.16.50.41:7052' // 李鑫
      // baseUrl: 'http://172.16.50.67:7052'// wangjunsheng
    
    /// 开发环境
    static let Moya_baseURLDev = "http://120.78.9.137:7052/"
    static let Moya_lixin_baseURLDev = "http://172.16.50.41:7052/"
    static let Moya_wangjunsheng_baseURLDev = "http://172.16.80.189:7052/"
    static let Moya_chanchan_baseURLDev = "http://172.16.80.152:7052/"
    


    static let Moya_baseURLDebug = "http://120.78.9.137:7052/"
    /// 生产环境
    static let Moya_baseURLRelease = "http://120.78.9.137:9900/api-mobile/"
    
    static var Moya_baseStr = Moya_baseURLRelease
    
    /// baseURl
    static var Moya_baseURL: URL  {
#if DEBUG
        return URL.init(string:(Moya_baseStr))!
#else
        return URL.init(string:(Moya_baseURLRelease))!
#endif
    }
    
}

// MARK: - merchant商家详情接口
extension Api {

    /// 用户C端首页获取轮播图和公告数据  广告位置类型（0：首页 1：团购）
    static let getIndexPageTopPart = "mobile-system/getIndexPageTopPart"
    
    /// 获取首页秒杀和领券列表  0:外卖;1:团购
    static let getMarketingHomePageVo = "marketing-api/getMarketingHomePageVo"

    /// 首页探店获取推荐商品商家数据 flag: 0:外卖 1:团购 2:全部
    static let getFrontPageProbeShopRecommend = "mobile-merchant/getFrontPageProbeShopRecommend"
    
    
    /// 搜索发现， 聚合首页banner上面推荐关键词搜索接口
    static let getSearchDiscover = "mobile-goods/getSearchDiscover"
    
    /// <##>用户C端首页商品搜索
    static let indexPageGoodsSearch = "mobile-goods/indexPageGoodsSearch"
    
    /// C端首页商家搜索
    static let indexPageMerchantSearch = "mobile-goods/indexPageMerchantSearch"
    
    /// 用户C端搜索后底部商品推荐获取
    static let getSearchBottomGoods = "mobile-goods/getSearchBottomGoods"
    
    /// C端获取我的优惠券列表
    static let homeGetMyCoupon = "marketing-api/coupon/v1/get-my-coupon"
    
    /// C端获取免费领券列表
    static let homeGetFreeCoupon = "marketing-api/coupon/v1/get-free-coupon"
    
    
    /// 用户附近的店铺
    static let getNearByGoodStore = "mobile-merchant/getNearByGoodStore"
    
    /// 用户C端首页综合
    static let getComprehensive = "mobile-goods/getComprehensive"
    
    /// 用户C端首页发现好菜
    static let discoverGoodDishes = "mobile-goods/discoverGoodDishes"
    
    /// 用户C端私厨首页
    static let getPrivateChefPage = "mobile-merchant/getPrivateChefPage"

    
    /// C端获取秒杀活动列表
    static let secKillActivityList = "marketing-api/sec-kill-activity-list"
    
    
    /// 获取金刚区和轮播图数据
    static let getGroupBuyPageTopPart = "mobile-system/getGroupBuyPageTopPart"
    
    /// 点击金刚区跳转获取数据
    static let getJumpKingkongDistrictData = "mobile-goods/getJumpKingkongDistrictData"
    
   
    /// C端获取秒杀商品列表
    static let secKillActivityGoodsList = "marketing-api/secKill-activity-goods-list"

    
    /// C端显示爆品推荐
    static let showExplosiveRecommend = "mobile-system/showExplosiveRecommend"
    
  
    
    
    /// 判断距离是否符合商家配送范围
    static let conformUser2MerchantDistance = "mobile-merchant/conformUser2MerchantDistance"
    /// C端通过商家Id查询商家详情(头信息)
    static let getMerchantPage = "mobile-merchant/getMerchantPage"
    /// <##>获取商家详情页领券列表
    static let getMerchantCouponList = "marketing-api/getMerchantCouponList"
    /// C端领取优惠券
    static let receiveCoupon = "marketing-api/v1/receive-coupon"
    /// C端兑换商家红包 (返回2 表示不是会员)
    static let exchangeMerchantCoupon = "marketing-api/exchangeMerchantCoupon/"
    /// 商家首页商品信息
    static let getGoodsInfo = "mobile-goods/getGoodsInfo"
    /// 更改购物车的数量
    static let updateShoppingTrolleyCount = "mobile/updateShoppingTrolleyCount"
    /// 通过购物车ID更改购物车的数量
    static let updateShoppingTrolleyCountById = "mobile/updateShoppingTrolleyCountById"
    
    /// 商家进入返回的购物车数据
    static let getOrderMerchantInCarVO = "mobile/getOrderMerchantInCarVO"
    
    /// 删除购物车全部商品或者清理无效商品
    static let delTrolleyOrNoEfficacy = "mobile/delTrolleyOrNoEfficacy"

    /// 商家评价分页列表(分页)
    static let getMerchantCommentPageResult =  "mobile/getMerchantCommentPageResult"
    /// 商家店内搜索商品
    static let shopSearchGoods = "mobile-goods/shopSearchGoods"
    
    /// 保存商家投诉
    static let saveMerchantComplaint = "mobile-merchant/saveMerchantComplaint"
    
   

    /// C端商家详情获取聚合数据- 团购-聚合商家商家详情获取的数据
    static let getMerchantDetailPolymerization = "mobile-goods/getMerchantDetailPolymerization"
    
 
    /// 附件好店的商家和商品信息, 团购，聚合商家详情页面的更多商家数据
    static let getNearByStoreAndGoods = "mobile-merchant/getNearByStoreAndGoods"
    
    
    ///  商品详情 用户C端获取单个商品详情
    static let getSingleGoodsItem = "mobile-goods/getSingleGoodsItem"
    
    
    ///  商品详情 操作收藏商品
    static let saveCollectGoods = "user-api/save-collect-goods"
    
    ///  商家详情 操作收藏商家
    static let saveCollectMerchant = "user-api/save-collect-merchant"

    ///  购物车 获取购物车商品信息
    static let getOrderShoppingVOByUserId = "mobile/getOrderShoppingVOByUserId"
    
    
    ///  购物车 C端获取商品规格属性
    static let getGoodsSpecsAttributes = "mobile-goods/getGoodsSpecsAttributes"
    

    ///  购物车 修改购物车的规格和属性
    static let updateShoppingTrolleySpecAttributesId = "mobile/updateShoppingTrolleySpecAttributesId"
    
    ///  购物车 通过购物车ID批量删除购物车数据
    static let delTrolleyByIdList = "mobile/delTrolleyByIdList"
    
    
    ///  购物车 计算购物车的金额
    ///  是否结清。购物车时勾选false，结算的时候点击true.结算的时候前端需要传经纬度
    static let calculateMoreCarAmt = "mobile/calculateMoreCarAmt"
    
   
    /// 获取商家的优惠券
    static let getMerchantCoupon = "marketing-api/v1/get-merchant-coupon/"
    
    
    
    /////////////////////////===================用户信息==========================================
    
    /// 获取用户信息
    static let getUserInfo = "user-api/user/user-info"

    /// 修改用户信息
    static let updateUserInfo = "user-api/user/update-user"

   /// 修改手机号
    static let updateUserMobile = "user-api/user/update-mobile"

    /// 注销账号
    static let userCloseAccount = "user-api/user/close-account"

    /// 发送短信
    static let sendsms = "message-api/send-sms"
    
    /// 获取问题列表-分页
    static let userQuestionList = "user-api/question/page"
    
    
    /// 获取问题详情
    static let userQuestionDetail = "user-api/question/"
    
    
    
    /// C端登录注册
    static let loginAuthCode = "user-api/login/auth-code"
    
    
    /// 获取所有的反馈类型
    static let userFeedbackTypeList = "user-api/feedback-type/list"
    
    /// 增加用户反馈
    static let userFeedbackAdd = "user-api/feedback/add"
    
    
    

    // common
    /// 批量上传图片
    static let batchUpload = "file/batchUpload"
    
    
}




