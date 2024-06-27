//
//  Global.swift
//  U17
//
//  Created by charles on 2017/10/24.
//  Copyright © 2017年 None. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SnapKit
import QMUIKit
import Kingfisher




extension UIImage{
    class var placeholder: UIImage {
        return UIImage(named: "placheholder_690x518px")!
    }
    class var placeholderUesr: UIImage {
        return UIImage(named: "mine_user")!
    }
    class var bannerPlaceholder: UIImage? {
        return UIImage(named: "placheholder_banner")
    }
}

extension String {
    static let buglyAppid = "a6172b9c29"
    
    static let placeholder = "xxx"
    static let loading = "请求中"
    static let success = "处理成功"

    static let searchHistoryKey = "searchHistoryKey"
    static let sexTypeKey = "sexTypeKey"
    
    static let searchDiscoverHistoryKey = "searchDiscoverHistoryKey"
    
}

func MYFont(size:CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: size)
}
func MYBlodFont(size:CGFloat) -> UIFont {
    return UIFont.boldSystemFont(ofSize: size)
    
}
extension UIFont{
    static let myFont48 = MYFont(size: 24)
    static let myFont40 = MYFont(size: 20)
    static let myFont36 = MYFont(size: 18)
    static let myFont32 = MYFont(size: 16)
    static let myFont28 = MYFont(size: 14)
    static let myFont24 = MYFont(size: 12)
    static let myFont22 = MYFont(size: 11)

}

extension NSNotification.Name {
    /// 登录完成通知
    static let XSLoginEndNotification = NSNotification.Name("XSLoginEndNotification")
    /// 用户退出登录通知
    static let XSLogoutNotification = NSNotification.Name("XSLogoutNotification")
    /// 需要跳转到登录页面通知
    static let XSNeedToLoginNotification = NSNotification.Name("XSNeedToLoginNotification")

    /// 定位成功后，更新位置的通知
    static let XSUpdateLocationNotification = NSNotification.Name("XSUpdateLocationNotification")

    
    static let XSUpdateMenuTitleNotification = NSNotification.Name("XSUpdateMenuTitleNotification")
    
    /// 更新店铺详情头信息的通知
    static let XSUpdateMerchHeadrInfoNotification = NSNotification.Name("XSUpdateMerchHeadrInfoNotification")
    /// 商品加入购物车后的通知
    static let XSJoinGoodsInCartNotification = NSNotification.Name("XSJoinGoodsInCartNotification")

    /// 商品购物车点击减号所有商品的通知
    static let XSCartMerchInfoPopCellReduceBtnClickNotification = NSNotification.Name("XSCartMerchInfoPopCellReduceBtnClickNotification")
    
    /// 商品购物车点击加号所有商品的通知
    static let XSCartMerchInfoPopCellplusBtnClickNotification = NSNotification.Name("XSCartMerchInfoPopCellplusBtnClickNotification")
    
    /// 团购，聚合商家详情，第一次加入购物车点击加号按钮的通知
    static let XSRightBuyButtonFirstClickNotification = NSNotification.Name("XSRightBuyButtonFirstClickNotification")
    
    /// 团购，聚合商家详情，第一次弹出选择规格的通知
    static let XSSelectStandardMenuFirstClickNotification = NSNotification.Name("XSSelectStandardMenuFirstClickNotification")
    
    /// 团购，聚合商家详情，点击减号按钮的通知
    static let XSCartReduceClickNotification = NSNotification.Name("XSCartReduceClickNotification")
    
    /// 团购，聚合商家详情，点击加号按钮的通知
    static let XSCartPlusBtnClickNotification = NSNotification.Name("XSCartPlusBtnClickNotification")
    
    /// 购物车，更新规格，属性的通知，刷新
    static let XSCartUpdateSpecAttributeNotification = NSNotification.Name("XSCartUpdateSpecAttributeNotification")
    
    
}


let iPhone6ScreenWidth  = CGFloat(375)
let iPhone6ScreenHeight = CGFloat(667)
let screenWidth = UIScreen.main.bounds.width
let screenHeight = UIScreen.main.bounds.height
let bottomInset : CGFloat = isIphoneX ? 34 : 0
let kStatusTopInset: CGFloat = UIApplication.shared.statusBarFrame.size.height
let kNavHeight: CGFloat = kStatusTopInset + 44

let homeW: CGFloat = (screenWidth - 30) * 0.5
let pullDownMenuH: CGFloat = 55
let bottomCartViewH: CGFloat = 64


