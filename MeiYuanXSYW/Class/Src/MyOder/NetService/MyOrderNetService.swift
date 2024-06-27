//
//  NetworkTool.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/20.
//

import Foundation
import Moya
import SwiftyJSON
import Alamofire
import JKSwiftExtension

struct JsonArrayEncoding: Moya.ParameterEncoding {

    public static var `default`: JsonArrayEncoding { return JsonArrayEncoding() }

    public func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var req = try urlRequest.asURLRequest()
        let json = try JSONSerialization.data(withJSONObject: parameters!["jsonArray"]!, options: JSONSerialization.WritingOptions.prettyPrinted)
        req.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        req.httpBody = json
        return req
    }
}


public protocol CLSwiftyJSONAble {
    init?(jsonData:JSON)
}

let myOrderProvider = MoyaProvider<MyOrderService>(requestClosure: timeoutClosure)
let myOrderLoadingProvider = MoyaProvider<MerchantService>(requestClosure: timeoutClosure, plugins: [LoadingPlugin])

extension Api {
    static let getOrderMerchantByStatus = "mobile/getOrderMerchantByStatusPageResult"
    static let getOrderMerchantDetailByMerchantOrderSn = "mobile/getOrderMerchantDetailByMerchantOrderSn"
    static let getCommentData = "mobile/getCommentData"
    static let saveComment = "mobile/saveComment"
    static let getArriveTime = "mobile/getArriveTime"
    static let getOrderUserReceiverListByMerchantIdList = "user-api/getOrderUserReceiverListByMerchantIdList"
    static let getOrderRemark = "mobile/getOrderRemark"
    static let delOrderRemark = "mobile/delOrderRemark"
    static let saveOrder = "mobile/saveOrder"
    static let payOrder = "mobile/payOrder"
    static let getOrderAgain = "mobile/getOrderAgain"
    static let pushOrder = "mobile/pushOrder"
    static let getOrderReturnVOByServiceSn = "mobile/getOrderReturnVOByServiceSn"
    static let saveOrderReturn = "mobile/saveOrderReturn"
    static let calculateMoreCarAmt2 = "mobile/calculateMoreCarAmt"
    
    static let getMemberUser = "user-api/get-member-user"
    static let getAddPackageList = "user-api/getAddPackageList"
    static let getAddPackageVo = "/user-api/getAddPackageVo/"

    static let getMemberCardInfo = "user-api/member-card-api/member-card-info"
    static let getMemberBuyRecordList = "user-api/member-buy-record-list"
    static let getNearByMerchantUpAmt = "mobile-merchant/getNearByMerchantUpAmt"
    static let getMyMemberCard = "user-api/get-my-member-card"
    static let seckillactivitylist = "marketing-api/sec-kill-activity-list"
    static let getmycoupon = "marketing-api/coupon/v1/get-my-coupon"
    static let getCollectGoodsList = "user-api/collect-goods-list"
    static let getCollectMerchantList = "user-api/collect-merchant-list"
    static let getReceiverAddress = "user-api/getReceiverAddress"
    static let getUserReceiverById = "user-api/mobile/getUserReceiverById"
    static let saveOrUpdateReceiverAddress = "user-api/mobile/saveOrUpdateReceiverAddress"
    static let deleteUserReceiverById = "user-api/mobile/deleteUserReceiverById"
    static let userBrowseRecord = "user-api/user-browse-record/browse-record-list"
    static let countusercenter = "user-api/count-user-center"
    static let getMyCommentPageResult = "mobile/getMyCommentPageResult"

    
}

enum MyOrderService {
    ///通过订单状态获取订单
    case getOrderMerchantByStatus(_ dic:[String:Any])
    ///通过订单详情
    case getOrderMerchantDetailByMerchantOrderSn(_ dic:[String:Any])
    ///评价订单
    case saveComment(_ dic: [String:Any])
    ///获取订单评价数据
    case getCommentData(_ dic: [String:Any])
    /// 获取送达时间
    case getArriveTime(_ dic:[[String:Any]])
    /// 订单结算时通过商家经纬度查询收货地址
    case getOrderUserReceiverListByMerchantIdList(_ dic: [String:Any])
    ///获取备注
    case getOrderRemark
    ///删除备注
    case delOrderRemark(_ dic: [String:Any])
    ///保存订单
    case saveOrder(_ dic: [String:Any])
    ///支付订单
    case payOrder(_ dic: [String:Any])
    ///再来一单
    case getOrderAgain(_ dic: [String:Any])
    ///催单
    case pushOrder(_ dic: [String:Any])
    ///获取订单退款详细信息
    case getOrderReturnVOByServiceSn(_ dic: [String:Any])
    ///保存退款订单
    case saveOrderReturn(_ dic: [String:Any])
    ///获取订单结算信息
    case calculateMoreCarAmt2(_ dic: [String:Any])
    
