//: Playground - noun: a place where people can play

import UIKit


/**
 命名空间。可以避免像OC那样需要加前缀避免命名冲突
 
 原理就是对原有的类进行一次封装，然后对其进行方法拓展
 */

public final class Sexxar<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol SXRCompatible {
    
    associatedtype CompatibleType
    
    var sxr: CompatibleType { get }
}

public extension SXRCompatible {
    public var sxr: Sexxar<Self> {
        get { return Sexxar(self) }
    }
}

extension Int: SXRCompatible {}
extension String: SXRCompatible {}
extension Float: SXRCompatible {}

extension Sexxar where Base == String {
    func test() {
        print("test: \(self)")
    }
}

3.sxr.base
"tt".sxr.test()
Float(3.34).sxr.base
