//
//  SocketUnit.swift
//  socketDemo
//
//  Created by tree on 2018/7/10.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
import SocketRocket

class SocketUnit: SRWebSocket {
    override init!(urlRequest request: URLRequest!) {
        super.init(urlRequest: request)
    }
    
    override func open() {
        super.open()
        
    }
}
