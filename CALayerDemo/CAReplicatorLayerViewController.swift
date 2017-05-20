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
        case red, green, blue, alpha
    }

    var replicatorLayer = CAReplicatorLayer();
    let whiteColor = UIColor.white.cgColor
    let lengthMultiplier : CGFloat = 3.0
    let instanceLayer = CALayer()
    let fadeAnimation = CABasicAnimation(keyPath: "opacity")

    // MARK: -
    func offsetValueForSwitch(_ offsetType : OffsetType) -> Float {
        switch offsetType {
        case .alpha:
            let count = Float(replicatorLayer.instanceCount)
            return offsetSwitches[offsetType.rawValue].isOn ? -1.0 / count : 0.0
        case .red, .green, .blue:
            return offsetSwitches[offsetType.rawValue].isOn ? 0.0 : -0.05
        }
    }
    
    // MARK: -
    
    func setupReplicatorLayer() {
        replicatorLayer.frame = viewForReplicatorLayer.bounds
        let count = Int(instanceCountSlider.value * 30)
        replicatorLayer.instanceCount = count
        replicatorLayer.instanceColor = whiteColor
        replicatorLayer.instanceRedOffset = offsetValueForSwitch(.red)
        replicatorLayer.instanceGreenOffset = offsetValueForSwitch(.green)
        replicatorLayer.instanceBlueOffset = offsetValueForSwitch(.blue)
        replicatorLayer.instanceAlphaOffset = offsetValueForSwitch(.alpha)
        let angle = Float(M_PI * 2.0) / Float(count)
        replicatorLayer.instanceTransform = CATransform3DMakeRotation(CGFloat(angle), 0.0, 0.0, 1.0)
    }
    
    func setupInstanceLayer() {
        let layerWidth = CGFloat(Int(layerSizeSlider.value * 10))
        let originX = CGFloat(Int(viewForReplicatorLayer.bounds.midX - layerWidth / 2.0))
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
        instanceLayer.add(fadeAnimation, forKey: "FadeAnimation")
    }
    
    func updateInstanceCountSliderValueLabel(){
        instanceCountLabel.text = String(format: "%.0f", instanceCountSlider.value * 30)
    }
        
    
    // MARK: -
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewForReplicatorLayer.backgroundColor = UIColor.black
        
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
    @IBAction func instanceSizeChanged(_ sender: UISlider) {
        let value = CGFloat(sender.value * 10)
        instanceLayer.bounds = CGRect(origin: CGPoint.zero, size: CGSize(width: value, height: value * lengthMultiplier))
    }
    
    @IBAction func instanceCountChanged(_ sender: UISlider) {
        replicatorLayer.instanceCount = Int(sender.value * 30)
        replicatorLayer.instanceAlphaOffset = offsetValueForSwitch(.alpha)
        updateInstanceCountSliderValueLabel()
    }
    
    @IBAction func instanceDelayChanged(_ sender: UISlider) {
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
    
    @IBAction func offsetSwitchChanged(_ sender: UISwitch) {
        let offsetType = OffsetType(rawValue: offsetSwitches.index(of: sender)!)!
        switch offsetType {
        case .red:
            replicatorLayer.instanceRedOffset = offsetValueForSwitch(.red)
        case .green:
            replicatorLayer.instanceGreenOffset = offsetValueForSwitch(.green)
        case .blue:
            replicatorLayer.instanceBlueOffset = offsetValueForSwitch(.blue)
        case .alpha:
            replicatorLayer.instanceAlphaOffset = offsetValueForSwitch(.alpha)
        }
    }
}





















