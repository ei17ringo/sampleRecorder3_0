//
//  ViewController.swift
//  sampleRecorder
//
//  Created by Eriko Ichinohe on 2016/05/26.
//  Copyright © 2016年 Eriko Ichinohe. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let fileManager = FileManager()
    var audioRecorder: AVAudioRecorder?
    var audioPlayer: AVAudioPlayer?
    let fileName = "sample.caf"

    @IBOutlet weak var btnRecord: UIButton!
    
    @IBOutlet weak var btnStopRecord: UIButton!
    
    @IBOutlet weak var btnPlay: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupAudioRecorder()
    }
    
    //録音開始
    @IBAction func tapBtnRecord(_ sender: UIButton) {
        audioRecorder?.record()
    }
   
    //録音停止
    @IBAction func tapBtnStop(_ sender: UIButton) {
        audioRecorder?.stop()
    }
    
    
    
    @IBAction func tapBtnPlay(_ sender: UIButton) {
        play()
    }
    
    // 録音するために必要な設定を行う
    // viewDidLoad時に行う
    func setupAudioRecorder(){
        // 再生と録音機能をアクティブにする
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try! session.setActive(true)
        let recordSetting : [String : AnyObject] = [AVEncoderAudioQualityKey : AVAudioQuality.min.rawValue as AnyObject,
            AVEncoderBitRateKey : 16 as AnyObject,
            AVNumberOfChannelsKey : 2 as AnyObject,
            AVSampleRateKey : 44100.0 as AnyObject
        ]
        
        do{
            try audioRecorder = AVAudioRecorder(url: self.documentFilePath(), settings: recordSetting)
        }catch{
            print("初期設定でのエラー")
        }
    }
    
    // 再生
    func play(){
        do{
            try audioPlayer = AVAudioPlayer(contentsOf: self.documentFilePath())
        }catch{
            print("再生時にエラー")
        }
        audioPlayer?.play()
    
    }
    
    // 録音するファイルのパスを取得（録音時、再生時に参照）
    // swift2からstringByAppendingComponent
    func documentFilePath()->URL {
        let urls = fileManager.urls(for: .documentDirectory, in: .userDomainMask) as [URL]

        
        let dirURL = urls[0]
        return dirURL.appendingPathComponent(fileName)
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

