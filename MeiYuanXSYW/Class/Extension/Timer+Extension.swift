//
//  Timer+Extension.swift
//  MeiYuanXSYW
//
//  Created by Tb on 2022/3/8.
//

import Foundation

extension Timer {
    
    /// Timer将userInfo作为callback的定时方法
    /// 目的是为了防止Timer导致的内存泄露
    /// - Parameters:
    ///   - timeInterval: 时间间隔
    ///   - repeats: 是否重复
    ///   - callback: 回调方法
    /// - Returns: Timer
    public static func xs_scheduledTimer(timeInterval: TimeInterval, repeats: Bool, with callback: @escaping ((Timer) -> Void)) -> Timer {
        return scheduledTimer(timeInterval: timeInterval,
                              target: self,
                              selector: #selector(callbackInvoke(_:)),
                              userInfo: callback,
                              repeats: repeats)
    }
    
    /// 私有的定时器实现方法
    ///
    /// - Parameter timer: 定时器
    @objc
    private static func callbackInvoke(_ timer: Timer) {
//        guard let callback = timer.userInfo as? ((Timer) -> Void) else { return }
//        callback()
        
        guard let callback = timer.userInfo as? ((Timer) -> Void) else {
            timer.invalidate()
            return
        }
        callback(timer)
    }
}
