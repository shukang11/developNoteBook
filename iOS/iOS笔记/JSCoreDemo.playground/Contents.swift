//: Playground - noun: a place where people can play

import UIKit
import JavaScriptCore

/// tools
func menoryPos(_ prefix: String="", obj: Any?) {
    print("\(prefix)处的内存地址为:\(Unmanaged<AnyObject>.passUnretained(obj as AnyObject).toOpaque())")
}
let context: JSContext! = JSContext.init()

let jsv = context.evaluateScript(
    "return 1;"
)
// undefined
/// 返回最后一个脚本生成的值， 因为和执行一个js文件无异，我们在浏览器中不会返回最后一个值，返回的只在执行函数的上下文中才有意义，因此简单的 1 就会被返回

let jsv1 = context.evaluateScript(
    "1;"
)
jsv1?.toString
menoryPos("jsv1", obj: jsv1)

let jsv2 = context.evaluateScript(
    "[1,2,3,4,5].map(function(n){return n*n})"
)
jsv2?.toArray()
/// 生成的最后的值是调用map的结果，jsv的值指向这个值

/**
 2.注入本地对象
 */
let array = [1, 2, 3, 4, 5]
context.evaluateScript(
    "\(array).map(function(n){return n*n})"
)
context.setObject(array, forKeyedSubscript: "array" as NSCopying & NSObjectProtocol)
let jsv3 = context.evaluateScript(
    "array.map(function(n){return n*n})"
)
jsv3?.toArray()

/**
 3.检索js对象
 */
context.evaluateScript(
    "array = [8,7,6,5,4,3,2,1];"
)
if let jsv4 = context.objectForKeyedSubscript("array") {
    print(jsv4.toArray())
}


/**
 4.JS调用原生
 */
/**
 @convention(block)
 @convention 是在swift2.0引入的，用于修饰
 */
let jsCallNativeMethod: @convention(block) (String) -> Void = {
    (content: String) in
    print("\(content)")
}
context.setObject(
    unsafeBitCast(jsCallNativeMethod, to: AnyObject.self), forKeyedSubscript: "methodName" as NSCopying & NSObjectProtocol)
context.evaluateScript("methodName('hahaha')")
