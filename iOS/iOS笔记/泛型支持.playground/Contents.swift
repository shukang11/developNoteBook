//: Playground - noun: a place where people can play

import UIKit

/**
 泛型支持
 */

func sxr_repeat<T>(item: T, times: Int) -> [T] {
    var result = [T]()
    for _ in 0..<times {
        result.append(item)
    }
    return result
}

let r = sxr_repeat(item: "knock", times: 3)
print(r)

func sum(_ nums: [Int]) -> Int {
    return nums.reduce(0, +)
}
let r2 = sum([1,3,3,5])
print(r2)


/// ===========
protocol WorkAble {
    func canWrite() -> Bool
    
    func write() -> Void
    
    func canRun() -> Bool
    
    func run() -> Void
}

class SportMan: NSObject, WorkAble {
    func canWrite() -> Bool { return false }
    
    func write() { if canWrite() == true {} }
    
    func canRun() -> Bool { return true }
    
    func run() {
        if canRun() == true {
            print("\(self) run a run")
        }
    }
    override var description: String {
        return "sport Man"
    }
}

func work<T: WorkAble>(worker: T) {
    if worker.canRun() == true {
            worker.run()
    }
    if worker.canWrite() == true { worker.write() }
}

extension UIView: WorkAble {
    func canWrite() -> Bool { return false }
    
    func write() { if canWrite() == true {} }
    
    func canRun() -> Bool { return true }
    
    func run() {
        if canRun() == true {
            print("\(self) run a run")
        }
    }
}

let s = SportMan.init()
work(worker: s)

let v = UIView.init()
work(worker: v)


func map<Elements, T>(ins: [Elements], transform: (Elements) -> T) -> [T] {
    var result = [T]()
    for i in ins {
        result.append(transform(i))
    }
    return result
}

let mapParams = [1, 2, 3, 5]
let newParams = map(ins: mapParams) { (i) -> String in
    return "\(i)"
}
mapParams.map { (i) -> String in
    return "\(i)"
}
