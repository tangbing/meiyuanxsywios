//
//  XSBaseTableViewCell.swift
//  U17
//
//  Created by charles on 2017/10/24.
//  Copyright © 2017年 None. All rights reserved.
//

import UIKit
import Reusable
import QMUIKit

class XSBaseTableViewCell: UITableViewCell, Reusable {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        
        configUI()
        
    }
    
//    required init?(coder: NSCoder) {
//        super.init(coder: coder)
//        selectionStyle = .none
//        configUI()
//    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    open func configUI() {
        selectionStyle = .none
        backgroundColor = .clear
        contentView.backgroundColor = UIColor.white
    }
    
    func addLine(frame:CGRect,color:UIColor) {
        var view = contentView.viewWithTag(1314)
        if view == nil {
            view = UIView()
            view?.tag = 1314
            contentView.addSubview(view!)
        }
        view?.frame = frame
        view?.backgroundColor = color
    }

}
