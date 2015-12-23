//
//  ViewController.swift
//  CALayerDemo
//
//  Created by wizard on 12/23/15.
//  Copyright © 2015 Alchemist. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

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

}

