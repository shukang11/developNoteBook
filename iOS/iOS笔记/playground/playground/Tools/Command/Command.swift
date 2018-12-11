//
//  Command.swift
//  pandaMaMa
//
//  Created by tree on 2017/8/15.
//  Copyright © 2017年 tree. All rights reserved.
//

import Foundation

typealias CommandCallBackBlock = (_ cmd: CommandType) -> Void

protocol CommandType {
    var userInfo:[String: Any] {get set}
    
    var delegate: CommandDelegate? {get set}
    
    var callBackBlock: CommandCallBackBlock? {get set}
    
    func execute() -> Void
    
    func cancel() -> Void
    
    func done() -> Void
}

protocol CommandDelegate {
    func commandDidFinish(_ cmd: CommandType) -> Void
    
    func commandDidFailed(_ cmd: CommandType) -> Void
}


class Command: NSObject, CommandType {
    
    var userInfo: [String : Any] = [:]

    var delegate: CommandDelegate?

    var callBackBlock: CommandCallBackBlock?

    class func command() -> Command {
        return Command.init()
    }
    override init() {}
    
    func execute() {}
    
    func cancel() {
        self.delegate = nil
        self.callBackBlock = nil
    }
    func done() {
        DispatchQueue.main.async {
            self.delegate?.commandDidFinish(self)
            self.callBackBlock?(self)
            self.callBackBlock = nil
            CommandManager.sharedInstance.cancelCommand(self)
        }
    }
    deinit {
        self.cancel()
    }
}
