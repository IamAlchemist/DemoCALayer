//
//  CATiledLayerViewController.swift
//  CALayerDemo
//
//  Created by wizard on 12/26/15.
//  Copyright © 2015 Alchemist. All rights reserved.
//

import UIKit

class CATiledLayerViewController : UIViewController, UIScrollViewDelegate {
    
    @IBOutlet weak var viewForTiledLayer: TilingView!
    
    @IBOutlet weak var tileLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet var sliders: [UISlider]!
    
    @IBOutlet var labels: [UILabel]!
    
    enum SliderTypes : Int {
        case fadeDuration, tileSize, levelsOfDetail, detailBias, zoomScale
    }
    
    let scales : [Float] = [20, 200, 5, 4, 20]
    
    var tiledLayer : TiledLayer {
        return viewForTiledLayer.layer as! TiledLayer
    }
    
    // MARK: -
    
    func updateLabel( _ sliderType : SliderTypes) {
        labels[sliderType.rawValue].text = String(format: "%.1f", sliders[sliderType.rawValue].value * scales[sliderType.rawValue])
    }
    
    // MARK: - IBActions
    @IBAction func sliderChanged(_ sender: UISlider) {
        let sliderType = SliderTypes(rawValue: sliders.index(of: sender)!)!
        let value = sender.value * scales[sliderType.rawValue]
        
        updateLabel(sliderType)
        
        switch sliderType {
        case .fadeDuration:
            TiledLayer.setFadeDuration(CFTimeInterval(value))
            tiledLayer.contents = nil
            tiledLayer.setNeedsDisplayIn(tiledLayer.bounds)
            
        case .tileSize:
            let value = Int(value)
            tiledLayer.tileSize = CGSize(width: value, height: value)
            
        case .levelsOfDetail:
            tiledLayer.levelsOfDetail = Int(value)
            NSLog("levelOfDetail : %d, zoomScale : %f", tiledLayer.levelsOfDetail, scrollView.zoomScale)

        case .detailBias:
            tiledLayer.levelsOfDetailBias = Int(value)
            
        case .zoomScale:
            NSLog("sender : %f, %f, %f", sender.value, scales[sliderType.rawValue], value)
            scrollView.zoomScale = CGFloat(value)
        }
    }
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scrollView.contentSize = scrollView.frame.size
    }
    
    deinit {
        TiledLayer.setFadeDuration(CFTimeInterval(0.25))
    }
    
    // MARK: - UIScrollViewDelegate
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return viewForTiledLayer
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        sliders[SliderTypes.zoomScale.rawValue].setValue(Float(scrollView.zoomScale), animated: true)
        NSLog("zoomScale : %f", scrollView.zoomScale)
    }
    
}
