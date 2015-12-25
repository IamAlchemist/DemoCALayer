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
    
    enum Font : Int {
        case Helvetica, NoteworthyLight
    }
    
    enum AlignmentMode : Int {
        case Left, Center, Justified, Right
    }
    
    enum TruncationMode : Int {
        case Start, Middle, End
    }
    
    var noteworthyLightFont : AnyObject?
    var helveticaFont : AnyObject?
    let baseFontSize : CGFloat = 24.0
    let textLayer = CATextLayer()
    var fontSize : CGFloat = 24.0
    var previouslySelectedTruncationMode = TruncationMode.End
    
    // MARK: - IBActions
    
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
    
    // MARK: - lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createFonts()
        
        setupTextLayer()
        
        viewForTextLayer.layer.addSublayer(textLayer)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        textLayer.frame = viewForTextLayer.bounds
        textLayer.fontSize = fontSize
    }
    
    // MARK: - Helpr
    
    func setupTextLayer(){
        
        textLayer.frame = viewForTextLayer.bounds
        
        var string = ""
        for _ in 1...20 {
            string += "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Fusce auctor arcu quis velit congue dictum. "
        }
        
        textLayer.string = string
        textLayer.font = helveticaFont
        textLayer.foregroundColor = UIColor.darkGrayColor().CGColor
        textLayer.wrapped = true
        textLayer.alignmentMode = kCAAlignmentLeft
        textLayer.truncationMode = kCATruncationEnd
        textLayer.contentsScale = UIScreen.mainScreen().scale
    }
    
    func createFonts() {
        var fontName : CFStringRef = "Noteworthy-Light"
        noteworthyLightFont = CTFontCreateWithName(fontName, baseFontSize, nil)
        fontName = "Helvetica"
        helveticaFont = CTFontCreateWithName(fontName, baseFontSize, nil)
    }
}
