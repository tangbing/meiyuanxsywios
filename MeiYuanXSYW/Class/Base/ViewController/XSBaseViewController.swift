//
//  XSBaseViewController.swift
//  U17
//
//  Created by charles on 2017/9/29.
//  Copyright © 2017年 None. All rights reserved.
//

import UIKit
import SnapKit
import Reusable
import Kingfisher
import QMUIKit
import JKSwiftExtension
import SVProgressHUD


class XSBaseViewController: QMUICommonViewController {
    //有tabbar 的页面，直接设置titile 会改掉tabbar 的title,所以，设置导航title 用这个方法
    var navigationTitle:String = ""{
        didSet{
            title = navigationTitle
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isTranslucent=false 
        view.backgroundColor = UIColor.background
        /** 关闭ScrollView自动偏移 */
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
        /* 关闭延伸,这个会影响view的x和heigt */
        edgesForExtendedLayout = UIRectEdge.left

     
        requestData()
        initData()
    }
    override func setupNavigationItems() {
        super.setupNavigationItems()
    }
    
    func requestData() {
        
    }
    func initData() {
        
    }
    
    override var prefersStatusBarHidden: Bool {
        return self.gk_statusBarHidden
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return self.gk_statusBarStyle
    }
    

    //qmui开启手势滑动返回
    override func forceEnableInteractivePopGestureRecognizer() -> Bool {
        return true
    }
    //导航栏显示隐藏
    override func shouldCustomizeNavigationBarTransitionIfHideable() -> Bool {
        return true
    }
    
    override func preferredNavigationBarHidden() -> Bool {
        return false
    }
    
    
    enum UNavigationBarStyle {
        case theme
        case white
        case black
    }
    func barStyle(_ style: UNavigationBarStyle) {
        switch style {
        case .theme:
            //如果设置为图片的时候，转场的时候有问题，可能哪里没有设置对，先暂时用颜色，如果需要图片的建议隐藏navigationbar 自定义
            navigationController?.navigationBar.barTintColor = UIColor.orange
            //背景颜色或图片
//            navigationController?.navigationBar .setBackgroundImage(UIColor.blue.image(), for: .default)
        case .white:
            navigationController?.navigationBar.barTintColor = UIColor.white
        case .black:
            navigationController?.navigationBar.barTintColor = UIColor.black
        }
//        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    deinit {
        //uLog(NSStringFromClass(self.classForCoder) + " deinit")
    }

}

