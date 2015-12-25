//
//  CALayerControlsViewController.swift
//  CALayerDemo
//
//  Created by Wizard Li on 12/24/15.
//  Copyright © 2015 Alchemist. All rights reserved.
//

import UIKit

class CALayerControlsViewController : UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate
{

    @IBOutlet weak var contentsGravityPickerValueLabel: UILabel!
    @IBOutlet weak var contentsGravityPicker: UIPickerView!
    @IBOutlet var switches: [UISwitch]!
    @IBOutlet var sliderLabels: [UILabel]!
    @IBOutlet var sliders: [UISlider]!
    @IBOutlet weak var borderColorValueLabel: UILabel!
    @IBOutlet var borderColorSliders: [UISlider]!
    @IBOutlet weak var backgroundColorValueLabel: UILabel!
    @IBOutlet var backgroundColorSliders: [UISlider]!
    @IBOutlet weak var shadowColorValueLabel: UILabel!
    @IBOutlet var shadowColorSliders: [UISlider]!
    @IBOutlet weak var shadowOffsetValueLabel: UILabel!
    @IBOutlet var shadowOffsetSliders: [UISlider]!
    @IBOutlet weak var magnificationFilterSegmentControl: UISegmentedControl!
    
    enum Row : Int {
        case ContentsGravity,
        ContentsGravityPicker,
        DisplayContents,
        GeometryFlipped,
        Hidden,
        Opacity,
        CornerRadius,
        BorderWidth,
        ShadowOpacity,
        ShadowRadius,
        BorderColor,
        BackgroundColor,
        ShadowColor,
        ShadowOffset,
        MagnificationFilter
    }
    
    enum Switch : Int {
        case DisplayContents,
        GeometryFlipped,
        Hidden
    }
    
    enum Slider : Int {
        case Opacity, CornerRadius, BorderWidth, ShadowOpacity, ShadowRadius
    }
    
    enum ColorSlider : Int {
        case Red, Green, Blue
    }
    
    enum MagnificationFilter : Int {
        case Linear, Nearest, Trilinear
    }
    
    weak var layerViewController : CALayerViewController!
    
