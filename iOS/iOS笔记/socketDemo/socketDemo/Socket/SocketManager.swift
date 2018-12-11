//
//  SocketManager.swift
//  socketDemo
//
//  Created by tree on 2018/7/10.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
import SocketRocket

public enum DisConnectType: Int {
    case disConnectByServer = 1001
    case disConnectByUser
}

public class SocketManager: NSObject {
    
    public static let `share` = SocketManager()
    
    private var client: SRWebSocket? = nil
    
    private var heartBeat: Timer?
    
    private var reConnectTime: Float = 0.0
    
    private let queue = OperationQueue.init()
    
    private override init() {
        super.init()
        // 初始化连接
        self.initSocket()
    }
}

fileprivate let khost = "127.0.0.1"
fileprivate let kport = 8888

extension SocketManager {
    func connect() {
        self.initSocket()
        reConnectTime = 0.0
    }
    func disConnect() -> Void {
        client?.close(withCode: DisConnectType.disConnectByServer.rawValue, reason: "user disconnect")
        client = nil
    }
    
    func send(msg: String) -> Void {
        client?.open()
        client?.send(msg)
    }
    
    func ping() -> Void {
        client?.sendPing(nil)
    }
}

fileprivate func safeMainAsyncBlock(_ block: @escaping ()->()) {
    if Thread.isMainThread == true {
        block()
    }else {
        let queue = DispatchQueue.main
        queue.async { block() }
    }
}

extension SocketManager {
    func initSocket() -> Void {
        client = SRWebSocket.init(url: URL.init(string: "http://\(khost):\(kport)")!)
        client?.delegate = self
        client?.setDelegateOperationQueue(queue)
        client?.open()
    }
    
    func reConnect() -> Void {
        
    }
    
    func initHeartBeat() -> Void {
        safeMainAsyncBlock { [weak self] in
            self?.destoryHeartBeat()
            if #available(iOS 10.0, *) {
                let t = Timer.scheduledTimer(withTimeInterval: 3*60, repeats: true, block: { (timer) in
                    self?.send(msg: "heart")
                })
                self?.heartBeat = t
            }
            if let h = self?.heartBeat {
                RunLoop.current.add(h, forMode: .commonModes)
            }
        }
    }
    
    func destoryHeartBeat() {
        self.heartBeat?.invalidate()
        self.heartBeat = nil
    }
}

extension SocketManager: SRWebSocketDelegate {
    public func webSocket(_ webSocket: SRWebSocket!, didReceiveMessage message: Any!) {
        print("服务器返回收到消息:\(message)")
    }
    
    public func webSocketDidOpen(_ webSocket: SRWebSocket!) {
        print("连接成功")
        // 成功之后发送心跳包
        self.initHeartBeat()
    }
    
    public func webSocket(_ webSocket: SRWebSocket!, didFailWithError error: Error!) {
        print("连接失败.....\(error.debugDescription)")
        self.reConnect()
    }
    
    public func webSocket(_ webSocket: SRWebSocket!, didReceivePong pongPayload: Data!) {
        print("收到pong回调")
    }
    
    // 连接中断
    public func webSocket(_ webSocket: SRWebSocket!, didCloseWithCode code: Int, reason: String!, wasClean: Bool) {
        if let co = DisConnectType.init(rawValue: code) {
            switch co {
            case .disConnectByServer:
                    self.reConnect()
                break
            case .disConnectByUser:
                    self.disConnect()
                break
            }
        }
        self.destoryHeartBeat()
    }
}
