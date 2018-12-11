//
//  NlsRealTalkPage.swift
//  ZhiAnXin
//
//  Created by tree on 2018/8/16.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
import SnapKit
import CoreAudio
import AVFoundation
import AVKit
import SxrModuleManager

public protocol PluginRecevicAble {
    func setup(_ params: [String: Any])
}
extension NlsRealTalkPage: PluginRecevicAble {
    func setup(_ params: [String : Any]) {
        self.pluginParams = params
        if let title = params["title"] as? String {
            self.title = title
        }
    }
}
class NlsRealTalkPage: UIViewController {
    var pluginParams: [String : Any] = [:]
    
    var recorder: AVAudioRecorder?
    
    /// 是否在录音
    private(set) var isRecoding = false
    
    var nlsResults = [[String: Any]]()
    
    /// 最近的开始时间，通过此时间区分识别的范围
    var current_beginTime = -1
    
    /// confirmed TextView Content
    var confirmedContent: String = ""
    
    var asrResultTextView: UITextView = {
        let o = UITextView.init()
        o.isScrollEnabled = true
        o.backgroundColor = UIColor.clear
        o.text = ""
        o.font = UIFont.systemFont(ofSize: 17.0)
        return o
    }()
    
    var timeLabel: UILabel = {
        let o = UILabel()
        o.textColor = UIColor.black
        o.font = UIFont.systemFont(ofSize: 19.0)
        return o
    }()
    
    var spectrumView: SpectrumView = {
        let o = SpectrumView.init()
        o.backgroundColor = UIColor.color("#f0f0f0")
        o.layoutSide = .left
        o.lineWidth = 1
        o.lineSpace = 3
        o.middlePadding = -50.0
        o.maxLineCount = 100
        o.lineColor = UIColor.init(red: 45/255.0, green: 45/255.0, blue: 45/255.0, alpha: 1)
        return o
    }()
    
    var startAsrButton: UIButton = {
        let o = UIButton.init()
        o.setImage(UIImage.init(named: "asrBegin"), for: .normal)
        o.setTitleColor(UIColor.black, for: .normal)
        return o
    }()
    
    var stopAsrButton: UIButton = {
        let o = UIButton.init()
        o.setImage(UIImage.init(named: "asrEnd"), for: .normal)
        o.setTitleColor(UIColor.black, for: .normal)
        return o
    }()
    
