//: Playground - noun: a place where people can play

import UIKit

/**
 枚举类型， 在swift中，枚举类型十分灵活
 */
// 如果没有声明(显式或隐式)那么没有rawValue属性
enum CharE: Int {
    case A
    case B
}

let ce = CharE.B
print("\(ce.rawValue)")

enum PeoE: String {
    case man = "man"
    case women = "women"
}

let pe = PeoE.man
print("\(pe.rawValue)")

// 同时枚举中也可以定义方法
enum WorkerE: String {
    case a = "aT"
    case b = "bT"
    case c = "cT"
    
    func work() -> Void {
        print("\(self.rawValue) is working!!")
    }
    
}
let we = WorkerE.a
we.work()

// 可以方便的实现工厂模式

protocol DemoAble {
    func buildADemo() -> Void
}

class JavaDemo: DemoAble {
    func buildADemo() {
        print("Java Demo")
    }
}

class SwiftDemo: DemoAble {
    func buildADemo() {
        print("Swift Demo")
    }
}

class ObjcDemo: DemoAble {
    func buildADemo() {
        print("ObjC Demo")
    }
}

class PythonDemo: DemoAble {
    func buildADemo() {
        print("Python Demo")
    }
}


enum Launguage: String {
    case java
    case swift
    case objectC
    case python
    
    static func createDemo(with laung: Launguage) -> DemoAble {
        switch laung {
        case .java:
            return JavaDemo()
        case .objectC:
            return ObjcDemo()
        case .swift:
            return SwiftDemo()
        case .python:
            return PythonDemo()
        }
    }
}
let le = Launguage.python
print(le.rawValue)

let builder = Launguage.createDemo(with: le)
builder.buildADemo()

// 同构
enum Add<T, U> {
    case inLeft(T)
    case inRight(U)
}

let _ = Add<Int, String>.inLeft(10)


