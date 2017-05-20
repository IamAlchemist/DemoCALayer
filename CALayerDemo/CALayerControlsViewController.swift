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
        case contentsGravity,
        contentsGravityPicker,
        displayContents,
        geometryFlipped,
        hidden,
        opacity,
        cornerRadius,
        borderWidth,
        shadowOpacity,
        shadowRadius,
        borderColor,
        backgroundColor,
        shadowColor,
        shadowOffset,
        magnificationFilter
    }
    
    enum Switch : Int {
        case displayContents,
        geometryFlipped,
        hidden
    }
    
    enum Slider : Int {
        case opacity, cornerRadius, borderWidth, shadowOpacity, shadowRadius
    }
    
    enum ColorSlider : Int {
        case red, green, blue
    }
    
    enum MagnificationFilter : Int {
        case linear, nearest, trilinear
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
        for slider in Slider.opacity.rawValue...Slider.shadowOpacity.rawValue {
            updateSliderValueLabel(Slider(rawValue: slider)!)
        }
    }
    
    func updateSliderValueLabel(_ sliderEnum : Slider){
        let index = sliderEnum.rawValue
        let sliderLabel = sliderLabels[index]
        let slider = sliders[index]
        
        switch sliderEnum {
        case .opacity, .shadowOpacity:
            sliderLabel.text = String(format: "%.1f", slider.value)
        case .cornerRadius, .borderWidth, .shadowRadius:
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
        
        let index = contentsGravityValues.index(of: layerViewController.layer.contentsGravity)
        contentsGravityPicker.selectRow(index!, inComponent: 0, animated: false)
        contentsGravityPicker.isHidden = false
        contentsGravityPicker.alpha = 0.0
        
        UIView.animate(withDuration: 0.25, animations: {
            self.contentsGravityPicker.alpha = 1.0
        }) 
    }
    
    func hideContentsGravityPicker(){
        guard contentsGravityPickerVisible else { return }
        
        tableView.isUserInteractionEnabled = false
        contentsGravityPickerVisible = false
        relayoutTableViewCells()
        
        UIView.animate(withDuration: 0.25, animations: {
            self.contentsGravityPicker.alpha = 0.0
        }, completion: { _ in
            self.contentsGravityPicker.isHidden = true
            self.tableView.isUserInteractionEnabled = true
        })
        
    }
    
    func colorAndLabelForSliders(_ sliders: [UISlider]) -> (color: CGColor, label: String) {
        let red = CGFloat(sliders[0].value)
        let green = CGFloat(sliders[1].value)
        let blue = CGFloat(sliders[2].value)
        let color = UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0).cgColor
        let label = "RGB: \(Int(red)), \(Int(green)), \(Int(blue))"
        return (color: color, label: label)
    }
    
    // MARK: - IBActions
    
    @IBAction func switchChanged(_ sender: UISwitch) {
        let theSwitch = Switch(rawValue: (switches as NSArray).index(of: sender))!
        
        switch theSwitch {
        case .displayContents:
            layerViewController.layer.contents = sender.isOn ? layerViewController.star : nil
        case .geometryFlipped:
            layerViewController.layer.isGeometryFlipped = sender.isOn
        case .hidden:
            layerViewController.layer.isHidden = sender.isOn
        }
    }
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        let slider = Slider(rawValue: sliders.index(of: sender)!)!
        
        switch slider {
        case .opacity:
            layerViewController.layer.opacity = sender.value
        case .cornerRadius:
            layerViewController.layer.cornerRadius = CGFloat(sender.value)
        case .borderWidth:
            layerViewController.layer.borderWidth = CGFloat(sender.value)
        case .shadowOpacity:
            layerViewController.layer.shadowOpacity = sender.value
        case .shadowRadius:
            layerViewController.layer.shadowRadius = CGFloat(sender.value)
        }
        
        updateSliderValueLabel(slider)
    }
    
    @IBAction func borderColorSliderChanged(_ sender: UISlider) {
        let colorAndLabel = colorAndLabelForSliders(borderColorSliders)
        layerViewController.layer.borderColor = colorAndLabel.color
        borderColorValueLabel.text = colorAndLabel.label
    }
    
    @IBAction func backgroundColorSliderChanged(_ sender: UISlider) {
        let colorAndLabel = colorAndLabelForSliders(backgroundColorSliders)
        layerViewController.layer.backgroundColor = colorAndLabel.color
        backgroundColorValueLabel.text = colorAndLabel.label
    }
    
    @IBAction func shadowColorSliderChanged(_ sender: UISlider) {
        let colorAndLabel = colorAndLabelForSliders(shadowColorSliders)
        layerViewController.layer.shadowColor = colorAndLabel.color
        shadowColorValueLabel.text = colorAndLabel.label
    }
    
    @IBAction func shadowOffsetSliderChanged(_ sender: AnyObject) {
        let width = CGFloat(shadowOffsetSliders[0].value)
        let height = CGFloat(shadowOffsetSliders[1].value)
        layerViewController.layer.shadowOffset = CGSize(width: width, height: height)
        shadowOffsetValueLabel.text = "Width : \(Int(width)), Height : \(Int(height))"
    }

    @IBAction func magnificationFilterSegmentedControlChanged(_ sender: UISegmentedControl) {
        let filterEnum = MagnificationFilter(rawValue: sender.selectedSegmentIndex)!
        var filter = ""
        
        switch filterEnum {
        case .linear:
            filter = kCAFilterLinear
        case .nearest:
            filter = kCAFilterNearest
        case .trilinear:
            filter = kCAFilterTrilinear
        }
        
        layerViewController.layer.magnificationFilter = filter
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let row = Row(rawValue: indexPath.row)!
        
        if row == .contentsGravityPicker {
            return contentsGravityPickerVisible ? 160 : 0.0
        }
        else{
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = Row(rawValue: indexPath.row)!
        
        switch row {
        case .contentsGravity where !contentsGravityPickerVisible:
            showContentsGravityPicker()
        default:
            hideContentsGravityPicker()
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return contentsGravityValues.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return contentsGravityValues[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        layerViewController.layer.contentsGravity = contentsGravityValues[row]
        contentsGravityPickerValueLabel.text = layerViewController.layer.contentsGravity
    }
}






















































































