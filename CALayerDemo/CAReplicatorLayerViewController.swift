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
    
    
    // MARK: -
    
    
    // MARK: -
    @IBAction func instanceSizeChanged(sender: UISlider) {
    }
    
    @IBAction func instanceCountChanged(sender: UISlider) {
    }
    
    @IBAction func instanceDelayChanged(sender: UISlider) {
    }
    
    @IBAction func offsetSwitchChanged(sender: UISwitch) {
        let offsetType = OffsetType(rawValue: offsetSwitches.indexOf(sender)!)
//        switch OffsetType {
//            case .Red:
//        }
    }
}
