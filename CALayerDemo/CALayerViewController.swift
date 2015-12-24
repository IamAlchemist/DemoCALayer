//
//  CALayerViewController.swift
//  CALayerDemo
//
//  Created by wizard on 12/24/15.
//  Copyright © 2015 Alchemist. All rights reserved.
//

import UIKit

class CALayerViewController : UIViewController
{
    @IBOutlet weak var viewForLayer: UIView!
    
    let layer = CALayer()
    let star = UIImage(named: "star")?.CGImage
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        setupLayer()
        viewForLayer.layer.addSublayer(layer)
    }
    
    func setupLayer()
    {
        layer.frame = viewForLayer.bounds
        layer.contents = star
        layer.contentsGravity = kCAGravityCenter
        layer.backgroundColor = swiftGreenColor.CGColor
        layer.cornerRadius = 100
        layer.borderWidth = 12
        layer.borderColor = UIColor.whiteColor().CGColor
        layer.shadowOpacity = 0.75
        layer.shadowRadius = 3.0
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.magnificationFilter = kCAFilterLinear
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        guard let identifier = segue.identifier
            else { return }
        
        switch identifier {
        case "DisplayLayerControls":
            (segue.destinationViewController as? CALayerControlsViewController)?.layerViewController = self
        default:
            break
        }
    }
}
