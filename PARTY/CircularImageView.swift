//
//  CircularImageView.swift
//  PARTY
//
//  Created by Reuben Ukah on 9/3/15.
//  Copyright © 2015 Versuvian. All rights reserved.
//

import UIKit
@IBDesignable

class CircularImageView: UIView {
    var backgroundLayer: CAShapeLayer!
    @IBInspectable var backgroundLayerColor : UIColor = UIColor.grayColor()
    @IBInspectable var lineWidth: CGFloat = 1.0
    
    
    override func layoutSubviews() {
         super.layoutSubviews()
         setBackgroundLayer()
    }
    func setBackgroundLayer() {
        if backgroundLayer == nil {
        backgroundLayer = CAShapeLayer()
        layer.addSublayer(backgroundLayer)
            let rect = CGRectInset(bounds, lineWidth / 2.0, lineWidth / 2.0)
            let path = UIBezierPath(ovalInRect: rect)
            backgroundLayer.path = path.CGPath
            backgroundLayer.lineWidth = lineWidth
            backgroundLayer.fillColor = backgroundLayerColor.CGColor
        }
            backgroundLayer.frame = layer.bounds
        
    
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}
