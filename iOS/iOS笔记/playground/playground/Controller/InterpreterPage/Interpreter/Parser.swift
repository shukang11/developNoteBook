//
//  Parser.swift
//  playground
//
//  Created by tree on 2018/10/26.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation

// 语法分析器， 是语法规则的具体逻辑体现
// 将语法解析成具体的语法树
class Parser {
    var lexer: Lexer
    
    var currentToken: Token
    
    init(_ lexer: Lexer) {
        self.lexer = lexer
        self.currentToken = self.lexer.get_next_token()
    }

    func eat(_ type: TokenType) {
        if self.currentToken.type == type {
            self.currentToken = self.lexer.get_next_token()
        }
    }

    /* factor : (PLUS | MINUS) factor | INTEGER | LPAREN expr RPAREN */
    func factor() -> ASTNodeType {
        let token = self.currentToken
        switch token.type {
        case .plus, .minus:
            self.eat(token.type)
            let node = UnaryNode.init(value: self.factor(), token: token)
            return node
        case .integer:
            self.eat(token.type)
            let node = NumNode(value: Int(token.value!)!)
            return node
        case .leftParent:
            self.eat(token.type)
            let node = self.expr()
            self.eat(.rightParent)
            return node
        default:
            fatalError()
        }
    }
    /* term : factor ((MUL | DIV) factor)* */
    func term() -> ASTNodeType {
        var node = self.factor()

        let tokens: [TokenType] = [.multiply, .divide]
        while tokens.contains(self.currentToken.type) {
            let token = self.currentToken
            self.eat(token.type)
            let leftNode = node
            node = BinaryNode(op: token, leftNode: leftNode, rightNode: self.factor())
        }
        return node
    }

    /**
     expr   : term ((PLUS | MINUS) term)*
     term   : factor ((MUL | DIV) factor)*
     factor : (PLUS | MINUS) factor | INTEGER | LPAREN expr RPAREN
     */
    func expr() -> ASTNodeType {
        var node = self.term()

        let tokens: [TokenType] = [.plus, .minus]
        while tokens.contains(self.currentToken.type) {
            let token = self.currentToken

            self.eat(token.type)

            node = BinaryNode(op: token, leftNode: node, rightNode: self.term())
        }
        return node
    }

    // 解析为ASTNodeType
    func parse() -> ASTNodeType {
        let node = self.expr()

        if self.currentToken.type != .eof {
            fatalError()
        }
        return node
    }
}
