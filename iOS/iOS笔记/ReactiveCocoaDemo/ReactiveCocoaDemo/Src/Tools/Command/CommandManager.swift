//
//  CommandManager.swift
//  pandaMaMa
//
//  Created by tree on 2017/8/15.
//  Copyright © 2017年 tree. All rights reserved.
//

import Foundation

class CommandManager: NSObject {
    
    private var commandQueue: [Command] = []
    
    static let sharedInstance = CommandManager()
    
    private override init() {
        super.init()
    }
    
    func executeCommand(_ cmd: Command, observer: CommandDelegate) -> Void {
        cmd.delegate = observer
        self.commandQueue.append(cmd)
        cmd.execute()
    }
    
    func executeCommand(_ cmd: Command, completeBlock: @escaping CommandCallBackBlock) -> Void {
        cmd.callBackBlock = completeBlock
        self.commandQueue.append(cmd)
        cmd.execute()
    }
    
    func cancelCommand(_ cmd: Command) -> Void {
        cmd.cancel()
        //移除cmd
        guard let index:Int = self.commandQueue.index(of:cmd) else { return }
        self.commandQueue.remove(at: index)
    }
}
