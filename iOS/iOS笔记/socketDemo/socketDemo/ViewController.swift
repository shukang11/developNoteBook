//
//  ViewController.swift
//  socketDemo
//
//  Created by tree on 2018/7/10.
//  Copyright © 2018年 treee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var chatFiled: UITextField!
    @IBAction func sendMessage(_ sender: UIButton) {
        if let content = self.chatFiled.text {
            SocketManager.share.send(msg: content)
            self.chatFiled.text = ""
        }
    }
    @IBAction func connect(_ sender: UIButton) {
        SocketManager.share.connect()
    }
    @IBAction func disconnect(_ sender: UIButton) {
        SocketManager.share.disConnect()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

