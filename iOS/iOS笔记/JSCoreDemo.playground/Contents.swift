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
    "1"
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
 @convention 是在swift2.0引入的，用于修饰函数的类型，指出了函数调用的约定，用在一下几个地方：
    1.修饰Swift中的函数类型，调用C函数的时候，可以传入修饰过@convention(c)的函数类型，匹配C函数参数中的函数指针
    2.修饰Swift中的函数类型，调用OC方法的时候，可以传入修饰过@convention(block)的函数类型，匹配OC方法中的block参数
 */
let jsCallNativeMethod: @convention(block) (String) -> Void = {
    (content: String) in
    print("jsCallNativeMethod -> \(content)")
}

let logBlock: @convention(block) () -> () = {
    print("begin log")
    let args = JSContext.currentArguments()
    for jsval in args! {
        print(jsval)
    }
    print("end log")
}
context.setObject(jsCallNativeMethod, forKeyedSubscript: NSString.init(string: "methodName"))
context.setObject(logBlock, forKeyedSubscript: NSString.init(string: "log"))
context.evaluateScript("methodName('\(array)')")

/**
 JSContext & JSExport
 js -> native
 */
@objc protocol HelperExport: JSExport {
    var name: String { get }
    func test() -> String
}

@objc class Helper: NSObject, HelperExport {
    var name: String = "helper name"
    func test() -> String {
        print("oncall text()")
        return "text method"
    }
}
let helper = Helper()
context.setObject(Helper(), forKeyedSubscript: NSString.init(string: "helper"))
context.evaluateScript("log(helper.name)")


