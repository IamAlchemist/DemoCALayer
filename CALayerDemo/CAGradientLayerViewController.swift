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
    }
    
}
