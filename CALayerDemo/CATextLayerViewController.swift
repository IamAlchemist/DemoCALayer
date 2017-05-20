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
        case helvetica, noteworthyLight
    }
    
    enum AlignmentMode : Int {
        case left, center, justified, right
    }
    
    enum TruncationMode : Int {
        case start, middle, end
    }
    
    var noteworthyLightFont : AnyObject?
    var helveticaFont : AnyObject?
    let baseFontSize : CGFloat = 24.0
    let textLayer = CATextLayer()
    var fontSize : CGFloat = 24.0
    var previouslySelectedTruncationMode = TruncationMode.end
    
    // MARK: - IBActions
    
    @IBAction func fontChanged(_ sender: UISegmentedControl) {
        let font = Font(rawValue: sender.selectedSegmentIndex)!
        
        switch font {
        case .helvetica:
            textLayer.font = helveticaFont
        case .noteworthyLight:
            textLayer.font = noteworthyLightFont
        }
    }
    
    @IBAction func fontSizeChanged(_ sender: UISlider) {
        fontSizeValueLabel.text = "\(Int(sender.value * 100)) %"
        fontSize = baseFontSize * CGFloat(sender.value)
    }
    
    @IBAction func wrapTextSwitchChanged(_ sender: UISwitch) {
        alignmentModeSegmentedControl.selectedSegmentIndex = AlignmentMode.left.rawValue
        textLayer.alignmentMode = kCAAlignmentLeft
        
        if sender.isOn {
            guard let truncationMode = TruncationMode(rawValue: truncateModeSegementedControl.selectedSegmentIndex)
                else { return }
            
            previouslySelectedTruncationMode = truncationMode
            
            truncateModeSegementedControl.selectedSegmentIndex = UISegmentedControlNoSegment
            textLayer.isWrapped = true
        }
        else {
            textLayer.isWrapped = false
            truncateModeSegementedControl.selectedSegmentIndex = previouslySelectedTruncationMode.rawValue
        }
    }
    
    @IBAction func aligmentModeChanged(_ sender: UISegmentedControl) {
        wrapTextSwitch.isOn = true
        textLayer.isWrapped = true
        truncateModeSegementedControl.selectedSegmentIndex = UISegmentedControlNoSegment
        textLayer.truncationMode = kCATruncationNone
        
        switch sender.selectedSegmentIndex {
        case AlignmentMode.left.rawValue:
            textLayer.alignmentMode = kCAAlignmentLeft
        case AlignmentMode.center.rawValue:
            textLayer.alignmentMode = kCAAlignmentCenter
        case AlignmentMode.justified.rawValue:
            textLayer.alignmentMode = kCAAlignmentJustified
        case AlignmentMode.right.rawValue:
            textLayer.alignmentMode = kCAAlignmentRight
        default:
            textLayer.alignmentMode = kCAAlignmentLeft
        }
    }
    
    @IBAction func truncatModeChanged(_ sender: UISegmentedControl) {
        wrapTextSwitch.isOn = false
        textLayer.isWrapped = false
        alignmentModeSegmentedControl.selectedSegmentIndex = UISegmentedControlNoSegment
        
        textLayer.alignmentMode = kCAAlignmentLeft
        
        guard let truncateMode = TruncationMode(rawValue: sender.selectedSegmentIndex)
            else { textLayer.truncationMode = kCATruncationNone; return }
        

        switch truncateMode {
        case .start:
            textLayer.truncationMode = kCATruncationStart
        case .middle:
            textLayer.truncationMode = kCATruncationMiddle
        case .end:
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
        
        let text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque massa arcu, eleifend vel varius in, facilisis pulvinar leo. Nunc quis nunc at mauris pharetra condimentum ut ac neque. Nunc elementum, libero ut porttitor dictum, diam odio congue lacus, vel fringilla sapien diam at purus. Etiam suscipit pretium nunc sit amet lobortis";
        
        let string = NSMutableAttributedString(string: text)
        let attrib = [NSForegroundColorAttributeName: UIColor.black,
                      NSFontAttributeName : UIFont.systemFont(ofSize: 15)]
        string.setAttributes(attrib, range: NSRange(location: 0, length: text.characters.count))
        
        let attrib2 = [NSForegroundColorAttributeName: UIColor.red,
                       NSUnderlineStyleAttributeName: NSUnderlineStyle.styleSingle.rawValue,
                       NSFontAttributeName: UIFont.systemFont(ofSize: 20)] as [String : Any]
        string.setAttributes(attrib2, range: NSRange(location: 6, length: 5))
        
        textLayer.string = string
        textLayer.font = helveticaFont
        textLayer.foregroundColor = UIColor.darkGray.cgColor
        textLayer.isWrapped = true
        textLayer.alignmentMode = kCAAlignmentLeft
        textLayer.truncationMode = kCATruncationEnd
        textLayer.contentsScale = UIScreen.main.scale
    }
    
    func createFonts() {
        var fontName : CFString = "Noteworthy-Light" as CFString
        noteworthyLightFont = CTFontCreateWithName(fontName, baseFontSize, nil)
        fontName = "Helvetica" as CFString
        helveticaFont = CTFontCreateWithName(fontName, baseFontSize, nil)
    }
}
