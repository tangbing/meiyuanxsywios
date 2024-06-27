//
//  UIButtonExtension.swift
//  tbzxs_student_ios
//
//  Created by Tb on 2021/6/5.
//

import UIKit

enum TbButtonImageEdgeInsetsStyle {
    case top
    case left
    case right
    case bottom
}

extension UIButton {
    
    func imagePosition(at style: TbButtonImageEdgeInsetsStyle,
                       space: CGFloat) {
        guard let imagV = imageView else { return }
        guard let titleL = titleLabel else { return }

        let imageWidth = imagV.frame.size.width
        let imageHeight = imagV.frame.size.height
        
        let labelWidht = titleL.intrinsicContentSize.width
        let labelHeight = titleL.intrinsicContentSize.height
        
        var imageEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets = UIEdgeInsets.zero
        
        //UIButton同时有图像和文字的正常状态---左图像右文字，间距为0

        switch style {
        case .left:
            // 正常状态--只不过加了个间距
            imageEdgeInsets = UIEdgeInsets(top: 0, left: -space * 0.5, bottom: 0, right: space * 0.5)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: space * 0.5, bottom: 0, right: -space * 0.5)
        case .right:
            // 切换位置--左文字右图形
            //图像：UIEdgeInsets的left是相对于UIButton的左边移动了labelWidth + space * 0.5，right相对于label的左边移动了-labelWidth - space * 0.5

            imageEdgeInsets = UIEdgeInsets(top: 0, left: labelWidht +  space * 0.5, bottom: 0, right: -labelWidht - space * 0.5)
            labelEdgeInsets = UIEdgeInsets(top: 0, left: -imageWidth - space * 0.5, bottom: 0, right: imageWidth + space * 0.5)
        case .top:
            // 切换位置--上图形下文字
            // 图像的中心位置向右边移动了labelWidth * 0.5，向上移动了-imageHeight * 0.5 - space * 0.5
            // 文字的中心位置向左边移动了imageWidth* 0.5，向下移动了labelHeight * 0.5 + space * 0.5
            imageEdgeInsets = UIEdgeInsets(top: -imageHeight * 0.5 - space * 0.5, left: labelWidht * 0.5, bottom: imageHeight * 0.5 + space * 0.5, right: -labelWidht * 0.5)
            labelEdgeInsets = UIEdgeInsets(top: labelHeight * 0.5 + space * 0.5, left: -imageWidth * 0.5, bottom: -labelHeight * 0.5 - space * 0.5, right: imageWidth * 0.5)
        case .bottom:
            // 切换位置--下图形上文字
            // 图像的中心位置向右边移动了labelWidth * 0.5，向下移动了imageHeight * 0.5 + space * 0.5
            // 文字的中心位置向左边移动imageWidth * 0.5，向上移动了labelHeight * 0.5 + space * 0.5
            imageEdgeInsets = UIEdgeInsets(top: imageHeight * 0.5 + space * 0.5, left: labelWidht * 0.5, bottom: -imageHeight * 0.5 - space * 0.5, right: -labelWidht * 0.5)
            labelEdgeInsets = UIEdgeInsets(top: -labelHeight * 0.5 - space * 0.5, left: -imageWidth * 0.5, bottom: labelHeight * 0.5 + space * 0.5, right: imageWidth * 0.5)
        }
        
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
        
        
        
    }
    
    
}


public extension UIButton {
    /// SwifterSwift: Set some or all corners radiuses of view.
    ///
    /// - Parameters:
    ///   - corners: array of corners to change (example: [.bottomLeft, .topRight]).
    ///   - radius: radius for selected corners.
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let maskPath = UIBezierPath(
            roundedRect: bounds,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius))

        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        layer.mask = shape
    }
}
