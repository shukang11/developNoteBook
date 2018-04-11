//: Playground - noun: a place where people can play

import UIKit


/**
 @convention 用来指出函数调用的约定
 */

///  Swift 中调用包含函数指针参数的 C 函数
/**
     CGFloat myCFunction(CGFloat (callback)(CGFloat x, CGFloat y)) {
     return callback(1.1, 2.2);
     }
     let swiftCallback : @convention(c) (CGFloat, CGFloat) -> CGFloat = {
     (x, y) -> CGFloat in
     return x + y
     }
     let result = myCFunction( swiftCallback )
     print(result) // 3.3
 */

///  Swift 中调用包含 block 参数的 Objective-C 方法
/**
     UIView.animateWithDuration(2, animations: {
        NSLog("start")
     }, completion: { (Bool completion) in
        NSLog("completion")
     })
 
     let animationsBlock : @convention(block) () -> () = {
        NSLog("start")
     }
     let completionBlock : @convention(block) (Bool) -> () = { (Bool completion) in
        NSLog("start")
     }
     UIView.animateWithDuration(2, animations: animationsBlock, completion: completionBlock)
 */


/// associatedtype  
protocol AProtocol {
    associatedtype T
    func say()
}

class A: AProtocol {
    typealias T = Int
    func say() {
        print("asdfasd")
    }
}

let clazz = NSClassFromString("KeyWordsDemo.A")
print("\(clazz)")

