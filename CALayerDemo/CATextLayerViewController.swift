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
        let font = Font(rawValue: sender.selectedSegmentIndex)!
        
        switch font {
        case .Helvetica:
            textLayer.font = helveticaFont
        case .NoteworthyLight:
            textLayer.font = noteworthyLightFont
        }
    }
    
    @IBAction func fontSizeChanged(sender: UISlider) {
        fontSizeValueLabel.text = "\(Int(sender.value * 100)) %"
        fontSize = baseFontSize * CGFloat(sender.value)
    }
    
    @IBAction func wrapTextSwitchChanged(sender: UISwitch) {
        alignmentModeSegmentedControl.selectedSegmentIndex = AlignmentMode.Left.rawValue
        textLayer.alignmentMode = kCAAlignmentLeft
        
        if sender.on {
            guard let truncationMode = TruncationMode(rawValue: truncateModeSegementedControl.selectedSegmentIndex)
                else { return }
            
            previouslySelectedTruncationMode = truncationMode
            
            truncateModeSegementedControl.selectedSegmentIndex = UISegmentedControlNoSegment
            textLayer.wrapped = true
        }
        else {
            textLayer.wrapped = false
            truncateModeSegementedControl.selectedSegmentIndex = previouslySelectedTruncationMode.rawValue
        }
    }
    
    @IBAction func aligmentModeChanged(sender: UISegmentedControl) {
        wrapTextSwitch.on = true
        textLayer.wrapped = true
        truncateModeSegementedControl.selectedSegmentIndex = UISegmentedControlNoSegment
        textLayer.truncationMode = kCATruncationNone
        
        switch sender.selectedSegmentIndex {
        case AlignmentMode.Left.rawValue:
            textLayer.alignmentMode = kCAAlignmentLeft
        case AlignmentMode.Center.rawValue:
            textLayer.alignmentMode = kCAAlignmentCenter
        case AlignmentMode.Justified.rawValue:
            textLayer.alignmentMode = kCAAlignmentJustified
        case AlignmentMode.Right.rawValue:
            textLayer.alignmentMode = kCAAlignmentRight
        default:
            textLayer.alignmentMode = kCAAlignmentLeft
        }
    }
    
    @IBAction func truncatModeChanged(sender: UISegmentedControl) {
        wrapTextSwitch.on = false
        textLayer.wrapped = false
        alignmentModeSegmentedControl.selectedSegmentIndex = UISegmentedControlNoSegment
        
        textLayer.alignmentMode = kCAAlignmentLeft
        
        guard let truncateMode = TruncationMode(rawValue: sender.selectedSegmentIndex)
            else { textLayer.truncationMode = kCATruncationNone; return }
        

        switch truncateMode {
        case .Start:
            textLayer.truncationMode = kCATruncationStart
        case .Middle:
            textLayer.truncationMode = kCATruncationMiddle
        case .End:
            textLayer.truncationMode = kCATruncationEnd
        }
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
