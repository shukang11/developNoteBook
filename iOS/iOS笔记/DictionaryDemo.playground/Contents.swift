//: Playground - noun: a place where people can play

import UIKit


var content = "{'name': 'json', 'age': null}";

let data = content.data(using: .utf8)


let json = [
    "name": "json",
    "age": nil,
    "address": "content"
]

if var d = NSSearchPathForDirectoriesInDomains(.documentDirectory, .allDomainsMask, true).first {
    print(d)
    d.append("userInfo.plist")
    if let jsonD = try? JSONSerialization.data(withJSONObject: json, options: []) {
        print("\(jsonD)")
        
        if let j: NSDictionary = try? JSONSerialization.jsonObject(with: jsonD, options: []) as! NSDictionary {
            print("\(j)")
            let md = NSMutableDictionary.init()
            for (k, v) in j {
                print("\(k), \(v)")
                if v is NSNull {
                    print("kong")
                }
            }
            md.write(toFile: d, atomically: true)
            
        }else {
            print("失败")
        }
    }
}else {
    
}

