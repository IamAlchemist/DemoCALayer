//
//  CAEmitterLayerViewController.swift
//  CALayerDemo
//
//  Created by wizard on 4/18/16.
//  Copyright © 2016 Alchemist. All rights reserved.
//

import UIKit

class CAEmitterViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let emitter = CAEmitterLayer()
        emitter.frame = view.bounds
        view.layer.addSublayer(emitter)
        
        emitter.renderMode = kCAEmitterLayerAdditive
        emitter.emitterPosition = CGPoint(x: emitter.frame.width / 2.0, y: emitter.frame.height / 2)
        
        let cell = CAEmitterCell()
        cell.contents = UIImage(named: "smallStar")?.CGImage
        cell.birthRate = 150
        cell.lifetime = 5.0
        cell.color = UIColor(red: 1, green: 0.5, blue: 0.1, alpha: 1.0).CGColor
        cell.alphaSpeed = -0.4
        cell.velocity = 50
        cell.velocityRange = 50
        cell.emissionRange = CGFloat(M_PI) * 2.0
        
        emitter.emitterCells = [cell]
    }
}
