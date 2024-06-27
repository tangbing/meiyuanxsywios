//
//  ThirdLibsManager.swift
//  SwiftDemo
//
//  Created by sam   on 2020/4/7.
//  Copyright © 2020 sam  . All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import QMUIKit
import SVProgressHUD
import GKNavigationBarSwift

/// 统一管理第三方库
final class ThirdLibsManager: NSObject {

    static let shared = ThirdLibsManager()
    
    func setup() {
        
        UITextField.appearance().tintColor = .tag
        IQKeyboardManager.shared.enable = true
        
//        QMUIConfiguration().automaticCustomNavigationBarTransitionStyle = true
//        QMUIConfiguration().navBarTitleFont = UIFont.myFont32

        SVProgressHUD.setDefaultStyle(SVProgressHUDStyle.dark)
        
        if #available(iOS 15.0, *) {
            UITableView.appearance().sectionHeaderTopPadding = 0
        }

        GKConfigure.setupCustom { (configure) in
            configure.titleColor = .black
            configure.titleFont = UIFont.systemFont(ofSize: 18.0)
            configure.gk_navItemLeftSpace = 4.0
            configure.gk_navItemRightSpace = 4.0
            configure.backStyle = .white
            if #available(iOS 13.0, *) {
                configure.statusBarStyle = .darkContent
            } else {
                configure.statusBarStyle = .lightContent
           }
        }
        GKConfigure.awake()


    }
}
