//
//  CAShapeLayerViewController.swift
//  CALayerDemo
//
//  Created by Wizard Li on 4/18/16.
//  Copyright © 2016 Alchemist. All rights reserved.
//

import UIKit

class CAShapeLayerViewController : UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let rect = CGRect(x: 100, y: 100, width: 100, height: 200)
        let radii = CGSize(width: 20, height: 20);
        let corners : UIRectCorner = [.topLeft,.topRight]
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: radii)
        
        let layer = CAShapeLayer()
        layer.strokeColor = UIColor.red.cgColor
        layer.fillColor = UIColor.clear.cgColor
        layer.lineJoin = kCALineJoinRound
        layer.lineCap = kCALineCapRound
        layer.lineWidth = 2
        layer.path = path.cgPath

        view.layer.addSublayer(layer)
    }
}
