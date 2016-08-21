//
//  PlaySoundsViewController.swift
//  PitchPerfect
//
//  Created by Idelfonso Gutierrez Jr. on 8/18/16.
//  Copyright © 2016 idelfonso. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    
    
    @IBOutlet weak var snailButton:UIButton!
    @IBOutlet weak var chipmunkButton:UIButton!
    @IBOutlet weak var rabbitButton:UIButton!
    @IBOutlet weak var vaderButton:UIButton!
    @IBOutlet weak var echoButton:UIButton!
    @IBOutlet weak var reverbButton:UIButton!
    @IBOutlet weak var stopButton:UIButton!
    
    var recordedAudioURL: NSURL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode : AVAudioPlayerNode!
    var stopTimer: NSTimer!
    var pick: Bool!
    
    let miTexto = "pressureVC activate"
    
    enum ButtonType: Int {
        case Slow = 0, Fast, Chipmunk, Vader, Reverb, Echo
    }
    
    @IBAction func playSoundForButton(sender: UIButton)
    {
        print("Play Sound button pressed")
        switch (ButtonType(rawValue: sender.tag)!) {
        case .Slow:
            playSound(rate: 0.5)
        case .Fast:
            playSound(rate: 1.5)
        case .Chipmunk:
            playSound(pitch: 1000)
        case .Vader:
            playSound(pitch: -1000)
        case .Echo:
            playSound(echo: true)
        case .Reverb:
            playSound(reverb: true)
        }
        
        configureUI(.Playing)
    }
    
    @IBAction func stopButtonPressed(sender: UIButton)
    {
        print("stop button pressed")
        stopAudio()
        self.performSegueWithIdentifier("stopPlaySound", sender: miTexto)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "stopPlaySound") {
            let pressureVC = segue.destinationViewController as! PressureViewController
            pressureVC.myLabel.text = miTexto
        } else
        {
            print("text not transfer to PVC")
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print("PlaySoundsVC loaded")
        setupAudio()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        configureUI(.NotPlaying)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
