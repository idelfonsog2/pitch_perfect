//
//  RecordSoundsViewController.swift
//  PitchPerfect
//
//  Created by Idelfonso Gutierrez Jr. on 8/18/16.
//  Copyright © 2016 idelfonso. All rights reserved.
//

import UIKit
import AVFoundation
import LocalAuthentication

class RecordSoundsViewController: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet weak var recordingLabel: UILabel!
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    
    var audioRecorder: AVAudioRecorder!
    
    override func viewWillAppear(animated: Bool) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.enabled = false
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func recordAudio(sender: UIButton) {
        recordingLabel.text = "Recording in progress"
        configureView(true)
        //
        let dirPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        //
        let filePath = NSURL.fileURLWithPathComponents(pathArray)
        print(filePath)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(URL: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.meteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    func configureView(isRecording: Bool) {
        recordingLabel.text = isRecording ? "Recording in progress" : "Tap to record"
        recordButton.enabled = isRecording ? false : true
        stopRecordingButton.enabled = isRecording ? true : false
    }
    
    @IBAction func stopRecording(sender: AnyObject)
    {
        configureView(true)
        recordingLabel.text = "Tap to Record"
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool)
    {
            print("AVAudioRecorded Finish Recording"
        )
            if flag {
                performSegueWithIdentifier("stopRecording", sender: audioRecorder.url)
            }
            else
            {
                print("Saving of recording Failed")
            }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if (segue.identifier == "stopRecording")
        {
            let playSoundsVC = segue.destinationViewController as! PlaySoundsViewController
            let recordedAudioURL = sender as! NSURL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }

}

