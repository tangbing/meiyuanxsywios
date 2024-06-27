//
//  TbAlertFadeAnimation.swift
//  TbAlertController
//
//  Created by Tb on 2021/6/21.
//

import UIKit

class TbAlertFadeAnimation: NSObject,UIViewControllerAnimatedTransitioning {
    
    var isPresenting: Bool
    
    init(isPresenting: Bool) {
        self.isPresenting = isPresenting
        super.init()
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.35
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresenting {
            presentAnimateTransition(using: transitionContext)
        } else {
            dismissAnimateTransition(using: transitionContext)
        }
    }
    
    func presentAnimateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let alertController =  transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to) as! TbAlertController
        
        alertController.backgroundView.alpha = 0.0
        switch alertController.preferredStyle {
        case .preferredStyleAlert:
            alertController.contentView.alpha = 0.0
            alertController.contentView.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            break
        case .preferredStyleActionSheet:
            UIView.animate(withDuration: 0.2, delay: 0, options: UIView.AnimationOptions.curveEaseOut) {
                let height = alertController.alertActions.count * Int(kActionSheetHeight) + 12 + 20
                alertController.contentView.transform = CGAffineTransform(translationX: 0, y: -CGFloat(height))
            }
        }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(alertController.view)
        
        alertController.backgroundView.alpha = 1.0
        
        switch alertController.preferredStyle {
        case .preferredStyleAlert:
            UIView.animate(withDuration: 0.2) {
                alertController.contentView.alpha = 1.0
                alertController.contentView.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                
            } completion: { finish in
                UIView.animate(withDuration: 0.15) {
                alertController.contentView.transform = .identity

                } completion: { finish in
                    transitionContext.completeTransition(true)
                }
            }
            break
        case .preferredStyleActionSheet:
            transitionContext.completeTransition(true)
            break
        }
        
    }
    
    func dismissAnimateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let alertController =  transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from) as! TbAlertController

        UIView.animate(withDuration: 0.15) {
            alertController.backgroundView.alpha = 0.0
            switch alertController.preferredStyle {
            case .preferredStyleAlert:
                alertController.contentView.alpha = 0.0
                
                alertController.contentView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                break
            case .preferredStyleActionSheet:
                let getHeight = alertController.contentView.frame.size.height
                alertController.contentView.transform = CGAffineTransform(translationX: 0, y: getHeight)
                break
            }
            
        } completion: { (finish) in
            transitionContext.completeTransition(true)
        }
        
    }
    

}
