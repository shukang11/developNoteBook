//
//  ViewController.swift
//  ShareExtensionDemo
//
//  Created by tree on 2018/6/26.
//  Copyright © 2018年 treee. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    var player: AVPlayer = {
        let o  = AVPlayer.init()
        return o
    }()
    var document: UIDocumentInteractionController = {
        let o = UIDocumentInteractionController.init(url: URL.init(fileURLWithPath: Bundle.main.path(forResource: "20160528 193810.m4a", ofType: nil)!))
        return o
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let button = UIButton.init()
        button.frame = CGRect.init(x: 100.0, y: 100.0, width: 200.0, height: 70.0)
        button.setTitle("分享", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.addTarget(self, action: #selector(self.buttonHandler), for: .touchUpInside)
        self.view.addSubview(button)
        
        let shareDir = FileManager.default.containerURL(forSecurityApplicationGroupIdentifier: "group.audioExtension")
        if let filepath = shareDir?.appendingPathComponent("temp.m4a"),
            let data = try? Data.init(contentsOf: filepath) {
            print("\(data.count)")
            let songItem = AVPlayerItem.init(url: filepath)
            self.player.replaceCurrentItem(with: songItem)
            self.player.play()
        }
        
    }

    @objc func buttonHandler() -> Void {
        document.presentOpenInMenu(from: self.view.bounds, in: self.view, animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

