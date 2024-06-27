//
//  Provider.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/14.
//

import Foundation
import HandyJSON
import Moya
import JKSwiftExtension
import SwiftyJSON
import Alamofire

///网络错误的回调
typealias errorCallback = ((_ errorMsg: String) -> (Void))

/// loading开始与取消插件
let LoadingPlugin = NetworkActivityPlugin { (type, target) in
    guard let vc = topVC else { return }
    switch type {
    case .began:
        XSTipsHUD.hideAllTips(inView: vc.view)
        XSTipsHUD.showLoading("加载中...", inView: vc.view)
    case .ended:
        XSTipsHUD.hideAllTips(inView: vc.view)
    }
}

/// 网络请求的设置
let timeoutClosure = {(endpoint: Endpoint, closure: MoyaProvider<MerchantService>.RequestResultClosure) -> Void in
    
    if var urlRequest = try? endpoint.urlRequest() {
        // 打印请求参数
        if let requestData = urlRequest.httpBody {
            print("\(urlRequest.url!)" + "\n" + "\(urlRequest.httpMethod ?? "")" + "发送参数" + "\(String(data: urlRequest.httpBody!, encoding: String.Encoding.utf8) ?? "")")
           // parmeterStr = String(data: urlRequest.httpBody!, encoding: String.Encoding.utf8)!
           
        // [URL absoluteString];
           
        } else {
            print("\(urlRequest.url!)" + "\(String(describing: urlRequest.httpMethod))")
        }

        urlRequest.timeoutInterval = 20
        closure(.success(urlRequest))
    } else {
        closure(.failure(MoyaError.requestMapping(endpoint.url)))
    }
}

let MerchantInfoProvider = MoyaProvider<MerchantService>(requestClosure: timeoutClosure)
let MerchantInfoLoadingProvider = MoyaProvider<MerchantService>(requestClosure: timeoutClosure, plugins: [LoadingPlugin])




extension Response {
    func mapModel<T: HandyJSON>(_ type: T.Type) throws -> T? {
        let jsonString = String(data: data, encoding: .utf8)
        uLog("responseData: \(jsonString ?? "")")
        guard let model = JSONDeserializer<T>.deserializeFrom(json: jsonString) else {
            throw MoyaError.jsonMapping(self)
        }
        return model
    }
}

extension MoyaProvider {
  
    
    @discardableResult
    func request<T: HandyJSON>(_ target: Target,
                               designatedPath: String? = nil,
                                    model: T.Type,
                                    completion: ((_ returnData: T?) -> Void)?,
                               pathCompletion: ((_ returnData: [T]) -> Void)? = nil,
                                    errorResult: errorCallback?) -> Cancellable? {
        
        if !XSTool.isNetworkConnect{
            XSTipsHUD.showError("网络似乎有问题！")
            return nil
        }
       
        return request(target, completion: { (result) in
            guard let completion = completion else { return }
            
            switch result {
            case let .success(response):
                let data = response.data
                guard let jsonData = try? JSON(data: data) else {
                    return
                }
                let code = jsonData["resp_code"].intValue
                if code == 0 {// 成功
                    
                    guard let path = designatedPath else {
                        guard let returnData =  try? response.mapModel(XSResponseData<T>.self) else {
                            completion(nil)
                            return
                        }
                        completion(returnData.data)
                        return
                    }
                    
                    let jsonString = String(data: data, encoding: .utf8)
                    uLog("requestData: \(jsonString ?? "")")
                    
                    if let returnData = JSONDeserializer<T>.deserializeModelArrayFrom(json: jsonString, designatedPath: path)?.compactMap({ $0}) {
                        pathCompletion?(returnData)
                    }

                } else {
                    XSTipsHUD.hideAllTips()
                    XSTipsHUD.showText(jsonData["resp_msg"].stringValue)
                    uLog("request !=0:code:\(code), path:\(target.path) error:\(jsonData["resp_msg"].stringValue)")
                    
                    if code == 10010 {
                        NotificationCenter.default.post(name: NSNotification.Name.XSNeedToLoginNotification, object: nil)
                    } else {
                        errorResult?(jsonData["resp_msg"].stringValue)
                    }
                    
                    
                }
                break
             case let .failure(error):
                //网络连接失败，提示用户
                print("网络连接失败\(error)")
                errorResult?(error.localizedDescription)
            }
        })
    }
}
