//
//  AudioFileStreamPage.swift
//  playground
//
//  Created by tree on 2018/10/15.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation


class AudioFileStreamPage: SYViewController {
    var player: KKSimplePlayer {
        if let path = Bundle.main.path(forResource: "testmusic", ofType: "mp3") {
            let o = KKSimplePlayer.init(url: URL.init(fileURLWithPath: path, isDirectory: false))
            return o
        }
        return KKSimplePlayer.init()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        player.play()
    }
}

