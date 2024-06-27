//
//  CLCustomAnimation.swift
//  MeiYuanXSYW
//
//  Created by Mac Pro on 2021/12/30.
//

import Foundation
import Presentr

class CLCustomAnimation: PresentrAnimation {
    override public func beforeAnimation(using transitionContext: PresentrTransitionContext) {
        
        transitionContext.animatingView?.alpha = transitionContext.isPresenting ? 0.0:1.0
        transitionContext.animatingView?.transform = transitionContext.isPresenting ? CGAffineTransform(scaleX: 1.2, y: 1.2):CGAffineTransform(scaleX: 1.0, y: 1.0)
    }
    
    override public func performAnimation(using transitionContext: PresentrTransitionContext) {
        transitionContext.animatingView?.alpha =  transitionContext.isPresenting ? 1.0:0.0
        transitionContext.animatingView?.transform = transitionContext.isPresenting ? CGAffineTransform(scaleX: 1.0, y: 1.0): CGAffineTransform(scaleX: 1.2, y: 1.2)
    }

    override public func afterAnimation(using transitionContext: PresentrTransitionContext) {
        transitionContext.animatingView?.alpha =  transitionContext.isPresenting ? 1.0:0.0
        transitionContext.animatingView?.transform = transitionContext.isPresenting ? CGAffineTransform(scaleX: 1.0, y: 1.0):CGAffineTransform(scaleX: 1.2, y: 1.2)
    }
}
