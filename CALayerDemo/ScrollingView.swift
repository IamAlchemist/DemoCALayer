//
//  ScrollingView.swift
//  CALayerDemo
//
//  Created by Wizard Li on 12/25/15.
//  Copyright © 2015 Alchemist. All rights reserved.
//

import UIKit
import QuartzCore

class ScrollingView : UIView {
    override class var layerClass : AnyClass {
        return CAScrollLayer.self
    }
}
