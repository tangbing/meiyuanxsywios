//
//  XSTipsHUD.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/12/10.
//

import UIKit
import QMUIKit

class XSTipsHUD: NSObject {

    class func createTips(toView view: UIView) -> QMUITips {
        return QMUITips.createTips(to: view)
    }
    // MARK: - showLoading
//    class func showLoading(inView view: UIView) {
//        QMUITips.showLoading(in: view)
//    }
//
//    class func showLoading(text: String, inView view: UIView) {
//        QMUITips.showLoading(text, in: view)
//    }
//
//    class func showLoading(inView view: UIView, hideAfterDelay dely: TimeInterval) {
//        QMUITips.showLoading(in: view, hideAfterDelay: dely)
//    }
//
//    class func showLoading(text: String, inView view: UIView, hideAfterDelay dely: TimeInterval) {
//        QMUITips.showLoading(text, in: view, hideAfterDelay: dely)
//    }
    
    class func showLoading(_ text: String,detailText: String? = nil, inView view: UIView, hideAfterDelay dely: TimeInterval = 0) {
        QMUITips.showLoading(text, detailText: detailText, in: view, hideAfterDelay: dely)
    }
    
    // MARK: - showText
    class func showText(_ text: String) {
        QMUITips.show(withText: text)
    }
    
    class func showText(_ text: String, detailText: String) {
        QMUITips.showInfo(text, detailText: detailText)
    }
    
    class func showText(_ text: String, inView view: UIView) {
        QMUITips.show(withText: text, in: view)
    }
    
    class func showText(_ text: String, inView view: UIView, hideAfterDelay dely: TimeInterval) {
        QMUITips.show(withText: text, in: view, hideAfterDelay: dely)
    }
    
    class func showText(_ text: String, detailText: String, inView view: UIView) {
        QMUITips.show(withText: text, detailText: detailText, in: view)
    }
    
    class func showText(_ text: String, detailText: String, inView view: UIView,hideAfterDelay dely: TimeInterval ) {
        QMUITips.show(withText: text, detailText: detailText, in: view ,hideAfterDelay: dely)
    }
    
    // MARK: - success
    class func showSucceed(_ text: String) {
        QMUITips.showSucceed(text)
    }
    
    class func showSucceed(_ text: String, detailText: String) {
        QMUITips.showSucceed(text, detailText: detailText)
    }
    class func showSucceed(_ text: String, inView view: UIView) {
        //QMUITips.showSucceed(text, in: view, hideAfterDelay: 2)
        showSucceed(text, inView: view, hideAfterDelay: 2)
    }
    
    class func showSucceed(_ text: String, inView view: UIView,hideAfterDelay dely: TimeInterval) {
        QMUITips.showSucceed(text, in: view, hideAfterDelay: 2)
    }
    
    class func showSucceed(_ text: String, detailText: String, inView view: UIView) {
        QMUITips.showSucceed(text, detailText: detailText)
    }
    
    class func showSucceed(_ text: String, detailText: String, inView view: UIView, hideAfterDelay dely: TimeInterval) {
        QMUITips.showSucceed(text, detailText: detailText, in: view, hideAfterDelay: dely)
    }
    
    
    // MARK: - error
    class func showError(_ text: String) {
        QMUITips.showError(text)
    }
    
    class func showError(_ text: String, detailText: String) {
        QMUITips.showError(text, detailText: detailText)
    }
    class func showError(_ text: String, inView view: UIView) {
        //QMUITips.showSucceed(text, in: view, hideAfterDelay: 2)
        showError(text, inView: view, hideAfterDelay: 2)
    }
    
    class func showError(_ text: String, inView view: UIView,hideAfterDelay dely: TimeInterval) {
        QMUITips.showError(text, in: view, hideAfterDelay: 2)
    }
    
    class func showError(_ text: String, detailText: String, inView view: UIView) {
        QMUITips.showError(text, detailText: detailText)
    }
    
    class func showError(_ text: String, detailText: String, inView view: UIView, hideAfterDelay dely: TimeInterval) {
        QMUITips.showError(text, detailText: detailText, in: view, hideAfterDelay: dely)
    }
    
    // MARK: - info
    class func showInfo(_ text: String) {
        QMUITips.showInfo(text)
    }
    
    class func showInfo(_ text: String, detailText: String) {
        QMUITips.showInfo(text, detailText: detailText)
    }
    class func showInfo(_ text: String, inView view: UIView) {
        //QMUITips.showSucceed(text, in: view, hideAfterDelay: 2)
        showInfo(text, inView: view, hideAfterDelay: 2)
    }
    
    class func showInfo(_ text: String, inView view: UIView,hideAfterDelay dely: TimeInterval) {
        QMUITips.showInfo(text, in: view, hideAfterDelay: 2)
    }
    
    class func showInfo(_ text: String, detailText: String, inView view: UIView) {
        QMUITips.showInfo(text, detailText: detailText)
    }
    
    class func showInfo(_ text: String, detailText: String, inView view: UIView, hideAfterDelay dely: TimeInterval) {
        QMUITips.showInfo(text, detailText: detailText, in: view, hideAfterDelay: dely)
    }
    
    // MARK: - 展示菊花图，期间禁止用户操作
    class func createHUDandMaskView() -> QMUITips? {
        let window = UIApplication.shared.keyWindow
        guard let window = window else {
            return nil
        }
        window.isUserInteractionEnabled = false
        let hud = QMUITips.init(view: window)
        window.addSubview(hud)
        
        hud.didShowBlock = { showInView, animated in
            window.isUserInteractionEnabled = true
        }
        return hud
        
    }
    
    class func showLoadingInMaskView(_ text: String){
        self .createHUDandMaskView()?.showLoading(text)
    }
    
    class func showLoadingInMaskView(_ text: String,hideAfterDelay dely: TimeInterval){
        self.createHUDandMaskView()?.showLoadingHide(afterDelay: dely)
    }
    
    // MARK: - 隐藏 tips
    class func hideAllTips(inView view: UIView) {
        QMUITips.hideAllTips(in: view)
    }
    
    class func hideAllTips(){
        QMUITips.hideAllTips()
    }
    
    
    
    
    
    
    
    
    
}
