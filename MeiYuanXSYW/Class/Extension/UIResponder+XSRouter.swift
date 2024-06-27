//
//  UIResponder+XSRouter.swift
//  MeiYuanXSYW
//
//  Created by Tb on 2022/1/9.
//

import Foundation
import UIKit


extension UIResponder {
    func routerEventName(eventName: String, routerInfo info: [String : Any]) {
        self.next?.routerEventName(eventName: eventName, routerInfo: info)
    }
}
