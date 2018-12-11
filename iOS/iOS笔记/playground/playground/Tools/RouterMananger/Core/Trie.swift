//
//  Trie.swift
//  pandaMaMa
//
//  Created by tree on 2018/2/26.
//  Copyright © 2018年 tree. All rights reserved.
//

import Foundation

// 字典查找树实现
final class Trie<T> {
    private var root: TrieNode<T>
    
    init() {
        root = TrieNode<T>(key: "")
    }
    
    func travese(_ rootNode: TrieNode<T>?=nil ) {
        var rootNode = rootNode
        if rootNode == nil { rootNode = root }
        print("节点值\(rootNode?.key ?? "None")")
        if let children = rootNode?.children {
            for child in children {
                print("\(rootNode?.key ?? "None")下的子节点: \(child.key)")
                travese(child.value)
            }
        }
    }
    
    @discardableResult
    func insert(_ value: T, with url: URL) -> Bool {
        guard let paths = url.pathComponentsWithoutSlash, paths.isEmpty == false else { return false }
        
        var currentNode = root
        for path in paths {
            if let child = currentNode.children[path] {
                currentNode = child
            }else {
                currentNode.addChild(nil, withKey: path)
                currentNode = currentNode.children[path]!
            }
        }
        currentNode.value = value
        return true
    }
    
    func remove(_ node: TrieNode<T>) {
        var currentNodel = node
        while let parent = currentNodel.parent {
            if currentNodel.isLeaf && currentNodel.isTerminationg == false {
                parent.children[currentNodel.key] = nil
            }
            currentNodel = parent
        }
    }
    
    func search(with url: URL) -> TrieNode<T>? {
        guard let paths = url.pathComponentsWithoutSlash, paths.isEmpty == false else { return nil }
        if let node = search(with: paths, rootNode: root) { return node }
        return nil
    }
    
    func search(with paths: [String], rootNode: TrieNode<T>) -> TrieNode<T>? {
        var resultNode: TrieNode<T> = rootNode
        
        if let path = paths.first {
            var childrenPaths = paths
            childrenPaths.removeFirst()
            let children = rootNode.matchedChildren(forKey: path)
            for childNode in children {
                if let node = search(with: childrenPaths, rootNode: childNode) { resultNode = node }
                if (resultNode.depth - rootNode.depth) == paths.count { break }
            }
        }
        if resultNode.isTerminationg {return resultNode }
        return nil
    }
    
    func searchNodeWithMatchPlaceholder(with url: URL) -> TrieNode<T>? {// equel to search node
        guard let paths = url.pathComponentsWithoutSlash, paths.isEmpty == false else { return nil }
        if let node = search(with: paths, rootNode: root), node.depth == paths.count { return node }
        return nil
    }
    
    func searchNodeWithoutMatchPlaceholder(with url: URL) -> TrieNode<T>? {
        guard let paths = url.pathComponentsWithoutSlash, paths.isEmpty == false else { return nil }
        var currentNode = root
        for path in paths {
            if let child = currentNode.children[path] {
                currentNode = child
            }else { return nil }
        }
        if currentNode.isTerminationg { return currentNode }
        return nil
    }
    
    func extractMatchedPattern(from url: URL, resultNode: TrieNode<T>) -> [String: Any] {
        guard let paths = url.pathComponentsWithoutSlash, paths.isEmpty == false else { return [:] }
        
        var params: [String: Any] = [:]
        var nodes: [TrieNode<T>] = []
        var currentNode: TrieNode<T>? = resultNode
        while let node = currentNode, node.parent != nil {
            nodes.append(node)
            currentNode = node.parent
        }
        
        for path in paths {
            if let matchNode = nodes.popLast() {
                if matchNode.isPlaceholder && matchNode.key != path {
                    params[matchNode.placeholder!] = path
                }
            }else { break }
        }
        return params
    }
}


final class TrieNode<T> {
    var key: String
    var value: T?
    var depth: Int = 0
    var children: [String: TrieNode<T>] = [:]
    var parent: TrieNode<T>?
    
    var isTerminationg: Bool { return value != nil }
    
    var isLeaf: Bool { return children.isEmpty }
    
    convenience init(key: String) {
        self.init(key: key, value: nil, depth: 0)
    }
    
    init(key: String, value: T?, depth: Int) {
        self.key = key
        self.value = value
        self.depth = depth
    }
    
    func addChild(_ value: T?, withKey key: String) {
        guard children[key] == nil else { return }
        let node = TrieNode(key: key, value: value, depth: depth + 1)
        node.parent = self
        children[key] = node
    }
}

extension TrieNode {
    var isPlaceholder: Bool {
        return key.hasPrefix(":")
    }
    var placeholder: String? {
        if isPlaceholder {
            return String(key[key.index(key.startIndex, offsetBy: 1)...])
        }
        return nil
    }
    
    func matchedChildren(forKey key: String) -> [TrieNode] {
        var matchedChildren: [TrieNode] = []
        if let child = children[key] {
            matchedChildren.append(child)
        }
        
        if let placeholderChild = children.values.first(where: { $0.isPlaceholder }) {
            matchedChildren.append(placeholderChild)
        }
        return matchedChildren
    }
}

extension URL {
    
    /// the path components without the first slash.
    var pathComponentsWithoutSlash: [String]? {
        var array = self.pathComponents
        if let first = array.first, first == "/" {
            array.removeFirst()
        }
        return array
    }
    
    var queryItems: [URLQueryItem]? {
        return URLComponents(url: self, resolvingAgainstBaseURL: false)?.queryItems
    }
}
