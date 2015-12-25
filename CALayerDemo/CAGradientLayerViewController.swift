//
//  CAGradientLayerViewController.swift
//  CALayerDemo
//
//  Created by wizard on 12/25/15.
//  Copyright © 2015 Alchemist. All rights reserved.
//

import UIKit

class CAGradientLayerViewController : UIViewController {
    
    @IBOutlet weak var viewForGradientLayer: UIView!
    @IBOutlet weak var startPointSlider: UISlider!
    @IBOutlet weak var startPointLabel: UILabel!
    @IBOutlet weak var endPointSlider: UISlider!
    @IBOutlet weak var endPointLabel: UILabel!
    
    @IBOutlet var colorSwitches: [UISwitch]!
    @IBOutlet var colorSliders: [UISlider]!
    @IBOutlet var colorLabels: [UILabel]!
    
    let gradientLayer = CAGradientLayer()
    
    var colors = [AnyObject]()
    
    let locations : [Float] = [0, 1/6.0, 1/3.0, 0.5, 2/3.0, 5/6.0, 1.0]
    
    // MARK: -
    
    func sortOutletCollections() {
        colorSliders.sortUIViewsInPlaceByTag()
        colorSwitches.sortUIViewsInPlaceByTag()
        colorLabels.sortUIViewsInPlaceByTag()
    }
    
    func setupColors() {
        colors = [cgColorForRed(209, green: 0, blue: 0),
        cgColorForRed(255, green: 102, blue: 34),
        cgColorForRed(255, green: 218, blue: 33),
        cgColorForRed(51, green: 221, blue: 0),
        cgColorForRed(17, green: 51, blue: 204),
        cgColorForRed(34, green: 0, blue: 102),
        cgColorForRed(51, green: 0, blue: 68)]
    }
    
    func setupGradientLayer() {
        gradientLayer.frame = viewForGradientLayer.bounds
        gradientLayer.colors = colors
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.locations = locations
    }
    
    func setupLocationSliders(){
        let sliders = colorSliders
        
        for (index, slider) in sliders.enumerate() {
            slider.value = locations[index]
        }
    }
    
    
    // MARK: -
    @IBAction func pointSliderChanged(sender: UISlider) {
        switch sender {
        case startPointSlider:
            gradientLayer.startPoint = CGPoint(x: CGFloat(sender.value), y: 0.0)
            updateLocationSliderValueLabels()
        case endPointSlider:
            gradientLayer.endPoint = CGPoint(x: CGFloat(sender.value), y: 1.0)
            updateLocationSliderValueLabels()
        default:
            break
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sortOutletCollections()
        setupColors()
        setupGradientLayer()
        viewForGradientLayer.layer.addSublayer(gradientLayer)
        
        setupLocationSliders()
        updateLocationSliderValueLabels()
    }
    
    // MARK: -
    
    func updateLocationSliderValueLabels() {
        for (index, label) in colorLabels.enumerate() {
            let colorSwitch = colorSwitches[index]
            
            if colorSwitch.on {
                let slider = colorSliders[index]
                label.text = String(format: "%.2f", slider.value)
                label.enabled = true
            }
            else{
                label.enabled = false
            }
        }
    }
    
    func updateStartAndEndPointLabels() {
        
    }
    
    // MARK: - IBActions
    
    
    
    // MARK: -
    func cgColorForRed(red: CGFloat, green: CGFloat, blue : CGFloat) -> AnyObject {
        return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0).CGColor as AnyObject
    }
}
