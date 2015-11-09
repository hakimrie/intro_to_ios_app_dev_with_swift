//
//  PlaySoundsViewController.swift
//  Picth Perfect
//
//  Created by hakim on 11/5/15.
//  Copyright © 2015 hakimlabs. All rights reserved.
//

import UIKit
import AVFoundation

class PlaySoundsViewController: UIViewController {
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        audioEngine = AVAudioEngine()
        do{
            print("play sound sini")
            audioPlayer = try AVAudioPlayer(contentsOfURL: receivedAudio.filePathUrl)
            audioPlayer.enableRate = true
            
            try audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl)
        }catch{
            print("error getting audio file")
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func playSlowly(sender: AnyObject) {
        audioPlayer.stop()
        audioPlayer.prepareToPlay()
        audioPlayer.rate = 0.5
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
        print("click play slowly")
        
    }

    @IBAction func playAudoFast(sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.prepareToPlay()
        audioPlayer.rate = 1.5
        audioPlayer.currentTime = 0.0
        audioPlayer.play()
    }
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        print("play chipmunk audio")
        playAudioWithVariablePitch(1000)
    }
    
    @IBAction func playDarthVaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.reset()
        audioEngine.stop()
        
        let pitchPlayer = AVAudioPlayerNode()
        audioEngine.attachNode(pitchPlayer)
        
        let timePitch = AVAudioUnitTimePitch()
        timePitch.pitch = pitch
        audioEngine.attachNode(timePitch)
        
        audioEngine.connect(pitchPlayer, to: timePitch, format: nil)
        audioEngine.connect(timePitch, to: audioEngine.outputNode, format:
            nil)
        pitchPlayer.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        
        do{
            try audioEngine.start()
            pitchPlayer.play()
        }catch{
            print("error playing audio engine")
        }

    }
    
    @IBAction func stop(sender: UIButton) {
        audioPlayer.stop()
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
