//
//  XSBorderSelectButton.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/9/22.
//

import UIKit

class XSBorderSelectButton: UIButton {

    override var isSelected: Bool {
        didSet {
            switch isSelected {
            case true:
                layer.borderColor = UIColor.tag.cgColor
                layer.borderWidth = 1.0
                layer.masksToBounds = true
                layer.cornerRadius = 2
            default:
                layer.cornerRadius = 2
                layer.borderColor = UIColor.borad.cgColor
                layer.borderWidth = 1.0
                layer.masksToBounds = true
            }
        }
    }

}
