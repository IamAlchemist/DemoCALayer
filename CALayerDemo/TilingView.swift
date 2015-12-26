//
//  TilingView.swift
//  CALayerDemo
//
//  Created by wizard on 12/26/15.
//  Copyright © 2015 Alchemist. All rights reserved.
//

import UIKit

class TilingView : UIView {
    
    let sideLength = 100
    
    override class func layerClass() -> AnyClass {
        return TiledLayer.self
    }
    
    required init?(coder aDecoder: NSCoder) {
        srand48(Int(NSDate().timeIntervalSince1970))
        super.init(coder: aDecoder)
        guard let layer = self.layer as? TiledLayer else { return nil }
        layer.contentsScale = UIScreen.mainScreen().scale
        layer.tileSize = CGSize(width: sideLength, height: sideLength)
    }
    
    override func drawRect(rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        let scale = UIScreen.mainScreen().scale
        
        var red = CGFloat(drand48())
        var green = CGFloat(drand48())
        var blue = CGFloat(drand48())
        
        CGContextSetRGBFillColor(context, red, green, blue, 1.0)
        CGContextFillRect(context, rect)
        
        let x = bounds.origin.x
        let y = bounds.origin.y
        let offset = CGRectGetWidth(bounds) / CGFloat(sideLength) * (scale == 3 ? 2 : scale)
        
        CGContextMoveToPoint(context, x + 9.0 * offset, y + 43.0 * offset)
        CGContextAddLineToPoint(context, x + 18.06 * offset, y + 22.6 * offset)
        CGContextAddLineToPoint(context, x + 25.0 * offset, y + 7.5 * offset)
        CGContextAddLineToPoint(context, x + 41.0 * offset, y + 43.0 * offset)
        CGContextAddLineToPoint(context, x + 9.0 * offset, y + 21.66 * offset)
        CGContextAddLineToPoint(context, x + 41.0 * offset, y + 14.54 * offset)
        CGContextAddLineToPoint(context, x + 9.0 * offset, y + 43.0 * offset)
        CGContextClosePath(context)
        
        red = CGFloat(drand48())
        green = CGFloat(drand48())
        blue = CGFloat(drand48())
        CGContextSetRGBFillColor(context, red, green, blue, 1.0)
        CGContextSetStrokeColorWithColor(context, UIColor.whiteColor().CGColor)
        CGContextSetLineWidth(context, 4.0 / scale)
        CGContextDrawPath(context, .EOFillStroke)
    }
}
