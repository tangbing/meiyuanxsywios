//
//  XSMineHomeModel.swift
//  MeiYuanXSYW
//
//  Created by Tb on 2022/3/7.
//

import Foundation
import HandyJSON

/*
 "age":0,
 "birthday":"2000-12-01",
 "email":"",
 "headImg":"https://xsyw-test.oss-cn-shenzhen.aliyuncs.com/2021/static/images/mine/default-avatar@2x.png",
 "lastLoginTime":"2022-01-11 17:59:49",
 "memberBeginDate":"2022-02-11 15:17:24",
 "memberEndDate":"2022-03-11 23:59:59",
 "memberLevel":0,
 "memberStatus":1,
 "mobile":"17680648070",
 "nickname":"最爱吃兽奶的熊孩子",
 "registerDate":"2021-12-03 11:01:40",
 "registerReceiveStatus":1,
 "registerSource":0,
 "sex":0,
 "token":null,
 "userId":1,
 "userName":"admin",
 "userNo":"FS2112032",
 "userStatus":0
 */

let userLoginInfo = "userLoginInfo"

class XSMineHomeUserInfoModel: HandyJSON,Decodable,Encodable {
    var age: Int = 0
    var birthday: String = ""
    var email: String = ""
    var headImg: String = ""
    var lastLoginTime: String = ""
    var memberBeginDate: String = ""
    var memberEndDate: String = ""
    var memberLevel: Int = 0
    var memberStatus: Int = 0
    var mobile: String = ""
    var nickname: String = ""
    var registerDate: String = ""
    var registerReceiveStatus: Int = 0
    var registerSource: Int = 0
    var sex: Int = 0
    var token : XSMineHomeUserInfoTokenModel?
    var userId: Int = 0
    var userName: String = ""
    var userNo: String = ""
    var userStatus: Int = 0
    required init() {
        
    }
    
    static func saveAccountData(userInfoModel : XSMineHomeUserInfoModel, saveComplete: (() -> Void)?){
        XKeyChain.set(userInfoModel.token?.access_token ?? "", key:XSYWTOKEN)
        XKeyChain.set("\(userInfoModel.userId)", key: kUserId)
        XKeyChain.set(String(userInfoModel.memberStatus), key:XSYWMemberStatus)

        uLog("save........")

        guard let complete = saveComplete else {
            return
        }
        complete()
    }
    
    
    static func removeAccountInfo() {
        XKeyChain.removeKeyChain()
        UserDefaults.jk.removeAllKeyValue()
    }
    

}

struct XSMineHomeUserInfoTokenModel: HandyJSON,Decodable,Encodable {
    var access_token: String = ""
    var token_type: String = ""
    var refresh_token: String = ""

}


