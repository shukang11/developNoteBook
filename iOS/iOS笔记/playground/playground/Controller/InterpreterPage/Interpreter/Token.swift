//
//  Token.swift
//  playground
//
//  Created by tree on 2018/10/25.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation

enum TokenType {
    case integer
    
    case plus
    
    case minus
    
    case multiply
    
    case divide
    
    case leftParent
    
    case rightParent
    
    case eof
    
    var identifier: String { return "\(self)" }
}

/// the Token
/**
 struct 的实例方法 不可以修改属性值 如果需要修改，需要修饰mutating
 */
struct Token {
    var type: TokenType
    
    var value: String?
    
    init(type: TokenType, value: String? = nil) {
        self.type = type
        if value == nil { self.type = .eof }
        self.value = value
    }
    
}

extension Token: CustomStringConvertible {
    var description: String {
        return "Token('\(type.identifier)', '\(value ?? "")')"
    }
}

