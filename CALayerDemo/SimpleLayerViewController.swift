//
//  ViewController.swift
//  CALayerDemo
//
//  Created by wizard on 12/23/15.
//  Copyright © 2015 Alchemist. All rights reserved.
//

import UIKit

class SimpleLayerViewController: UIViewController {

    @IBOutlet weak var viewForLayer: UIView!
    
    var firstLayer : CALayer {
        return viewForLayer.layer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupFirstLayer()
    }

    func setupFirstLayer() {
        firstLayer.backgroundColor = UIColor.blueColor().CGColor
        firstLayer.borderWidth = 100
        firstLayer.borderColor = UIColor.redColor().CGColor
        firstLayer.shadowOpacity = 0.7
        firstLayer.shadowRadius = 10
        
        firstLayer.contents = UIImage(named: "star")?.CGImage
        firstLayer.contentsGravity = kCAGravityCenter
    }

    @IBAction func tapGestureRecognized(sender: UITapGestureRecognizer) {
        firstLayer.shadowOpacity = firstLayer.shadowOpacity == 0.7 ? 0.0 : 0.7
    }
    
    @IBAction func pinchGestureRecognized(sender: UIPinchGestureRecognizer) {
        let offset : CGFloat = sender.scale < 1 ? 5.0 : -5.0
        let oldFrame = firstLayer.frame
        let oldOrigin = oldFrame.origin
        let newOrigin = CGPoint(x: oldOrigin.x + offset, y: oldOrigin.y + offset)
        let newSize = CGSize(width: oldFrame.width + (offset * -2.0), height: oldFrame.height + (offset * -2.0))
        let newFrame = CGRect(origin: newOrigin, size: newSize)
        if newFrame.width >= 100.0 && newFrame.width <= 300.0 {
            firstLayer.borderWidth -= offset
            firstLayer.cornerRadius += (offset / 2.0)
            firstLayer.frame = newFrame
        }
    }
}

