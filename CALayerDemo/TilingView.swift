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
    
    override class var layerClass : AnyClass {
        return TiledLayer.self
    }
    
    required init?(coder aDecoder: NSCoder) {
        srand48(Int(Date().timeIntervalSince1970))
        super.init(coder: aDecoder)
        guard let layer = self.layer as? TiledLayer else { return nil }
        layer.contentsScale = UIScreen.main.scale
        layer.tileSize = CGSize(width: sideLength, height: sideLength)
    }
    
    override func draw(_ rect: CGRect) {
        NSLog("w: %f, h: %f", rect.size.width, rect.size.height)
        let context = UIGraphicsGetCurrentContext()
        let scale = UIScreen.main.scale
        
        var red = CGFloat(drand48())
        var green = CGFloat(drand48())
        var blue = CGFloat(drand48())
        
        context?.setFillColor(red: red, green: green, blue: blue, alpha: 1.0)
        context?.fill(rect)
        
        let x = bounds.origin.x
        let y = bounds.origin.y
        let offset = bounds.width / CGFloat(sideLength) * (scale == 3 ? 2 : scale)
        
        context?.move(to: CGPoint(x: x + 9.0 * offset, y: y + 43.0 * offset))
        context?.addLine(to: CGPoint(x: x + 18.06 * offset, y: y + 22.6 * offset))
        context?.addLine(to: CGPoint(x: x + 25.0 * offset, y: y + 7.5 * offset))
        context?.addLine(to: CGPoint(x: x + 41.0 * offset, y: y + 43.0 * offset))
        context?.addLine(to: CGPoint(x: x + 9.0 * offset, y: y + 21.66 * offset))
        context?.addLine(to: CGPoint(x: x + 41.0 * offset, y: y + 14.54 * offset))
        context?.addLine(to: CGPoint(x: x + 9.0 * offset, y: y + 43.0 * offset))
        context?.closePath()
        
        red = CGFloat(drand48())
        green = CGFloat(drand48())
        blue = CGFloat(drand48())
        context?.setFillColor(red: red, green: green, blue: blue, alpha: 1.0)
        context?.setStrokeColor(UIColor.white.cgColor)
        context?.setLineWidth(4.0 / scale)
        context?.drawPath(using: .eoFillStroke)
    }
}