    ///获取用户个人信息
    case getMemberUser(_ dic: [String:Any])
    ///获取用户加量包
    case getAddPackageList(_ dic: [String:Any])
    case getAddPackageVo(_ addPackageId:String)
    ///获取会员卡信息列表 包含用户、抵扣券、权益信息
    case getMemberCardInfo(_ dic: [String:Any])
    ///获取会员购买记录
    case getMemberBuyRecordList(_ dic: [String:Any])
    ///获取我的会员卡
    case getMyMemberCard(_ dic: [String:Any])
    case seckillactivitylist(_ dic: [String:Any])
    ///获取会员商家
    case getNearByMerchantUpAmt(_ dic: [String:Any])
    ///获取会员商家
    case getmycoupon(_ dic: [String:Any])
    
    
    // 个人中心
    
    ///获取收藏商品列表
    case getCollectGoodsList(_ dic: [String:Any])
    ///获取获取收藏商家列表
    case getCollectMerchantList(_ dic: [String:Any])

    ///获取用户收货地址
    case getReceiverAddress(_ dic: [String:Any])
    ///通过ID获取地址详情
    case getUserReceiverById(_ dic: [String:Any])
    ///新增或者修改用户收货地址
    case saveOrUpdateReceiverAddress(_ dic: [String:Any])
    ///通过ID删除地址
    case deleteUserReceiverById(_ dic: [String:Any])
    ///获取我的足迹
    case userBrowseRecord(_ dic: [String:Any])
    ///获取我的个人中心数据
    case countusercenter(_ dic: [String:Any])
    ///获取我的个人中心数据
    case getMyCommentPageResult(_ dic: [String:Any])
    
    /// 搜索发现， 聚合首页banner上面推荐关键词搜索接口
    case getSearchDiscover(userId: Int?)
    /// 用户C端搜索后底部商品推荐获取
    case getSearchBottomGoods(lat: Double, lng: Double,page: Int, pageSize: Int)
    
    /// C端显示爆品推荐
    /// 业务类型0外卖1团购3聚合–目前暂不分业务线默认值0
    case showExplosiveRecommend(businessType: Int, userLat: Double, userLng: Double)
    
    /// 获取问题详情
    case userQuestionDetail(_ Id: Int)
    

}
//extension Api {
//    static let baseURL = "http://120.78.9.137:7052/"
//}

extension MyOrderService : TargetType {
    
    var baseURL: URL {
        //return URL.init(string:(Api.baseURL))!
        return Api.Moya_baseURL
    }
    
