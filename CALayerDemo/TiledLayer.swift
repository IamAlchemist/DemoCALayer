//
//  TiledLayer.swift
//  CALayerDemo
//
//  Created by wizard on 12/26/15.
//  Copyright © 2015 Alchemist. All rights reserved.
//

import UIKit

class TiledLayer : CATiledLayer {
    
    static var adustableFadeDuration : CFTimeInterval = 0.25
    
    override class func fadeDuration() -> CFTimeInterval {
        return TiledLayer.adustableFadeDuration
    }
    
    class func setFadeDuration(_ duration : CFTimeInterval){
        TiledLayer.adustableFadeDuration = duration
    }
}
