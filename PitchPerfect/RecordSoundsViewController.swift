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
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        stopRecordingButton.isEnabled = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func recordAudio(_ sender: UIButton) {
        recordingLabel.text = "Recording in progress"
        configureView(true)
        //
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recordedVoice.wav"
        let pathArray = [dirPath, recordingName]
        
       let filePath = NSURL.fileURL(withPathComponents: pathArray)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
        
    }
    
    func configureView(_ isRecording: Bool) {
        recordingLabel.text = isRecording ? "Recording in progress" : "Tap to record"
        recordButton.isEnabled = isRecording ? false : true
        stopRecordingButton.isEnabled = isRecording ? true : false
    }
    
    @IBAction func stopRecording(_ sender: AnyObject)
    {
        configureView(true)
        recordingLabel.text = "Tap to Record"
        
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool)
    {
            print("AVAudioRecorded Finish Recording"
        )
            if flag {
                performSegue(withIdentifier: "stopRecording", sender: audioRecorder.url)
            }
            else
            {
                print("Saving of recording Failed")
            }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if (segue.identifier == "stopRecording")
        {
            let playSoundsVC = segue.destination as! PlaySoundsViewController
            let recordedAudioURL = sender as! URL
            playSoundsVC.recordedAudioURL = recordedAudioURL
        }
    }

}

