//
//  CLCountDownManager.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2022/1/4.
//

import UIKit

/** 通知名 */
extension NSNotification.Name {
    public static let CLCountDownNotification = Notification.Name("CLCountDownNotification")
}

class CLCountDownManager: NSObject {
    
    /** 使用单例 */
    public static let sharedManager: CLCountDownManager = CLCountDownManager()
    
    override init() {
        super.init()
        
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(applicationWillEnterForeground), name: UIApplication.willEnterForegroundNotification, object: nil)
    }
    
    /** 开始倒计时 */
    public func start() -> Void {
        // 启动定时器
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
            RunLoop.current.add(timer!, forMode: .common)
        }
    }
    
    /** 停止倒计时 */
    public func invalidate() -> Void {
        timer?.invalidate()
        timer = nil
    }
    
    /** 时间差(单位:秒) */
    var timeInterval: Int = 0
    
    /** 刷新倒计时(兼容旧版本, 如使用identifier标识的时间差, 请调用reloadAllSource方法) */
    public func reload() -> Void {
        timeInterval = 0
    }
    
    /** 添加倒计时源 */
    public func addSourceWithIdentifier(identifier: String) -> Void {
        let timeInterval = timeIntervalDict[identifier]
        if timeInterval != nil {
            timeInterval?.timeInterval = 0
        }else {
            timeIntervalDict[identifier] = CLTimeInterval(timerInterval: 0)
        }
    }
    
    /** 获取时间差 */
    public func timeIntervalWithIdentifier(identifier: String) -> Int {
        return timeIntervalDict[identifier]?.timeInterval ?? 0
    }
    
    /** 刷新倒计时源 */
    public func reloadSourceWithIdentifier(identifier: String) -> Void {
        timeIntervalDict[identifier]?.timeInterval = 0
    }
    
    /** 刷新所有倒计时源 */
    public func reloadAllSource() -> Void {
        for (_, timeInterval) in timeIntervalDict {
            timeInterval.timeInterval = 0
        }
    }
    
    /** 清除倒计时源 */
    public func removeSourceWithIdentifier(identyfier: String) -> Void {
        timeIntervalDict.removeValue(forKey: identyfier)
    }
    
    /** 清除所有倒计时源 */
    public func removeAllSource() -> Void {
        timeIntervalDict.removeAll()
    }
    
    /// 定时器
    private var timer: Timer?
    
    /// 时间差字典(单位:秒)(使用字典来存放, 支持多列表或多页面使用)
     lazy var timeIntervalDict: [String : CLTimeInterval] = {
        let lazyDict = [String : CLTimeInterval]()
        return lazyDict
    }()
    
    /// 后台模式使用, 记录进入后台的绝对时间
    private var backgroudRecord: Bool = false
    private var lastTime: CFAbsoluteTime = 0
    
    /// 定时器回调
    @objc private func timerAction() -> Void {
        // 定时器计数每次加1
        timerActionWithTimeInterval(interval: 1)
    }
    private func timerActionWithTimeInterval(interval: Int) -> Void {
        // 时间差+
        timeInterval += interval
        for (_, timeInterval) in timeIntervalDict {
            timeInterval.timeInterval += interval
        }
        // 发出通知
        NotificationCenter.default.post(name: .CLCountDownNotification, object: nil)
    }
    
    /// 程序进入后台回调
    @objc private func applicationDidEnterBackground() -> Void {
        backgroudRecord = (timer != nil)
        if backgroudRecord {
            lastTime = CFAbsoluteTimeGetCurrent()
            invalidate()
        }
    }
    
    /// 程序进入前台回调
    @objc private func applicationWillEnterForeground() -> Void {
        if backgroudRecord {
            let timeInterval = CFAbsoluteTimeGetCurrent() - lastTime
            // 取整
            timerActionWithTimeInterval(interval: Int(timeInterval))
            start()
        }
    }
}


class CLTimeInterval: NSObject {
    /** 时间差 */
    var timeInterval: Int = 0
    
    init(timerInterval: Int) {
        timeInterval = timerInterval
    }
}
