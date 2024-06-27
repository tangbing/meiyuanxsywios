//
//  UIView+FrameExtension.swift
//  tbzxs_student_ios
//
//  Created by Tb on 2021/6/5.
//

import UIKit


extension UIView {
    
    var tb_x: CGFloat {
        set {
            var frame = self.frame
            frame.origin.x = newValue
            self.frame = frame
        }
        get {
            return self.frame.origin.x
        }
    }
    
    var tb_y: CGFloat {
        set {
            var frame = self.frame
            frame.origin.y = newValue
            self.frame = frame
        }
        get {
            return self.frame.origin.y
        }
    }
    
    var tb_width: CGFloat {
        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
        get {
            return self.frame.size.width
        }
    }
    
    var tb_height: CGFloat {
        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
        get {
            return self.frame.size.height
        }
    }
    
    var tb_right: CGFloat {
        set {
            var frame = self.frame
            frame.origin.x = newValue - frame.size.width
            self.frame = frame
        }
        get {
            return self.frame.origin.x + self.frame.size.width
        }
    }
    
    var tb_bottom: CGFloat {
        set {
            var frame = self.frame
            frame.origin.y = newValue - frame.size.height
            self.frame = frame
        }
        get {
            return self.frame.origin.y + self.frame.size.height
        }
    }

    var tb_centerX: CGFloat {
        set {
            self.center = CGPoint(x: newValue, y: self.center.y)
        }
        get {
            return self.center.x
        }
    }
    
    var tb_centerY: CGFloat {
        set {
            self.center = CGPoint(x: self.center.x, y: newValue)
        }
        get {
            return self.center.y
        }
    }
    
    var tb_maxY: CGFloat {
        get {
            return self.frame.maxY
        }
    }
    
    var tb_minY: CGFloat {
        get {
            return self.frame.minY
        }
    }
    
    var tb_maxX: CGFloat {
        get {
            return self.frame.maxX
        }
    }
    
    var tb_minX: CGFloat {
        get {
            return self.frame.minX
        }
    }
    
    var tb_size: CGSize {
        get {
            return self.frame.size
        }
        set {
            self.frame.size = newValue
        }
    }
    
   
    
    func clearAll() {
        if self.subviews.count > 0 {
           self.subviews.forEach({ $0.removeFromSuperview()});
        }
    }
    
    func viewSetRadius(radius: CGFloat, maskToBounds: Bool = true) {
        self.layer.cornerRadius = radius
        self.layer.masksToBounds = maskToBounds
    }
    
   

    public func addSubviews(views: [UIView]) {
        
        for v in views {
            self.addSubview(v)
        }
        
    }
}

