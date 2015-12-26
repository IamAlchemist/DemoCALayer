//
//  CARelicatorLayerViewController.swift
//  CALayerDemo
//
//  Created by wizard on 12/26/15.
//  Copyright © 2015 Alchemist. All rights reserved.
//

import UIKit

class CAReplicatorLayerViewController : UIViewController {
    
    @IBOutlet weak var viewForReplicatorLayer: UIView!
    @IBOutlet weak var layerSizeSlider: UISlider!
    @IBOutlet weak var layerSizeLabel: UILabel!
    @IBOutlet weak var instanceCountSlider: UISlider!
    @IBOutlet weak var instanceCountLabel: UILabel!
    @IBOutlet weak var instanceDelaySlider: UISlider!
    @IBOutlet weak var instanceDelayLabel: UILabel!
    @IBOutlet var offsetSwitches: [UISwitch]!
    
    enum OffsetType : Int {
        case Red, Green, Blue, Alpha
    }

    var replicatorLayer = CAReplicatorLayer();
    let whiteColor = UIColor.whiteColor().CGColor
    let lengthMultiplier : CGFloat = 3.0
    let instanceLayer = CALayer()
    let fadeAnimation = CABasicAnimation(keyPath: "opacity")

    // MARK: -
    func offsetValueForSwitch(offsetType : OffsetType) -> Float {
        switch offsetType {
        case .Alpha:
            let count = Float(replicatorLayer.instanceCount)
            return offsetSwitches[offsetType.rawValue].on ? -1.0 / count : 0.0
        case .Red, .Green, .Blue:
            return offsetSwitches[offsetType.rawValue].on ? 0.0 : -0.05
        }
    }
    
    // MARK: -
    
    func setupReplicatorLayer() {
        replicatorLayer.frame = viewForReplicatorLayer.bounds
        let count = Int(instanceCountSlider.value * 30)
        replicatorLayer.instanceCount = count
        replicatorLayer.instanceColor = whiteColor
        replicatorLayer.instanceRedOffset = offsetValueForSwitch(.Red)
        replicatorLayer.instanceGreenOffset = offsetValueForSwitch(.Green)
        replicatorLayer.instanceBlueOffset = offsetValueForSwitch(.Blue)
        replicatorLayer.instanceAlphaOffset = offsetValueForSwitch(.Alpha)
        let angle = Float(M_PI * 2.0) / Float(count)
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(CGFloat(angle), 0.0, 0.0, 1.0)
    }
    
    func setupInstanceLayer() {
        let layerWidth = CGFloat(Int(layerSizeSlider.value * 10))
        let originX = CGFloat(Int(CGRectGetMidX(viewForReplicatorLayer.bounds) - layerWidth / 2.0))
        instanceLayer.frame = CGRect(x: originX, y: 0, width: layerWidth, height: layerWidth * lengthMultiplier)
        instanceLayer.backgroundColor = whiteColor
    }
    
    func setupFadeAnimation() {
        fadeAnimation.fromValue = 1
        fadeAnimation.toValue = 0
        fadeAnimation.repeatCount = Float(Int.max)
    }
    
    func setLayerFadeAnimation() {
        instanceLayer.opacity = 0
        fadeAnimation.duration = CFTimeInterval(instanceDelaySlider.value * 10)
        instanceLayer.addAnimation(fadeAnimation, forKey: "FadeAnimation")
    }
    
    func updateInstanceCountSliderValueLabel(){
        instanceCountLabel.text = String(format: "%.0f", instanceCountSlider.value * 30)
    }
        
    
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewForReplicatorLayer.backgroundColor = UIColor.blackColor()
        
        setupReplicatorLayer()
        viewForReplicatorLayer.layer.addSublayer(replicatorLayer)
        
        setupInstanceLayer()
        replicatorLayer.addSublayer(instanceLayer)
        
        setupFadeAnimation()
        
        instanceDelayChanged(instanceDelaySlider)
        
        updateInstanceCountSliderValueLabel()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        setupReplicatorLayer()
        setupInstanceLayer()
    }
    
    
    // MARK: -
    @IBAction func instanceSizeChanged(sender: UISlider) {
        let value = CGFloat(sender.value * 10)
        instanceLayer.bounds = CGRect(origin: CGPointZero, size: CGSize(width: value, height: value * lengthMultiplier))
    }
    
    @IBAction func instanceCountChanged(sender: UISlider) {
        replicatorLayer.instanceCount = Int(sender.value * 30)
        replicatorLayer.instanceAlphaOffset = offsetValueForSwitch(.Alpha)
        updateInstanceCountSliderValueLabel()
    }
    
    @IBAction func instanceDelayChanged(sender: UISlider) {
        if sender.value > 0.0 {
            replicatorLayer.instanceDelay = CFTimeInterval(sender.value * 10 / Float(replicatorLayer.instanceCount))
            setLayerFadeAnimation()
        }
        else {
            replicatorLayer.instanceDelay = 0.0
            instanceLayer.opacity = 1.0
            instanceLayer.removeAllAnimations()
        }
    }
    
    @IBAction func offsetSwitchChanged(sender: UISwitch) {
        let offsetType = OffsetType(rawValue: offsetSwitches.indexOf(sender)!)!
        switch offsetType {
        case .Red:
            replicatorLayer.instanceRedOffset = offsetValueForSwitch(.Red)
        case .Green:
            replicatorLayer.instanceGreenOffset = offsetValueForSwitch(.Green)
        case .Blue:
            replicatorLayer.instanceBlueOffset = offsetValueForSwitch(.Blue)
        case .Alpha:
            replicatorLayer.instanceAlphaOffset = offsetValueForSwitch(.Alpha)
        }
    }
}





















