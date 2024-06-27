//
//  XSAuthManager.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/14.
//

import UIKit

final class XSAuthManager {
    /// 单例
    static let shared = XSAuthManager()
    /// 私有化初始化方法
    private init() {}
    
    private (set) var token: String = XKeyChain.get(XSYWTOKEN)
    
    private (set) var userId: String = XKeyChain.get(kUserId)
    
    /// 对外只读用户信息属性
    private(set) var accountInfo: XSMineHomeUserInfoModel?
    
    /*
     经纬度暂时写死
     atitude: 22.54242
     longitude: 114.11311
     */
    public var longitude: Double = 114.11311
    public var latitude: Double = 22.54242

    public var currCityStr: String = "地市天地广场"
    
    
    var isLoginEd: Bool {
        if XKeyChain.get(XSYWTOKEN).isEmpty || XKeyChain.get(XSYWTOKEN) == ""{
            return false
        }
        
        return true
    }
    
    
}