let repeatContent_width = screenWidth - 20 - 10 - 5
let repeat_width = screenWidth - 20 - 10 - 10
let krepeatMargin: CGFloat = 10
let krepeat_infoH: CGFloat = 36


let WidthScale  = screenWidth / iPhone6ScreenWidth
let HeightScale = screenHeight / iPhone6ScreenHeight
let FMScreenScaleFrom = {CGFloat(WidthScale * $0)}


let gaodeMapAPI = "91d9e927cf1abb30c4efca192406d0fa"
/// 保存用户名的key
let kLatitude = "kLatitude"
let kLongitude = "kLongitude"
let kCurrCityStr = "kCurrCityStr"
let kUserId = "kUserId"

// MARK: - test data
//let test_merchantId: String = "14677131"
//let test_goodsId: String = "1461596690602377265" // group
//let test_goodsId: String = "1461596690602377268" // ticket

//let test_goodsId: String = "1461596690602377242" // private
//let test_goodsId: String = "1461596690602377259" // delieve

let lon = XSAuthManager.shared.longitude
let lat = XSAuthManager.shared.latitude
let userId = XSAuthManager.shared.userId
let pageSize: Int = 10


var topVC: UIViewController? {
    var resultVC: UIViewController?
    resultVC = _topVC(UIApplication.shared.keyWindow?.rootViewController)
    while resultVC?.presentedViewController != nil {
        resultVC = _topVC(resultVC?.presentedViewController)
    }
    return resultVC
}

var isIphoneX: Bool {
    guard #available(iOS 11.0, *)else {
        return false;
    }
    //是ios11以上，然后判断圆角
    var isX = false
    if #available(iOS 13.0, *) {
        isX = UIApplication.shared.keyWindow?.safeAreaInsets.bottom ?? 0 > 0.0
    }
    else{
        isX = UIApplication.shared.windows[0].safeAreaInsets.bottom > 0
    }
    return isX
}

private  func _topVC(_ vc: UIViewController?) -> UIViewController? {
    if vc is UINavigationController {
        return _topVC((vc as? UINavigationController)?.topViewController)
    } else if vc is UITabBarController {
        return _topVC((vc as? UITabBarController)?.selectedViewController)
    } else {
        return vc
    }
}

//MARK: print
func uLog<T>(_ message: T, file: String = #file, function: String = #function, lineNumber: Int = #line) {
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("[\(fileName):funciton:\(function):line:\(lineNumber)]- \(message)")
    #endif
}
//setImage(with: URL(string:(self.slidesList?[index].image)!), placeholder:)
//MARK: Kingfisher

extension UIImageView {
    public func xs_setImage(urlString: String?, placeholder: Placeholder? = UIImage(named: "placheholder_750x460px"))
    {
        if let url = URL(string: urlString ?? "") {
            self.kf.setImage(with: .network(url), placeholder: placeholder)
        }
       
    }
}


//extension Kingfisher where base: UIImageView {
//    public func setImage(urlString: String?, placeholder: Placeholder? = UIImage(named: "normal_placeholder")) {
//        base
//    }
//}

//extension Kingfisher {
//    @discardableResult
//    public func setImage(urlString: String?, placeholder: Placeholder? = UIImage(named: "normal_placeholder")) {
//        return setImage(with: URL(string: urlString ?? ""),
//                        placeholder: placeholder,
//                        options:[.transition(.fade(0.5))])
//    }
//}

//extension Kingfisher where Base: UIButton {
//    @discardableResult
//    public func setImage(urlString: String?, for state: UIControl.State, placeholder: UIImage? = UIImage(named: "normal_placeholder")) -> RetrieveImageTask {
//        return setImage(with: URL(string: urlString ?? ""),
//                        for: state,
//                        placeholder: placeholder,
//                        options: [.transition(.fade(0.5))])
//
//    }
//}


//MARK: SnapKit
extension ConstraintView {
    
    var usnp: ConstraintBasicAttributesDSL {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide.snp
        } else {
            return self.snp
        }
    }
}

extension UICollectionView {
    
    func reloadData(animation: Bool = true) {
        if animation {
            reloadData()
        } else {
            UIView .performWithoutAnimation {
                reloadData()
            }
        }
    }
}

let  LL_StatusBarExtraHeight : CGFloat = isIphoneX  ? 24.0 : 0.0

