//
//  CATransformLayerViewController.swift
//  CALayerDemo
//
//  Created by Wizard Li on 4/18/16.
//  Copyright © 2016 Alchemist. All rights reserved.
//

import UIKit

class CATransformLayerViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var perspective = CATransform3DIdentity
        perspective.m34 = -1.0/500.0
        view.layer.sublayerTransform = perspective
        
        let transform1 = CATransform3DMakeTranslation(-100, 0, 0)
        view.layer.addSublayer(cubeWithTransform(transform1))
        
        var transform2 = CATransform3DIdentity
        transform2 = CATransform3DTranslate(transform2, 100, 0, 0)
        transform2 = CATransform3DRotate(transform2, CGFloat(-M_PI_4), 1, 0, 0)
        transform2 = CATransform3DRotate(transform2, CGFloat(-M_PI_4), 0, 1, 0)
        view.layer.addSublayer(cubeWithTransform(transform2))
    }
    
    func faceWithTransform(transform : CATransform3D) -> CALayer {
        let face = CALayer()
        face.frame = CGRect(x: -50, y: -50, width: 100, height: 100)
        
        let red = (CGFloat(rand()) / CGFloat(INT_MAX))
        let green = (CGFloat(rand()) / CGFloat(INT_MAX))
        let blue = (CGFloat(rand()) / CGFloat(INT_MAX))
        face.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1.0).CGColor
        
        face.transform = transform
        
        return face
    }
    
    func cubeWithTransform(transform : CATransform3D) -> CALayer {
        let cube = CATransformLayer()
        
        var ct = CATransform3DMakeTranslation(0, 0, 50)
        cube.addSublayer(faceWithTransform(ct))
        
        ct = CATransform3DMakeTranslation(50, 0, 0)
        ct = CATransform3DRotate(ct, CGFloat(M_PI_2), 0, 1, 0)
        cube.addSublayer(faceWithTransform(ct))
        
        ct = CATransform3DMakeTranslation(0, -50, 0)
        ct = CATransform3DRotate(ct, CGFloat(M_PI_2), 1, 0, 0)
        cube.addSublayer(faceWithTransform(ct))
        
        ct = CATransform3DMakeScale(0, 50, 0)
        ct = CATransform3DRotate(ct, CGFloat(-M_PI_2), 0, 1, 0)
        cube.addSublayer(faceWithTransform(ct))
        
        ct = CATransform3DMakeTranslation(-50, 0, 0)
        ct = CATransform3DRotate(ct, CGFloat(-M_PI_2), 0, 1, 0)
        cube.addSublayer(faceWithTransform(ct))
        
        ct = CATransform3DMakeTranslation(0, 0, -50)
        ct = CATransform3DRotate(ct, CGFloat(M_PI), 0, 1, 0)
        cube.addSublayer(faceWithTransform(ct))
        
        let contentSize = view.bounds.size
        cube.position = CGPoint(x: contentSize.width / 2, y: contentSize.height / 2)
        
        cube.transform = transform
        return cube
    }
}
