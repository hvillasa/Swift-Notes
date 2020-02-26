//
//  CircularTransition.swift
//  InsetItemGrid
//
//  Created by s on 2/25/20.
//  Copyright © 2020 s. All rights reserved.
//

import UIKit

class CircularTransition: NSObject {

    var circle = UIView()

    var startingPoint = CGPoint.zero { didSet {
        circle.center = startingPoint
        }
    }

    var circleColor = UIColor.white

    var duration = 0.3

    enum CircularTransitionMode: Int {
        case pressent, dismiss, pop
    }

    var transitionMode: CircularTransitionMode = .pressent
}

extension CircularTransition: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }

    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let affineTransform = CGAffineTransform(scaleX: 0.001, y: 0.001)

        if transitionMode == .pressent {
            if let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to) {
                let viewCenter = presentedView.center
                let viewSize = presentedView.frame.size

                circle = UIView()
                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)
                circle.center = startingPoint
                circle.backgroundColor = circleColor
                circle.transform = affineTransform//CGAffineTransform(scaleX: 0.001, y: 0.001)
                containerView.addSubview(circle)

                presentedView.center = startingPoint
                presentedView.transform = affineTransform//CGAffineTransform(scaleX: 0.001, y: 0.001)
                presentedView.alpha = 0
                containerView.addSubview(presentedView)

                UIView.animate(withDuration: duration, animations: {
                    self.circle.transform = CGAffineTransform.identity
                    presentedView.alpha = 1
                    presentedView.center = viewCenter

                }) { (success: Bool) in
                    transitionContext.completeTransition(success)
                }
            }
        }else {
            let transitionModeKey = (transitionMode == .pop) ? UITransitionContextViewKey.to : UITransitionContextViewKey.from
            if let returningView = transitionContext.view(forKey: transitionModeKey) {
                let viewCenter = returningView.center
                let viewSize = returningView.frame.size

                circle.frame = frameForCircle(withViewCenter: viewCenter, size: viewSize, startPoint: startingPoint)

                circle.layer.cornerRadius = circle.frame.size.height / 2
                circle.center = startingPoint

                UIView.animate(withDuration: duration, animations: {
                    self.circle.transform = affineTransform//CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.transform = affineTransform//CGAffineTransform(scaleX: 0.001, y: 0.001)
                    returningView.center = self.startingPoint
                }) { (success: Bool) in
                    returningView.center = viewCenter
                    returningView.removeFromSuperview()
                    self.circle.removeFromSuperview()
                    transitionContext.completeTransition(success)
                }

            }
        }
    }

    func frameForCircle(withViewCenter viewCenter: CGPoint, size viewSize: CGSize, startPoint: CGPoint) -> CGRect {
        let xLength = fmax(startPoint.x, viewSize.width - startPoint.x)
        let yLength = fmax(startPoint.y, viewSize.height - startPoint.y)


        let offsetVector = sqrt(xLength * xLength + yLength * yLength) * 2
        let size = CGSize(width: offsetVector, height: offsetVector)

        return CGRect(origin: .zero, size: size)
    }

}