//
//  XSBaseNavigationController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/8/13.
//

import UIKit
import QMUIKit

class XSBaseNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavBarAppearence()
    }

    func setupNavBarAppearence() {
        //self.navigationBar.prefersLargeTitles = false
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        UINavigationBar.appearance().tintColor = .black
        
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance.init()
            appearance.configureWithOpaqueBackground()
            //appearance.backgroundColor = UIColor.
            // 导航栏文字
            appearance.titleTextAttributes = [
                 NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
                 NSAttributedString.Key.foregroundColor: UIColor.black
            ]
//            appearance.shadowImage = UIImage()
//            appearance.shadowColor = UIColor.white
            self.navigationBar.standardAppearance = appearance
            self.navigationBar.scrollEdgeAppearance = appearance
        } else {
            self.navigationBar.barTintColor = UIColor.qmui_color(withHexString: "#FDFDFD");
            self.navigationBar.tintColor = .black
        }
        
    }

    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if viewControllers.count > 0 { viewController.hidesBottomBarWhenPushed = true
//            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.qmui_item(with: UIImage(named: "nav_back_black")!, target: self, action: #selector(pressBack))
//
            // 自定义返回按钮
            let backButton = UIButton(type: .custom)
            backButton.setImage(#imageLiteral(resourceName: "nav_back_black"), for: .normal)
            backButton.tb_size = CGSize(width: 44, height: 44)
            //backButton.contentHorizontalAlignment = .left
            backButton.addTarget(self, action: #selector(pressBack), for: .touchUpInside)
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
            viewController.hidesBottomBarWhenPushed = true

        }
        super.pushViewController(viewController, animated: animated)
    }
    
    @objc func pressBack() {
        popViewController(animated: true)
    }

}
