//
//  Interpreter.swift
//  playground
//
//  Created by tree on 2018/10/25.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation

protocol NodeVisitType {

}

// 解释器
class Interpreter: NodeVisitType {
    let parser: Parser

    init(parse: Parser) {
        self.parser = parse
    }

    func visit(node: ASTNodeType) -> Int? {
        
        return .none
    }

    func interpreter() -> Int? {
        let tree = self.parser.parse()
        if tree.token.type == .eof {
            return .none
        }
        return self.visit(node: tree)
    }
}
