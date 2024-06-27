//
//  UIBarButtonItem+Extensioin.swift
//  MeiYuanXSYW
//
//  Created by admin on 2021/11/22.
//

import UIKit

extension UIBarButtonItem {
    
    public class func tb_item(title: String? = nil, image: UIImage?, highLightImage: UIImage? = nil,selectEdImage: UIImage? = nil,  target: Any, action: Selector) -> UIBarButtonItem {
        let button = UIButton()
        button.setTitle(title, for: .normal)
        button.setImage(image, for: .normal)
        button.setImage(highLightImage, for: .highlighted)
        button.setImage(selectEdImage, for: .selected)
        button.sizeToFit()
        button.addTarget(target, action: action, for: .touchUpInside)
        if button.bounds.size.width < 44.0 {
            button.bounds = CGRect(x: 0, y: 0, width: 44.0, height: 44.0)
        }
        return UIBarButtonItem(customView: button)
    }

}


