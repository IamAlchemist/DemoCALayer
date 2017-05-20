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
        case slowForward, normal, fastForward
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
        let url = Bundle.main.url(forResource: "colorfulStreak", withExtension: "m4v")!
        let player = AVPlayer(url: url)
        player.actionAtItemEnd = .none
        playerLayer.player = player
    }
    
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPlayerLayer()
        
        viewForPlayerLayer.layer.addSublayer(playerLayer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(AVPlayerLayerViewController.playerDidReachEndNotificationHandler(_:)), name: NSNotification.Name(rawValue: "AVPlayerItemDidPlayToEndTimeNotification"), object: player.currentItem)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: -
    
    @IBAction func loopSwitchChanged(_ sender: UISwitch) {
        shouldLoop = sender.isOn
        player.actionAtItemEnd = shouldLoop ? .none : .pause;
    }
    
    @IBAction func playButtonTapped(_ sender: UIButton) {
        play()
    }
    
    @IBAction func rateSegmentedControlChanged(_ sender: UISegmentedControl) {
        var rate : Float!
        
        switch sender.selectedSegmentIndex {
        case Rate.slowForward.rawValue:
            rate = 0.5
        case Rate.fastForward.rawValue:
            rate = 2.0
        default:
            rate = 1.0
        }
        
        player.rate = rate
        isPlaying = true
        rateBeforePause = rate
        updatePlayButtonTitle()
    }
    
    @IBAction func volumeChanged(_ sender: UISlider) {
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
    
    func playerDidReachEndNotificationHandler(_ notification : Notification){
        guard let playerItem = notification.object as? AVPlayerItem
            else { return }
        
        playerItem.seek(to: kCMTimeZero)
        
        if shouldLoop == false {
            player.pause()
            isPlaying = false
            updatePlayButtonTitle()
            updateRateSegmentedControl()
        }
        
    }
    // MARK: -
    
    func updatePlayButtonTitle() {
        if isPlaying {
            playButton.setTitle("Pause", for: UIControlState())
        }
        else {
            playButton.setTitle("Play", for: UIControlState())
        }
    }
    
    func updateRateSegmentedControl() {
        if isPlaying {
            switch player.rate {
            case 0.5:
                rateSegmentedControl.selectedSegmentIndex = Rate.slowForward.rawValue
            case 1.0:
                rateSegmentedControl.selectedSegmentIndex = Rate.normal.rawValue
            case 2.0:
                rateSegmentedControl.selectedSegmentIndex = Rate.fastForward.rawValue
            default:
                break
            }
        }
        else{
            rateSegmentedControl.selectedSegmentIndex = UISegmentedControlNoSegment
        }
    }
}
