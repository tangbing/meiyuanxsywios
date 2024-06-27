//
//  UIViewExtension.swift
//  U17
//
//  Created by charles on 2017/11/13.
//  Copyright © 2017年 None. All rights reserved.
//

import UIKit
import QMUIKit
// MARK:关于UIView的 圆角、阴影、边框 的设置
public extension UIView {
    
    func hg_setCornerOnTopWithRadius(radius:CGFloat) {
        layer.masksToBounds = true;
        layer.cornerRadius = radius;
        layer.qmui_maskedCorners = [QMUICornerMask.layerMinXMinYCorner,QMUICornerMask.layerMaxXMinYCorner]
    }
    func hg_setCornerOnBottomWithRadius(radius:CGFloat) {
        layer.masksToBounds = true;
        layer.cornerRadius = radius;
        layer.qmui_maskedCorners = [QMUICornerMask.layerMinXMaxYCorner,QMUICornerMask.layerMaxXMaxYCorner]
    }
    func hg_setAllCornerWithCornerRadius(radius:CGFloat) {
        layer.cornerRadius = radius;
        layer.masksToBounds = true;
    }
    
    func hg_setCorner(conrner:QMUICornerMask, radius:CGFloat) {
        layer.masksToBounds = true;
        layer.cornerRadius = radius;
        layer.qmui_maskedCorners = conrner
    }
    
    /// 给视图添加圆角+圆角边框,解决思路：用UIBezierPath画好边框，在切圆角
    /// 给视图添加圆角+圆角边框
    /// - Parameters:
    ///   - conrners: 那个方向圆角
    ///   - radius: 圆角半径
    ///   - borderWidth: 边框宽度
    ///   - borderColor: 边框的颜色
    func hg_setCorner(conrners: UIRectCorner, radius: CGFloat, borderWidth: CGFloat = 1.0, borderColor: UIColor) {
        let maskPath = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: conrners, cornerRadii: CGSize(width: radius, height: radius))
        
        let borderShapeLayer = CAShapeLayer()
        borderShapeLayer.lineWidth = borderWidth
        borderShapeLayer.fillColor = UIColor.clear.cgColor
        borderShapeLayer.strokeColor = borderColor.cgColor
        borderShapeLayer.frame = self.bounds
        borderShapeLayer.path = maskPath.cgPath
        self.layer.addSublayer(borderShapeLayer)
        
        let mask = CAShapeLayer(layer: borderShapeLayer)
        mask.path = maskPath.cgPath
        self.layer.mask = mask
    }
    
    
    func hg_addGradientColor(_ colors : [UIColor],size: CGSize, startPoint: CGPoint, endPoint: CGPoint, locations:[NSNumber] = [0, 1]) {
        let bgLayer1 = CAGradientLayer()
        bgLayer1.colors = [colors[0].cgColor, colors[1].cgColor]
        bgLayer1.locations = [0, 1]
        bgLayer1.frame = CGRect(origin: .zero, size: size)
        bgLayer1.startPoint = CGPoint(x: 0.5, y: 0)
        bgLayer1.endPoint = CGPoint(x: 1, y: 1)
        layer.insertSublayer(bgLayer1, at: 0)
    }

    // MARK: 5.2、给继承于view的类添加阴影
    /// 给继承于view的类添加阴影
    /// - Parameters:
    ///   - shadowColor: 阴影的颜色
    ///   - shadowOffset: 阴影的偏移度：CGSizeMake(X[正的右偏移,负的左偏移], Y[正的下偏移,负的上偏移])
    ///   - shadowOpacity: 阴影的透明度
    ///   - shadowRadius: 阴影半径，默认 3
    func addShadow(shadowColor: UIColor, shadowOffset: CGSize, shadowOpacity: Float, shadowRadius: CGFloat = 3) {
        // 设置阴影颜色
        layer.shadowColor = shadowColor.cgColor
        // 设置透明度
        layer.shadowOpacity = shadowOpacity
        // 设置阴影半径
        layer.shadowRadius = shadowRadius
        // 设置阴影偏移量
        layer.shadowOffset = shadowOffset
    }

}


