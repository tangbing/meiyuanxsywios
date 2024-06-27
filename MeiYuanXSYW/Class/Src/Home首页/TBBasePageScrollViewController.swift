//
//  TBBasePageScrollViewController.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/8.
//

import UIKit
import GKPageSmoothView
import GKPageScrollView

class TBBasePageScrollViewController: XSBaseViewController {
    var scrollCallBack: ((UIScrollView) -> ())?
    func setContentInset(bottomInset: CGFloat) {}
    
    var showHomeStyle: HomeShowStyle = .deliver
    var merchantId: String = ""
    
    init(style homeShowStyle: HomeShowStyle, merchantId: String = "") {
        self.showHomeStyle = homeShowStyle
        self.merchantId = merchantId
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension TBBasePageScrollViewController: UIScrollViewDelegate, GKPageListViewDelegate {
    func listScrollView() -> UIScrollView {
       return UIScrollView()
    }
    
    func listView() -> UIView {
        return self.view
    }
    
    func listViewDidScroll(callBack: @escaping (UIScrollView) -> ()) {
        self.scrollCallBack = callBack
    }
    // 
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.scrollCallBack!(scrollView)
    }

}