    //    var timer: DispatchSourceTimer = {
    //        let o = DispatchSource.makeTimerSource(flags: [], queue: DispatchQueue.global())
    //        o.schedule(deadline: .now(), repeating: 1.0)
    //        return o
    //    }()
    /// 定时器，使用上面的timer会崩溃 by treee_
    var timer: Timer?
    
    
    private var recordFilePath: String? = {
        if let documentPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).first {
            let date = Date.init()
            let dformmatter = DateFormatter.init()
            dformmatter.dateFormat = "yyyyMMddhhmmss"
            var s = dformmatter.string(from: date)
            let path = "\(documentPath)/\(s).caf"// 如果需要改变格式，需要改变录音格式
            return path
        }
        return nil
    }()
    
    private var submitQueue: OperationQueue = OperationQueue.init()
    
    private var recordTimeInterval: TimeInterval = 0 {
        willSet {
            self.timeLabel.text = timeConvert(time: max(newValue, 0))
        }
    }
    
    private var backButton: UIButton = {
        let btn = UIButton.init()
        btn.setTitle("返回", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.isUserInteractionEnabled = true
        return btn
    }()
    
    private let rightButton: UIButton = {
        let btn = UIButton.init()
        btn.setTitle("完成", for: .normal)
        btn.setTitleColor(UIColor.black, for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        self.setupUI()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: self.backButton)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: self.rightButton)
        self.backButton.addTarget(self, action: #selector(self.popBack), for: .touchUpInside)
        self.rightButton.addTarget(self, action: #selector(self.submit), for: .touchUpInside)
        self.startAsrButton.addTarget(self, action: #selector(self.startButtonOnClicked), for: .touchUpInside)
        self.stopAsrButton.addTarget(self, action: #selector(self.pausepButtonOnClicked), for: .touchUpInside)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.spectrumView.start()
    }
    
    deinit {
        self.recorder?.stop()
        self.timer?.invalidate()
    }
    //MARK:-
    //MARK:Logistic
    @objc func startButtonOnClicked() -> Void {
        // 将模式设置为录音模式，如果是播放的话，需要在对应逻辑处选择外放模式
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try session.setActive(true)
            session.requestRecordPermission({ [weak self] (allowed) in
                DispatchQueue.main.async {
                    if allowed == false {
                        if ((Double.init(UIApplication.shared.systemVersion) ?? 0.0) > 10.0) {
                            if let url = URL.init(string: UIApplicationOpenSettingsURLString) {
                                if UIApplication.shared.canOpenURL(url) {
                                    UIApplication.shared.openURL(url)
                                }
                            }
                        } else if let url = URL.init(string: "prefs:root=\(UIApplication.shared.bundleIdentifier)") {
                            if UIApplication.shared.canOpenURL(url) {
                                UIApplication.shared.openURL(url)
                            }
                        }
                    }else if allowed == true {
                        self?.startAsrButton.isEnabled = false
                        self?.startAsrButton.isHidden = true
                        self?.stopAsrButton.isEnabled = true
                        self?.stopAsrButton.isHidden = false
                        self?.beginRecord()
                    }
                    return
                }
            })
        } catch _ {
            return
        }
        
    }
    
    func beginRecord() -> Void {
        // 停止其他音频
        try? AVAudioSession.sharedInstance().setActive(true)
        if self.isRecoding == false
            && self.recorder == nil {
            let recordSetting = self.getRecordSetting()
            if let path = self.recordFilePath {
                let filePath = URL.init(fileURLWithPath: path)
                print("\(filePath)")
                FileManager.default.createFile(atPath: path, contents: nil, attributes: nil)
                if let r = try? AVAudioRecorder.init(url: filePath, settings: recordSetting) {
                    // 开启服务
                    r.delegate = self
                    // r.isMeteringEnabled = true // 监控声波
                    self.recorder = r
                    self.recorder?.prepareToRecord()
                    self.isRecoding = true
                }else {
                    print("无法录音")
                }
            }
        }
        if self.recorder != nil { self.recorder?.record() }
        
        if (self.timer == nil) {
            self.timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimeLabel), userInfo: nil, repeats: true)
        }
        self.timer?.fire()
        
        // 注册hook模块
        ModuleManager.shared.register(self, identifier: "\(self)")
        //        self.timer.setEventHandler { [weak self] in
        //            self?.recordTimeInterval = self?.recorder?.currentTime ?? 0.0
        //        }
        //
        //        self.timer.resume()
    }
    @objc func updateTimeLabel() {
        if let path = self.recordFilePath {
            let url = URL.init(fileURLWithPath: path)
            let audioAsset = AVURLAsset.init(url: url, options: nil)
            let time = audioAsset.duration
            let curT = CMTimeGetSeconds(time)
            self.recordTimeInterval = curT
            
        }
    }
    @objc func pausepButtonOnClicked() -> Void {
        self.isRecoding = false
        self.startAsrButton.isEnabled = true
        self.startAsrButton.isHidden = false
        self.stopAsrButton.isEnabled = false
        self.stopAsrButton.isHidden = true
        self.recorder?.pause()
        self.timer?.invalidate()
        self.timer = nil
        return;
    }
    
    @objc func popBack() {
        self.recorder?.stop()
        self.timer?.invalidate()
        
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func submit() {
        // 先上传文件
        self.pausepButtonOnClicked()
        self.popBack()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}


// MARK: - Layout
extension NlsRealTalkPage {
    func setupUI() -> Void {
        self.asrResultTextView.delegate = self
        self.view.addSubview(self.asrResultTextView)
        self.view.addSubview(self.startAsrButton)
        self.view.addSubview(self.stopAsrButton)
        self.view.addSubview(self.spectrumView)
        self.view.addSubview(self.timeLabel)
        
        self.asrResultTextView.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.snp.top).offset(20.0)
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.spectrumView.snp.top)
        }
        
        
        self.startAsrButton.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.height.width.equalTo(70.0)
            make.bottom.equalTo(self.view).offset(-30)
        }
        self.stopAsrButton.snp.makeConstraints { (make) in
            make.edges.equalTo(self.startAsrButton)
        }
        self.stopAsrButton.isEnabled = false
        self.stopAsrButton.isHidden = true
        
        
        self.spectrumView.snp.makeConstraints { (make) in
            make.left.width.equalToSuperview()
            make.bottom.equalTo(self.startAsrButton.snp.top).offset(-30)
            make.height.equalTo(100.0)
        }
        self.timeLabel.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.spectrumView)
            make.right.equalTo(self.spectrumView.snp.right).offset(-20)
        }
        self.timeLabel.text = "00:00:00"
    }
}

