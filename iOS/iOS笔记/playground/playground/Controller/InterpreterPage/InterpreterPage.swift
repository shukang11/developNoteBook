//
//  InterpreterPage.swift
//  playground
//
//  Created by tree on 2018/10/25.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation
import SSKitSwift

class InterpreterPage: SYViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.testToken()
//        self.testLexer()
//        self.testParser()
        self.testInterpreter()
    }
    
    func testToken() {
        print("\(Token.init(type: .integer, value: "11"))")
        print("\(Token.init(type: .leftParent, value: "("))")
        print("\(Token.init(type: .rightParent, value: ")"))")
        print("\(Token.init(type: .plus, value: "+"))")
        print("\(Token.init(type: .minus, value: "-"))")
        print("\(Token.init(type: .multiply, value: "*"))")
        print("\(Token.init(type: .divide, value: "/"))")
    }
    
    func testLexer() -> Void {
        let content = "(11+(-2))"
        let lexer = Lexer.init(content)
        var node = lexer.get_next_token()
        while node.type != .eof {
            DLog("\(node)")
            node = lexer.get_next_token()
        }
        print("test lexer over")
    }

    func testParser() -> Void {
        let content = "1+5"
        let lexer = Lexer(content)
        let parse = Parser(lexer)
        let node = parse.parse()
        print(node)
    }

    func testInterpreter() {
        let content = "5"
        let lexer = Lexer(content)
        let parse = Parser(lexer)
        let interpreter = Interpreter(parse: parse)
        let result = interpreter.interpreter()
        print(result)
    }
}
