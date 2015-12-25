//
//  CAScrollLayer.swift
//  CALayerDemo
//
//  Created by Wizard Li on 12/25/15.
//  Copyright © 2015 Alchemist. All rights reserved.
//

import UIKit

class CAScrollLayerViewController : UIViewController {
    
    @IBOutlet weak var scrollingView: ScrollingView!
    @IBOutlet weak var horizontalSwitch: UISwitch!
    @IBOutlet weak var verticalSwitch: UISwitch!
    
    var scrollingViewLayer : CAScrollLayer {
        return scrollingView.layer as! CAScrollLayer
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollingViewLayer.scrollMode = kCAScrollBoth
    }
    
    @IBAction func panRecognized(sender: UIPanGestureRecognizer) {
        var newPoint = scrollingView.bounds.origin
        
        newPoint.x -= sender.translationInView(scrollingView).x
        newPoint.y -= sender.translationInView(scrollingView).y
        
        sender.setTranslation(CGPointZero, inView: scrollingView)
        
        scrollingViewLayer.scrollPoint(newPoint)
        
        
        if sender.state == .Ended {
            UIView.animateWithDuration(0.3, delay: 0, options: .CurveEaseInOut, animations: {
                self.scrollingViewLayer.scrollPoint(CGPointZero)
                }, completion: nil)
        }
        
    }
    
    @IBAction func scrollingSwitchChanged(sender: UISwitch) {
    }
}
