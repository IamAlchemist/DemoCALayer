//
//  CATextLayerViewController.swift
//  CALayerDemo
//
//  Created by Wizard Li on 12/25/15.
//  Copyright © 2015 Alchemist. All rights reserved.
//

import UIKit

class CATextLayerViewController : UIViewController {
    
    @IBOutlet weak var viewForTextLayer: UIView!
    @IBOutlet weak var fontSizeValueLabel: UILabel!
    @IBOutlet weak var fontSizeSlider: UISlider!
    @IBOutlet weak var wrapTextSwitch: UISwitch!
    @IBOutlet weak var alignmentModeSegmentedControl: UISegmentedControl!
    @IBOutlet weak var truncateModeSegementedControl: UISegmentedControl!
    
    @IBAction func fontChanged(sender: UISegmentedControl) {
    }
    
    @IBAction func fontSizeChanged(sender: UISlider) {
    }
    
    @IBAction func wrapTextSwitchChanged(sender: UISwitch) {
    }
    
    @IBAction func aligmentModeChanged(sender: UISegmentedControl) {
    }
    
    @IBAction func truncatModeChanged(sender: UISegmentedControl) {
    }
    
    
}
