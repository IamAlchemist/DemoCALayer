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
    
    @IBAction func panRecognized(_ sender: UIPanGestureRecognizer) {
        var newPoint = scrollingView.bounds.origin
        
        newPoint.x -= sender.translation(in: scrollingView).x
        newPoint.y -= sender.translation(in: scrollingView).y
        
        sender.setTranslation(CGPoint.zero, in: scrollingView)
        
        scrollingViewLayer.scroll(newPoint)
        
        
        if sender.state == .ended {
            UIView.animate(withDuration: 0.3, delay: 0, options: UIViewAnimationOptions(), animations: {
                self.scrollingViewLayer.scroll(CGPoint.zero)
                }, completion: nil)
        }
        
    }
    
    @IBAction func scrollingSwitchChanged(_ sender: UISwitch) {
    }
}
