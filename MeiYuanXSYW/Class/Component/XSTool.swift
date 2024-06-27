//
//  XSTool.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/17.
//

import UIKit
import Alamofire

class XSTool: NSObject {
    
    /// 基于Alamofire,网络是否连接，这个方法不建议放到这个类中,可以放在全局的工具类中判断网络链接情况
    /// 用get方法是因为这样才会在获取isNetworkConnect时实时判断网络链接请求，如有更好的方法可以fork
    static var isNetworkConnect: Bool {
        get{
            let network = NetworkReachabilityManager()
            return network?.isReachable ?? true //无返回就默认网络已连接
        }
    }
    

    static func getDateComponentsWithDate(theDate: Date) -> DateComponents {
        var cal = Calendar.current
        cal.firstWeekday = 2
        return cal.dateComponents([Calendar.Component.year, Calendar.Component.month,
                           Calendar.Component.day , Calendar.Component.hour,
                           Calendar.Component.minute , Calendar.Component.second,
                           Calendar.Component.weekday , Calendar.Component.weekOfYear
                           //Calendar.Component.minute , Calendar.Component.second,
        ]
                           , from: theDate)
    }
    
    static func getPriousorLaterDateFromDate(date: Date, month: Int) -> Date {
        var comps = DateComponents()
        comps.month = month
        // 设置为公历
        let calendar = Calendar(identifier: Calendar.Identifier.gregorian)
        let mDate = calendar.date(byAdding: comps, to: date)
        return mDate ?? Date()
        
    }

}