    var contentsGravityValues = [kCAGravityCenter, kCAGravityTop, kCAGravityBottom, kCAGravityLeft, kCAGravityRight, kCAGravityTopLeft, kCAGravityTopRight, kCAGravityBottomLeft, kCAGravityBottomRight, kCAGravityResize, kCAGravityResizeAspect, kCAGravityResizeAspectFill]
    var contentsGravityPickerVisible = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateSliderValueLabels()
    }
    
    // MARK: - helper
    
    func updateSliderValueLabels(){
        for slider in Slider.Opacity.rawValue...Slider.ShadowOpacity.rawValue {
            updateSliderValueLabel(Slider(rawValue: slider)!)
        }
    }
    
    func updateSliderValueLabel(sliderEnum : Slider){
        let index = sliderEnum.rawValue
        let sliderLabel = sliderLabels[index]
        let slider = sliders[index]
        
        switch sliderEnum {
        case .Opacity, .ShadowOpacity:
            sliderLabel.text = String(format: "%.1f", slider.value)
        case .CornerRadius, .BorderWidth, .ShadowRadius:
            sliderLabel.text = "\(Int(slider.value))"
        }
    }
    
    func relayoutTableViewCells(){
        tableView.beginUpdates()
        tableView.endUpdates()
    }
    
    func showContentsGravityPicker(){
        contentsGravityPickerVisible = true
        relayoutTableViewCells()
        
        let index = contentsGravityValues.indexOf(layerViewController.layer.contentsGravity)
        contentsGravityPicker.selectRow(index!, inComponent: 0, animated: false)
        contentsGravityPicker.hidden = false
        contentsGravityPicker.alpha = 0.0
        
        UIView.animateWithDuration(0.25) {
            self.contentsGravityPicker.alpha = 1.0
        }
    }
    
    func hideContentsGravityPicker(){
        guard contentsGravityPickerVisible else { return }
        
        tableView.userInteractionEnabled = false
        contentsGravityPickerVisible = false
        relayoutTableViewCells()
        
        UIView.animateWithDuration(0.25, animations: {
            self.contentsGravityPicker.alpha = 0.0
        })
        { _ in
            self.contentsGravityPicker.hidden = true
            self.tableView.userInteractionEnabled = true
        }
    }
    
    func colorAndLabelForSliders(sliders: [UISlider]) -> (color: CGColorRef, label: String) {
        let red = CGFloat(sliders[0].value)
        let green = CGFloat(sliders[1].value)
        let blue = CGFloat(sliders[2].value)
        let color = UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0).CGColor
        let label = "RGB: \(Int(red)), \(Int(green)), \(Int(blue))"
        return (color: color, label: label)
    }
    
    // MARK: - IBActions
    
    @IBAction func switchChanged(sender: UISwitch) {
        let theSwitch = Switch(rawValue: (switches as NSArray).indexOfObject(sender))!
        
        switch theSwitch {
        case .DisplayContents:
            layerViewController.layer.contents = sender.on ? layerViewController.star : nil
        case .GeometryFlipped:
            layerViewController.layer.geometryFlipped = sender.on
        case .Hidden:
            layerViewController.layer.hidden = sender.on
        }
    }
    
    @IBAction func sliderChanged(sender: UISlider) {
        let slider = Slider(rawValue: sliders.indexOf(sender)!)!
        
        switch slider {
        case .Opacity:
            layerViewController.layer.opacity = sender.value
        case .CornerRadius:
            layerViewController.layer.cornerRadius = CGFloat(sender.value)
        case .BorderWidth:
            layerViewController.layer.borderWidth = CGFloat(sender.value)
        case .ShadowOpacity:
            layerViewController.layer.shadowOpacity = sender.value
        case .ShadowRadius:
            layerViewController.layer.shadowRadius = CGFloat(sender.value)
        }
        
        updateSliderValueLabel(slider)
    }
    
    @IBAction func borderColorSliderChanged(sender: UISlider) {
        let colorAndLabel = colorAndLabelForSliders(borderColorSliders)
        layerViewController.layer.borderColor = colorAndLabel.color
        borderColorValueLabel.text = colorAndLabel.label
    }
    
    @IBAction func backgroundColorSliderChanged(sender: UISlider) {
        let colorAndLabel = colorAndLabelForSliders(backgroundColorSliders)
        layerViewController.layer.backgroundColor = colorAndLabel.color
        backgroundColorValueLabel.text = colorAndLabel.label
    }
    
    @IBAction func shadowColorSliderChanged(sender: UISlider) {
        let colorAndLabel = colorAndLabelForSliders(shadowColorSliders)
        layerViewController.layer.shadowColor = colorAndLabel.color
        shadowColorValueLabel.text = colorAndLabel.label
    }
    
    @IBAction func shadowOffsetSliderChanged(sender: AnyObject) {
        let width = CGFloat(shadowOffsetSliders[0].value)
        let height = CGFloat(shadowOffsetSliders[1].value)
        layerViewController.layer.shadowOffset = CGSize(width: width, height: height)
        shadowOffsetValueLabel.text = "Width : \(Int(width)), Height : \(Int(height))"
    }

    @IBAction func magnificationFilterSegmentedControlChanged(sender: UISegmentedControl) {
        let filterEnum = MagnificationFilter(rawValue: sender.selectedSegmentIndex)!
        var filter = ""
        
        switch filterEnum {
        case .Linear:
            filter = kCAFilterLinear
        case .Nearest:
            filter = kCAFilterNearest
        case .Trilinear:
            filter = kCAFilterTrilinear
        }
        
        layerViewController.layer.magnificationFilter = filter
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let row = Row(rawValue: indexPath.row)!
        
        if row == .ContentsGravityPicker {
            return contentsGravityPickerVisible ? 160 : 0.0
        }
        else{
            return 44
        }
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let row = Row(rawValue: indexPath.row)!
        
        switch row {
        case .ContentsGravity where !contentsGravityPickerVisible:
            showContentsGravityPicker()
        default:
            hideContentsGravityPicker()
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return contentsGravityValues.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return contentsGravityValues[row]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        layerViewController.layer.contentsGravity = contentsGravityValues[row]
        contentsGravityPickerValueLabel.text = layerViewController.layer.contentsGravity
    }
}






















































