extension UIView {
    
    private struct AssociatedKeys {
        static var descriptiveName = "AssociatedKeys.DescriptiveName.blurView"
    }
    
    private (set) var blurView: BlurView {
        get {
            if let blurView = objc_getAssociatedObject(
                self,
                &AssociatedKeys.descriptiveName
                ) as? BlurView {
                return blurView
            }
            self.blurView = BlurView(to: self)
            return self.blurView
        }
        set(blurView) {
            objc_setAssociatedObject(
                self,
                &AssociatedKeys.descriptiveName,
                blurView,
                .OBJC_ASSOCIATION_RETAIN_NONATOMIC
            )
        }
    }
    
    class BlurView {
        
        private var superview: UIView
        private var blur: UIVisualEffectView?
        private var editing: Bool = false
        private (set) var blurContentView: UIView?
        private (set) var vibrancyContentView: UIView?
        
        var animationDuration: TimeInterval = 0.1
        
        /**
         * Blur style. After it is changed all subviews on
         * blurContentView & vibrancyContentView will be deleted.
         */
        var style: UIBlurEffect.Style = .light {
            didSet {
                guard oldValue != style,
                    !editing else { return }
                applyBlurEffect()
            }
        }
        /**
         * Alpha component of view. It can be changed freely.
         */
        var alpha: CGFloat = 0 {
            didSet {
                guard !editing else { return }
                if blur == nil {
                    applyBlurEffect()
                }
                let alpha = self.alpha
                UIView.animate(withDuration: animationDuration) {
                    self.blur?.alpha = alpha
                }
            }
        }
        
        init(to view: UIView) {
            self.superview = view
        }
        
        func setup(style: UIBlurEffect.Style, alpha: CGFloat) -> Self {
            self.editing = true
            
            self.style = style
            self.alpha = alpha
            
            self.editing = false
            
            return self
        }
        
        func enable(isHidden: Bool = false) {
            if blur == nil {
                applyBlurEffect()
            }
            
            self.blur?.isHidden = isHidden
        }
        
        private func applyBlurEffect() {
            blur?.removeFromSuperview()
            
            applyBlurEffect(
                style: style,
                blurAlpha: alpha
            )
        }
        
        private func applyBlurEffect(style: UIBlurEffect.Style,
                                     blurAlpha: CGFloat) {
            superview.backgroundColor = UIColor.clear
            
            let blurEffect = UIBlurEffect(style: style)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            
            let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
            let vibrancyView = UIVisualEffectView(effect: vibrancyEffect)
            blurEffectView.contentView.addSubview(vibrancyView)
            
            blurEffectView.alpha = blurAlpha
            
            superview.insertSubview(blurEffectView, at: 0)
            
            blurEffectView.addAlignedConstrains()
            vibrancyView.addAlignedConstrains()
            
            self.blur = blurEffectView
            self.blurContentView = blurEffectView.contentView
            self.vibrancyContentView = vibrancyView.contentView
        }
    }
    
    private func addAlignedConstrains() {
        translatesAutoresizingMaskIntoConstraints = false
        addAlignConstraintToSuperview(attribute: NSLayoutConstraint.Attribute.top)
        addAlignConstraintToSuperview(attribute: NSLayoutConstraint.Attribute.leading)
        addAlignConstraintToSuperview(attribute: NSLayoutConstraint.Attribute.trailing)
        addAlignConstraintToSuperview(attribute: NSLayoutConstraint.Attribute.bottom)
    }
    
    private func addAlignConstraintToSuperview(attribute: NSLayoutConstraint.Attribute) {
        superview?.addConstraint(
            NSLayoutConstraint(
                item: self,
                attribute: attribute,
                relatedBy: NSLayoutConstraint.Relation.equal,
                toItem: superview,
                attribute: attribute,
                multiplier: 1,
                constant: 0
            )
        )
    }

}
