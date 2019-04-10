import UIKit

var str = "Tree Demo"

indirect enum BinarySearchTree<Element: Comparable> {
    case leaf
    case node(BinarySearchTree<Element>, Element, BinarySearchTree<Element>)
}

extension BinarySearchTree {
    init() {
        self = .leaf
    }
    
    init(_ value: Element) {
        self = .node(.leaf, value, .leaf)
    }
}

extension BinarySearchTree {
    var count: Int {
        switch self {
        case .leaf:
            return 0
        case .node(let left, _, let right):
            return 1 + left.count + right.count
        }
    }
}

extension BinarySearchTree {
    var element: [Element] {
        switch self {
        case .leaf:
            return []
        case .node(let left, let value, let right):
            return left.element + [value] + right.element
        }
    }
}

extension BinarySearchTree {
    var isEmpty: Bool {
        if case .leaf = self {
            return true
        }
        return false
    }
}

extension BinarySearchTree  where Element: Comparable {
    var isBST: Bool {
        switch self {
        case .leaf:
            return true
        case .node(let left, let value, let right):
            return left.element.allSatisfy{y in y < value}
                && right.element.allSatisfy{y in y > value}
                && left.isBST
                && right.isBST
        }
    }
}

extension BinarySearchTree {
    func contains(value: Element) -> Bool {
        switch self {
        case .leaf:
            return false
        case .node(_, let y, _) where value == y:
            return true
        case .node(let left, let y, _) where value < y:
            return left.contains(value: value)
        case .node(_, let y, let right) where value > y:
            return right.contains(value: value)
        default:
            fatalError("The impossible occurred")
        }
    }
}

extension BinarySearchTree {
    mutating func insert(value: Element) {
        switch self {
        case .leaf:
            self = BinarySearchTree(value)
        case .node(var left, let y, var right):
            if value < y { left.insert(value: value) }
            else { right.insert(value: value) }
            self = .node(left, y, right)
        }
    }
}

var b = BinarySearchTree.init(5)
b.insert(value: 10)
b.insert(value: 2)
b.insert(value: 5)
b.element
b.contains(value: 5)

var cha = BinarySearchTree.init("c")
cha.insert(value: "a")
cha.insert(value: "b")
cha.element
