//
//  Lexer.swift
//  playground
//
//  Created by tree on 2018/10/25.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation

let regex_int_pattern = "[0-9]"

// 词法分析程序
/// 负责解析命令，并返回下一个Token
class Lexer {
    var content: String
    
    private var index: Int {
        willSet {
            let c = content.count
            if index + 1 > c {
                currentChar = nil
                return
            }
            currentChar = content[newValue]
        }
    }
    
    var currentChar: String? = nil
    
    init(_ content: String) {
        self.content = content
        self.index = 0
        self.currentChar = self.content[self.index]
    }
    
    private func error() -> Void {
        let e = NSException.init(name: NSExceptionName(rawValue: "Lexer invalid"), reason: "error", userInfo: nil)
        e.raise()
    }
    
    private func advance(_ offset: Int = 1) -> Void {
        self.index += offset
    }
    
    private func skipSpace() -> Void {
        while let c = currentChar {
            if c == " " { self.advance() }
        }
    }
    
    private func integer() -> Int {
        var result = ""
        while let c = self.currentChar {
            if self.regex(content: c, pattern: regex_int_pattern) == false { break }
            result = "\(result)\(c)"
            self.advance()
        }
        return Int(result) ?? 0
    }
    
    func get_next_token() -> Token {
        while let c = currentChar {
            if c == " " {
                self.skipSpace()
                continue
            }
            
            if self.regex(content: c, pattern: regex_int_pattern) == true {
                return Token.init(type: .integer, value: "\(self.integer())")
            }else if c == "+" {
                self.advance()
                return Token.init(type: .plus, value: c)
            }else if c == "-" {
                self.advance()
                return Token.init(type: .minus, value: c)
            }else if c == "*" {
                self.advance()
                return Token.init(type: .multiply, value: c)
            }else if c == "/" {
                self.advance()
                return Token.init(type: .divide, value: c)
            }else if c == "(" {
                self.advance()
                return Token.init(type: .leftParent, value: c)
            }else if c == ")" {
                self.advance()
                return Token.init(type: .rightParent, value: c)
            }
            print("\(self.currentChar ?? "no currentChar")")
            self.error()
        }
        return Token.init(type: .eof, value: nil)
    }
}

extension Lexer {
    private func regex(content: String, pattern: String) -> Bool {
        var result = false
        guard let regex = try? NSRegularExpression.init(pattern: pattern, options: .caseInsensitive) else { return result }
        
        let match = regex.matches(in: content, options: [], range: NSRange.init(location: 0, length: 1))
        
        result = match.count > 0
        return result
    }
}

extension String {
    subscript(index: Int) -> String? {
        get {
            if self.count == 0 { return nil }
            let start = self.startIndex
            let begin = self.index(start, offsetBy: index)
            if index > self.count - 1 { return nil }
            return String(self[begin])
        }
    }
}
