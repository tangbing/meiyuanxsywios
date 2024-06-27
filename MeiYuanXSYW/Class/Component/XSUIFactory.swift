//
//  XSUITool.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/24.
//

import UIKit
import QMUIKit


func lineView(bgColor lineColor: UIColor) -> UIView {
    let iv = UIView()
    iv.backgroundColor = lineColor
    return iv
}

func selectAll(title: String = "全选" , target: AnyObject, action: Selector) -> QMUIButton {
    let all = QMUIButton(type: .custom)
    all.setImage(UIImage(named: "mine_tick_normal"), for: .normal)
    all.setImage(UIImage(named: "mine_tick_selected"), for: .selected)
    all.setTitle(title, for: .normal)
    all.spacingBetweenImageAndTitle = 5
    all.setTitleColor(.text, for: .normal)
    all.titleLabel?.font = MYBlodFont(size: 18)
    all.addTarget(target, action: action, for: .touchUpInside)
    return all
}

