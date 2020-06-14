//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Khlood on 5/4/20.
//  Copyright © 2020 Khlood. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    @IBOutlet weak var mySnailButton: UIButton!
    @IBOutlet weak var myChipmunkButton: UIButton!
    @IBOutlet weak var myRabbitButton: UIButton!
    @IBOutlet weak var myVaderButton: UIButton!
    @IBOutlet weak var myEchoButton: UIButton!
    @IBOutlet weak var myReverbButton: UIButton!
    @IBOutlet weak var myStopButton: UIButton!
    
    var recordedAudioURL: URL!
    var audioFile:AVAudioFile!
    var audioEngine:AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum ButtonType: Int {
        case slow = 0, fast, chipmunk, vader, echo, reverb
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        mySnailButton.imageView?.contentMode = .scaleAspectFit
        myChipmunkButton.imageView?.contentMode = .scaleAspectFit
        myRabbitButton.imageView?.contentMode = .scaleAspectFit
        myVaderButton.imageView?.contentMode = .scaleAspectFit
        myEchoButton.imageView?.contentMode = .scaleAspectFit
        myReverbButton.imageView?.contentMode = .scaleAspectFit
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
    @IBAction func playSoundForButton(_ sender: UIButton) {
        switch(ButtonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        configureUI(.playing)
    }
    
    @IBAction func myStopButtonClicked(_ sender: AnyObject) {
        stopAudio()
    }
}
