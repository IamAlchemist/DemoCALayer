//
//  AVPlayerLayerViewController.swift
//  CALayerDemo
//
//  Created by Wizard Li on 12/25/15.
//  Copyright © 2015 Alchemist. All rights reserved.
//

import UIKit
import AVFoundation

class AVPlayerLayerViewController : UIViewController {
    
    @IBOutlet weak var loopSwitch: UISwitch!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var rateSegmentedControl: UISegmentedControl!
    @IBOutlet weak var viewForPlayerLayer: UIView!
    @IBOutlet weak var volumnSlider: UISlider!
    
    enum Rate : Int {
        case SlowForward, Normal, FastForward
    }
    
    let playerLayer = AVPlayerLayer()
    var player : AVPlayer {
        return playerLayer.player!
    }
    
    var rateBeforePause : Float?
    var shouldLoop = true
    var isPlaying = false
    
    // MARK: -
    
    func setupPlayerLayer(){
        playerLayer.frame = viewForPlayerLayer.frame
        let url = NSBundle.mainBundle().URLForResource("colorfulStreak", withExtension: "m4v")!
        let player = AVPlayer(URL: url)
        player.actionAtItemEnd = .None
        playerLayer.player = player
    }
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPlayerLayer()
        
        viewForPlayerLayer.layer.addSublayer(playerLayer)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "playerDidReachEndNotificationHandler:", name: "AVPlayerItemDidPlayToEndTimeNotification", object: player.currentItem)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // MARK: -
    
    @IBAction func loopSwitchChanged(sender: UISwitch) {
        shouldLoop = sender.on
        player.actionAtItemEnd = shouldLoop ? .None : .Pause;
    }
    
    @IBAction func playButtonTapped(sender: UIButton) {
        play()
    }
    
    @IBAction func rateSegmentedControlChanged(sender: UISegmentedControl) {
        var rate : Float!
        
        switch sender.selectedSegmentIndex {
        case Rate.SlowForward.rawValue:
            rate = 0.5
        case Rate.FastForward.rawValue:
            rate = 2.0
        default:
            rate = 1.0
        }
        
        player.rate = rate
        isPlaying = true
        rateBeforePause = rate
        updatePlayButtonTitle()
    }
    
    @IBAction func volumeChanged(sender: UISlider) {
        player.volume = sender.value
    }
    
    // MARK: -
    
    func play() {
        if playButton.titleLabel?.text == "Play" {
            if let resumeRate = rateBeforePause {
                player.rate = resumeRate
            }
            else {
                player.play()
            }
            
            isPlaying = true
        }
        else {
            rateBeforePause = player.rate
            player.pause()
            isPlaying = false
        }
        
        updatePlayButtonTitle()
        updateRateSegmentedControl()
    }
    
    // MARK: -
    
    func updatePlayButtonTitle() {
        if isPlaying {
            playButton.setTitle("Pause", forState: .Normal)
        }
        else {
            playButton.setTitle("Play", forState: .Normal)
        }
    }
    
    func updateRateSegmentedControl() {
        if isPlaying {
            switch player.rate {
            case 0.5:
                rateSegmentedControl.selectedSegmentIndex = Rate.SlowForward.rawValue
            case 1.0:
                rateSegmentedControl.selectedSegmentIndex = Rate.Normal.rawValue
            case 2.0:
                rateSegmentedControl.selectedSegmentIndex = Rate.FastForward.rawValue
            default:
                break
            }
        }
        else{
            rateSegmentedControl.selectedSegmentIndex = UISegmentedControlNoSegment
        }
    }
}