    var path: String {
        switch self {
            
        case .getOrderMerchantByStatus(_):
            return Api.getOrderMerchantByStatus
        case .getOrderMerchantDetailByMerchantOrderSn(_):
            return Api.getOrderMerchantDetailByMerchantOrderSn
        case .getCommentData(_):
            return Api.getCommentData
        case .saveComment(_):
            return Api.saveComment
        case .getArriveTime(_):
            return Api.getArriveTime
        case .getOrderUserReceiverListByMerchantIdList(_):
            return Api.getOrderUserReceiverListByMerchantIdList
        case .getOrderRemark:
            return Api.getOrderRemark
        case .delOrderRemark(_):
            return Api.delOrderRemark
        case .saveOrder(_):
            return Api.saveOrder
        case .payOrder(_):
            return Api.payOrder
        case .getOrderAgain(_):
            return Api.getOrderAgain
        case .pushOrder(_):
            return Api.pushOrder
        case .getOrderReturnVOByServiceSn(_):
            return Api.getOrderReturnVOByServiceSn
        case .saveOrderReturn(_):
            return Api.saveOrderReturn
        case .calculateMoreCarAmt2(_):
            return Api.calculateMoreCarAmt2
            
        case .getMemberUser(_):
            return Api.getMemberUser
        case .getAddPackageList(_):
            return Api.getAddPackageList
        case .getAddPackageVo(let addPackageId):
            return Api.getAddPackageVo + addPackageId
        case .getMemberCardInfo(_):
            return Api.getMemberCardInfo
        case .getMemberBuyRecordList(_):
            return Api.getMemberBuyRecordList
        case .getMyMemberCard(_):
            return Api.getMyMemberCard
        case .getNearByMerchantUpAmt(_):
            return Api.getNearByMerchantUpAmt
            
        case .seckillactivitylist(_):
            return Api.seckillactivitylist
        case .getmycoupon(_):
            return Api.getmycoupon
        case .getSearchDiscover:
            return Api.getSearchDiscover
        case .getSearchBottomGoods:
            return Api.getSearchBottomGoods
        case .showExplosiveRecommend:
            return Api.showExplosiveRecommend
            
        case .userQuestionDetail(let Id):
            return Api.userQuestionDetail + "\(Id)"
            
        case .getCollectGoodsList(_):
            return Api.getCollectGoodsList
        case .getCollectMerchantList(_):
            return Api.getCollectMerchantList
        case .getReceiverAddress(_):
            return Api.getReceiverAddress
        case .getUserReceiverById(_):
            return Api.getUserReceiverById
        case .saveOrUpdateReceiverAddress(_):
            return Api.saveOrUpdateReceiverAddress
        case .deleteUserReceiverById(_):
            return Api.deleteUserReceiverById
        case .userBrowseRecord(_):
            return Api.userBrowseRecord
        case .countusercenter(_):
            return Api.countusercenter
        case .getMyCommentPageResult(_):
            return Api.getMyCommentPageResult
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getCommentData(_):
            return .get
        case .saveComment(_):
            return .post
        case .getArriveTime(_):
            return .post
        case .getOrderMerchantByStatus(_):
            return .post
        case .getOrderMerchantDetailByMerchantOrderSn(_):
            return .get
        case .getOrderUserReceiverListByMerchantIdList(_):
            return .post
        case .getOrderRemark:
            return .get
        case .delOrderRemark(_):
            return .delete
        case .saveOrder(_):
            return .post
        case .payOrder(_):
            return .get
        case .getOrderAgain(_):
            return .get
        case .pushOrder(_):
            return .get
        case .getOrderReturnVOByServiceSn(_):
            return .get
        case .saveOrderReturn(_):
            return .post
        case .calculateMoreCarAmt2(_):
            return .post
            
        case .getMemberUser(_):
            return .get
        case .getAddPackageList(_):
            return .get
        case .getAddPackageVo(_):
            return .get
        case .getMemberCardInfo(_):
            return .get
        case .getMemberBuyRecordList(_):
            return .post
        case .getNearByMerchantUpAmt(_):
            return .post
        case .getMyMemberCard(_):
            return .get
        case .seckillactivitylist(_):
            return .post
        case .getmycoupon(_):
            return .post
        case .getSearchDiscover:
            return .post
        case .getSearchBottomGoods:
            return .post
        case .showExplosiveRecommend:
            return .post
        case .userQuestionDetail:
            return .get
                
        case .getCollectGoodsList(_):
            return .post
        case .getCollectMerchantList(_):
            return .post
        case .getReceiverAddress(_):
            return .get
        case .getUserReceiverById(_):
            return .get
        case .saveOrUpdateReceiverAddress(_):
            return .post
        case .deleteUserReceiverById(_):
            return .delete
        case .userBrowseRecord(_):
            return .post
 
        case .countusercenter(_):
            return .get
        case .getMyCommentPageResult(_):
            return .post
        }
    }

    //    这个是做单元测试模拟的数据，必须要实现，只在单元测试文件中有作用
    var sampleData: Data {
        return "".data(using: String.Encoding.utf8)!
    }

