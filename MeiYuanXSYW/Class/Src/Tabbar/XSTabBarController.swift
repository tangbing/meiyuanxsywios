//
//  XSTabBarController.swift
//  U17
//
//  Created by charles on 2017/9/29.
//  Copyright © 2017年 None. All rights reserved.
//

import UIKit
import QMUIKit
class XSTabBarController: QMUITabBarViewController {
    
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.XSNeedToLoginNotification, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isTranslucent = false
        tabBar.tintColor = UIColor.tag
        tabBar.backgroundImage = UIColor.white.image()
        
        self.delegate = self
        
        registerObserver()
        
        /// 首页
        let homeVC = XSHomeController()
        addChildViewController(homeVC,
                               title: nil,
                               image: UIImage(named: "tabbar_home_default"),
                               selectedImage: UIImage(named: "tabbar_home"))
        
        
//        /// 发现
//        //let discover = XSGoodsInfoGroupBuyTicketViewController()
//        let discover = XSDiscoverController()
//        addChildViewController(discover,
//                               title: "发现",
//                               image: UIImage(named: "tabbar_find_default"),
//                               selectedImage: UIImage(named: "tabbar_find"))
        
        
        /// 会员
        let vipVC = XSVipHomeController()
        addChildViewController(vipVC,
                               title: "会员",
                               image: UIImage(named: "tabbar_vip_default"),
                               selectedImage: UIImage(named: "tabbar_vip"))
        
        /// 订单
        let orderVC = XSShopCartController()
        addChildViewController(orderVC,
                               title: "购物车",
                               image: UIImage(named: "tabbar_cart_default"),
                               selectedImage: UIImage(named: "tabbar_cart"))

        /// 我的
        let mineVC = XSMineHomeController()
        addChildViewController(mineVC,
                               title: "我的",
                               image: UIImage(named: "tabbar_mine_default"),
                               selectedImage: UIImage(named: "tabbar_mine"))
    }
    
    private func registerObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(switchToLoginViewController), name: NSNotification.Name.XSNeedToLoginNotification, object: nil)
    }
    
    
    func addChildViewController(_ childController: UIViewController, title:String?, image:UIImage? ,selectedImage:UIImage?) {
        
        childController.tabBarItem = UITabBarItem(title: title,
                                                  image: image?.withRenderingMode(.alwaysOriginal),
                                                  selectedImage: selectedImage?.withRenderingMode(.alwaysOriginal))
        if childController is XSHomeController{
            childController.tabBarItem.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: -8, right: 0)
        }

        let nav = XSBaseNavigationController(rootViewController: childController)

        addChild(nav)
    }
    
    @objc private func switchToLoginViewController() {
        XSMineHomeUserInfoModel.removeAccountInfo()
        
        let nav = self.selectedViewController as? XSBaseNavigationController
        nav?.pushViewController(XSLoginController(), animated: true)

    }
    
}

// MARK: - UITabBarControllerDelegate
extension XSTabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        uLog(tabBarController.selectedIndex)
        guard let tarbarTitle = viewController.tabBarItem.title else { return true }
        

        if tarbarTitle == "购物车" && !XSAuthManager.shared.isLoginEd { // 没有登录，则登录
            let nav = tabBarController.selectedViewController as? XSBaseNavigationController
            nav?.pushViewController(XSLoginController(), animated: true)
            return false
        }
        return true
    }
}

