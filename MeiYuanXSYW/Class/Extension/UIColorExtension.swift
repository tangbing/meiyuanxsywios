//
//  UIColorExtension.swift
//  U17
//
//  Created by charles on 2017/7/31.
//  Copyright © 2017年 charles. All rights reserved.
//

import UIKit
//MRAK: 应用默认颜色
func hexColor(string:String) -> UIColor {
    return UIColor.qmui_color(withHexString:string)!
}

extension UIColor {
    
    class var btnColors: AnyObject {
        return [UIColor.qmui_color(withHexString: "#EFCB9C")?.cgColor,UIColor.qmui_color(withHexString: "#E8C089")?.cgColor] as AnyObject
    }
    class var cartColors: AnyObject {
        return [UIColor.qmui_color(withHexString: "#FF724E")?.cgColor,UIColor.qmui_color(withHexString: "#F6094C")?.cgColor] as AnyObject
    }
    class var warn: UIColor {
        return UIColor.qmui_color(withHexString: "#FF7400")!
    }
    class var error: UIColor {
        return UIColor.qmui_color(withHexString: "#ED3C2F")!
    }
    class var pass: UIColor {
        return UIColor.qmui_color(withHexString: "#0CBB57")!
    }
    class var link: UIColor {
        return UIColor.qmui_color(withHexString: "#518DFF")!
    }
//    class var disable: UIColor {
//        return UIColor.qmui_color(withHexString: "#E5E5E5")!
//    }
    class var vipHader: UIColor {
        return UIColor.qmui_color(withHexString: "#FFE1BA")!
    }

    class var text: UIColor {
        return UIColor.qmui_color(withHexString: "#252525")!
    }
    class var twoText: UIColor {
        return UIColor.qmui_color(withHexString: "#737373")!
    }
    class var threeText: UIColor {
        return UIColor.qmui_color(withHexString: "#939393")!
    }
    class var fourText: UIColor {
        return UIColor.qmui_color(withHexString: "#B3B3B3")!
    }
    class var priceText: UIColor {
        return UIColor.qmui_color(withHexString: "#F11F16")!
    }

    class var king: UIColor {
        return UIColor.qmui_color(withHexString: "#DDA877")!
    }
    class var kingText: UIColor {
        return UIColor.qmui_color(withHexString: "#9A6A3F")!
    }

    class var tag: UIColor {
        return UIColor.qmui_color(withHexString: "#E6B68A")!
    }

    class var background: UIColor {
        return UIColor.qmui_color(withHexString: "#F2F2F2")!
    }
    
    class var lightBackground: UIColor {
        return UIColor.qmui_color(withHexString: "#F9F9F9")!
    }
    
    class var borad: UIColor {
        return UIColor.qmui_color(withHexString: "#E5E5E5")!
    }

}

extension UIColor {
    
    convenience init(r:UInt32 ,g:UInt32 , b:UInt32 , a:CGFloat = 1.0) {
        self.init(red: CGFloat(r) / 255.0,
                  green: CGFloat(g) / 255.0,
                  blue: CGFloat(b) / 255.0,
                  alpha: a)
    }
    
    class var random: UIColor {
        return UIColor(r: arc4random_uniform(256),
                       g: arc4random_uniform(256),
                       b: arc4random_uniform(256))
    }
    
    func image() -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(self.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    class func hex(hexString: String) -> UIColor {
        var cString: String = hexString.trimmingCharacters(in: .whitespacesAndNewlines)
        if cString.count < 6 { return UIColor.black }
        
        let index = cString.index(cString.endIndex, offsetBy: -6)
        let subString = cString[index...]
        if cString.hasPrefix("0X") { cString = String(subString) }
        if cString.hasPrefix("#") { cString = String(subString) }
        
        if cString.count != 6 { return UIColor.black }
        
        var range: NSRange = NSMakeRange(0, 2)
        let rString = (cString as NSString).substring(with: range)
        range.location = 2
        let gString = (cString as NSString).substring(with: range)
        range.location = 4
        let bString = (cString as NSString).substring(with: range)
        
        var r: UInt32 = 0x0
        var g: UInt32 = 0x0
        var b: UInt32 = 0x0
        
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        return UIColor(r: r, g: g, b: b)
    }
}