    //    该条请API求的方式,把参数之类的传进来
    var task: Task {
//        return .requestParameters(parameters: nil, encoding: JSONArrayEncoding.default)
        switch self {
        case .getOrderMerchantByStatus(let dic):
            return .requestParameters(parameters:dic, encoding: JSONEncoding.default)
        case .getOrderMerchantDetailByMerchantOrderSn(let dic):
            return .requestParameters(parameters:dic, encoding: URLEncoding.default)
        case .getCommentData(let dic):
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        case .saveComment(let dic):
            return .requestParameters(parameters: dic, encoding: JSONEncoding.default)
        case .getArriveTime(let dic):
            return .requestParameters(parameters:["jsonArray":dic], encoding: JsonArrayEncoding.default)
        case .getOrderUserReceiverListByMerchantIdList(let dic):
            return .requestParameters(parameters:dic, encoding: JSONEncoding.default)
        case .getOrderRemark:
            return .requestPlain
        case .delOrderRemark(let dic):
            return .requestParameters(parameters:dic, encoding: JSONEncoding.default)
        case .saveOrder(let dic):
            return .requestParameters(parameters:dic, encoding: JSONEncoding.default)
        case .payOrder(let dic):
            return .requestParameters(parameters:dic, encoding: URLEncoding.default)
        case .getOrderAgain(let dic):
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        case .pushOrder(let dic):
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        case .getOrderReturnVOByServiceSn(let dic):
            return .requestParameters(parameters: dic, encoding: URLEncoding.default)
        case .saveOrderReturn(let dic):
            return .requestParameters(parameters:dic, encoding: JSONEncoding.default)
        case .calculateMoreCarAmt2(let dic):
            return .requestParameters(parameters:dic, encoding: JSONEncoding.default)
            
        case .getMemberUser(let dic):
            return .requestParameters(parameters:dic, encoding: URLEncoding.default)
        case .getAddPackageList(let dic):
            return .requestParameters(parameters:dic, encoding: URLEncoding.default)
        case .getAddPackageVo(_ ):
            return .requestPlain
        case .getMemberCardInfo(let dic):
            return .requestParameters(parameters:dic, encoding: URLEncoding.default)
        case .getMemberBuyRecordList(let dic):
            return .requestParameters(parameters:dic, encoding: JSONEncoding.default)
        case .getMyMemberCard(let dic):
            return .requestParameters(parameters:dic, encoding: URLEncoding.default)
        case .getNearByMerchantUpAmt(let dic):
            return .requestParameters(parameters:dic, encoding: JSONEncoding.default)
        case .seckillactivitylist(let dic):
            return .requestParameters(parameters:dic, encoding: URLEncoding.default)

        case .getmycoupon(let dic):
            return .requestParameters(parameters:dic, encoding: JSONEncoding.default)
        case .getSearchDiscover(let userId):
            var params: [String: Any] = [:]
            params["userId"] = userId
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
        
        case .getSearchBottomGoods(let lat, let lng, let page, let pageSize):
            var params: [String: Any] = [:]
            params["latitude"] = lat
            params["longitude"] = lng
            params["page"] = page
            params["pageSize"] = pageSize
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
        case .showExplosiveRecommend(let businessType, let userLat, let userLng):
            var params: [String: Any] = [:]
            params["businessType"] = businessType
            params["userLat"] = userLat
            params["userLng"] = userLng
            return .requestParameters(parameters: params, encoding: JSONEncoding.default)
            
        case .userQuestionDetail(_):
            return .requestPlain
            
        case .getCollectGoodsList(let dic):
            return .requestParameters(parameters:dic, encoding: JSONEncoding.default)
        case .getCollectMerchantList(let dic):
            return .requestParameters(parameters:dic, encoding: JSONEncoding.default)
        case .getReceiverAddress(let dic):
            return .requestParameters(parameters:dic, encoding: URLEncoding.default)
        case .getUserReceiverById(let dic):
            return .requestParameters(parameters:dic, encoding: URLEncoding.default)
        case .saveOrUpdateReceiverAddress(let dic):
            return .requestParameters(parameters:dic, encoding: JSONEncoding.default)
        case .deleteUserReceiverById(let dic):
            return .requestParameters(parameters:dic, encoding: URLEncoding.default)
        case .userBrowseRecord(let dic):
            return .requestParameters(parameters:dic, encoding: JSONEncoding.default)
        case .countusercenter(let dic):
            return .requestPlain
        case .getMyCommentPageResult(let dic):
            return .requestParameters(parameters:dic, encoding: JSONEncoding.default)
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
        uLog("params======================>\(params)")
        
        params["ip"] =  JKGlobalTools.getIPAddress()// "120.78.9.137"
        
//        params["x-userid-header"] = "1"
//        //params["x-userid-header"] = "11"
//        params["x-account-type-header"] = "user"
        
        return params
    }
 
}