// MARK: - GetProperty
extension NlsRealTalkPage {
    func getRecordSetting() -> [String: Any] {
        var recordSetting = [String: Any]()
        // 设置录音格式
        recordSetting[AVFormatIDKey] = NSNumber.init(value: kAudioFormatLinearPCM)
        // 采样率
        recordSetting[AVSampleRateKey] = NSNumber.init(value: 8000.0)
        // 设置通道 这里设置双声道
        recordSetting[AVNumberOfChannelsKey] = NSNumber.init(value: 2)
        // 录音质量
        recordSetting[AVEncoderAudioQualityKey] = NSNumber.init(value: AVAudioQuality.low.rawValue)
        // 采样点位数
        recordSetting[AVLinearPCMBitDepthKey] = NSNumber.init(value: 8)
        return recordSetting
    }
}

extension NlsRealTalkPage: AVAudioRecorderDelegate {
    func audioRecorderEncodeErrorDidOccur(_ recorder: AVAudioRecorder, error: Error?) {
        DLog(error)
        pausepButtonOnClicked()
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        pausepButtonOnClicked()
    }
    
    
}



extension NlsRealTalkPage: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        var should = true
        if self.isRecoding == true {
            should = false
        }
        return should
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        self.confirmedContent = textView.text
    }
}

extension NlsRealTalkPage: HookModuleProtocol {
    func applicationDidEnterBackground(_ application: UIApplication) {
        do {
            if self.isRecoding == true {
                try AVAudioSession.sharedInstance().setCategory(AVAudioSessionCategoryRecord)
                try AVAudioSession.sharedInstance().setActive(true)
            }
        } catch let e {
            DLog("\(e)")
        }
        
//        var bgTask = UIBackgroundTaskInvalid;
//        bgTask = application.beginBackgroundTask(withName: "record") {
//            application.endBackgroundTask(bgTask);
//            bgTask = UIBackgroundTaskInvalid;
//        }
//        DispatchQueue.global().async {
//            self.recorder?.record()
//        }
    }
}
func timeConvert(time: TimeInterval) -> String {
    var o = ""
    let allTime: Int = Int(time)
    var hours = 0
    var minutes = 0
    var seconds = 0
    var hoursText = ""
    var minutesText = ""
    var secondsText = ""
    
    hours = allTime / 3600
    hoursText = hours > 9 ? "\(hours)" : "0\(hours)"
    
    minutes = allTime % 3600 / 60
    minutesText = minutes > 9 ? "\(minutes)" : "0\(minutes)"
    
    seconds = allTime % 3600 % 60
    secondsText = seconds > 9 ? "\(seconds)" : "0\(seconds)"
    if (hoursText.count > 0) {
        o.append("\(hoursText):")
    }
    o.append("\(minutesText):\(secondsText)")
    return o
    
}

public func DLog<T>(_ message:T, file: String = #file, method: String = #function, line: Int = #line) {
    #if DEBUG
        print("\((file as NSString).lastPathComponent), \(method)[\(line)]---> \(message)\n")
    #endif
}
