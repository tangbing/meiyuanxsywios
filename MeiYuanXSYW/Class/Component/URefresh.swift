//
//  URefresh.swift
//  SPMTestExample
//
//  Created by admin on 2021/12/8.
//

import UIKit
import MJRefresh


extension UIScrollView {
    var uHead: MJRefreshHeader {
        get {return mj_header! }
        set { mj_header = newValue}
    }
    
    var uFoot: MJRefreshFooter {
        get { return mj_footer! }
        set { mj_footer = newValue }
    }
}

class URefreshAutoHeader: MJRefreshNormalHeader {
    override func prepare() {
        super.prepare()
        lastUpdatedTimeLabel?.isHidden = true
        //stateLabel.isHidden = true
        
    }
}

class URefreshAutoFooter: MJRefreshBackNormalFooter {
    override func prepare() {
        super.prepare()
        setTitle("-我是有底线的宝宝-", for: .noMoreData)
        
        
    }
    
}
