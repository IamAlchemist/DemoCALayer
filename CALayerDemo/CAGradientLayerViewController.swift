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
    
}
