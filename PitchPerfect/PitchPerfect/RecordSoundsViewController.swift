//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Khlood on 5/4/20.
//  Copyright © 2020 Khlood. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundsViewController: UIViewController,AVAudioRecorderDelegate {
    
    var audioRecorder: AVAudioRecorder!
    
    @IBOutlet var myStartRecordingButton: UIButton!
    @IBOutlet var myRecordingLabel: UILabel!
    @IBOutlet var myStopRecordingButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myStopRecordingButton.isEnabled = false
    }
    
    @IBAction func myStartRecordingButtonClicked(_ sender: Any) {
        isRecording(sender: true)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSession.Category.playAndRecord, mode: AVAudioSession.Mode.default, options: AVAudioSession.CategoryOptions.defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func myStopRecordingButtonClicked(_ sender: Any) {
        isRecording(sender: false)
        audioRecorder.stop()
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
        performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
        } else {
            print("recording was not successful")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "stopRecording" {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }
    
    func isRecording(sender:Bool) {
        if sender == true {
            myRecordingLabel.text = "Recording in progress"
            myStartRecordingButton.isEnabled = false
            myStopRecordingButton.isEnabled = true
        } else {
            myRecordingLabel.text = "Tap to record"
            myStartRecordingButton.isEnabled = true
            myStopRecordingButton.isEnabled = false
        }
    }
}
