//
//  ASTProtocol.swift
//  playground
//
//  Created by tree on 2018/11/11.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation

protocol ASTNodeType {
    var token: Token { get }
}

protocol ASTNumNodeType: ASTNodeType {
    var value: Int { get }
}

protocol ASTUnaryNodeType: ASTNodeType {
    var value: ASTNodeType { get }
}

protocol ASTBinaryNodeType: ASTNodeType {
    var leftNode: ASTNodeType { get }
    var rightNode: ASTNodeType { get }
}

class ASTNode: ASTNodeType {
    var token: Token

    var leftNode: ASTNodeType?

    var rightNodel: ASTNodeType?

    init(token: Token) {
        self.token = token
    }
}

class NumNode: ASTNumNodeType {
    var value: Int

    var leftNode: ASTNodeType?

    var rightNodel: ASTNodeType?

    var token: Token
    init(value: Int) {
        self.value = value
        self.token = Token(type: .integer, value: "\(value)")
    }
}

class UnaryNode: ASTUnaryNodeType {
    var value: ASTNodeType

    var token: Token

    var leftNode: ASTNodeType?

    var rightNodel: ASTNodeType?

    init(value: ASTNodeType, token: Token) {
        self.value = value
        self.token = token
    }
}

class BinaryNode: ASTBinaryNodeType {

    var leftNode: ASTNodeType

    var rightNode: ASTNodeType

    var token: Token

    init(op: Token, leftNode: ASTNodeType, rightNode: ASTNodeType) {
        self.leftNode = leftNode
        self.rightNode = rightNode
        self.token = op
    }
}
