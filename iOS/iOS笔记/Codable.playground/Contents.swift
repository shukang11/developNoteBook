//: Playground - noun: a place where people can play

import UIKit

/**
 Codable协议，自定义数据结构，可以在不添加特殊代码的情况下完成序列化
 */

struct Mark {
    var key: String
    var value: String
}

struct Laungage: Codable {
    var name: String
    var version: Int
}

let swift = Laungage.init(name: "Swift", version: 4)
let php = Laungage.init(name: "PHP", version: 7)

let encoder = JSONEncoder()
let decoder = JSONDecoder()

if let encoded = try? encoder.encode(swift) {
    if let json = String.init(data: encoded, encoding: String.Encoding.utf8) {
        print(json)
    }
    if let obj = try? decoder.decode(Laungage.self, from: encoded) {
        print("\(obj.name) and version: \(obj.version)")
    }
}

class People: Codable {
    var name: String
    var age: Int
    var skills: [Laungage] = []
    
//    var mark: Mark = Mark.init(key: "年限", value: "10年")
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

let zhangsan = People.init(name: "zhangsan", age: 13)
zhangsan.skills = [swift, php]

if let encoded = try? encoder.encode(zhangsan) {
    if let json = String.init(data: encoded, encoding: .utf8) {
        print(json)
    }
}


///kvc--> 优化keypath
struct Crew {
    var name: String
    var rank: String
}

struct StarShip {
    var name: String
    var maxWarp: Double
    var captain: Crew
    
    func goToMaxWarp() {
        print("\(name) is now travelling at warp \(maxWarp)")
    }
}

let janeway = Crew.init(name: "Kathryn Janeway", rank: "Captain")
var voyager = StarShip.init(name: "Voyager", maxWarp: 9.975, captain: janeway)
let enterWrap = voyager.goToMaxWarp
enterWrap()// 对方法的引用，会使得方法中的变量与当前环境隔离诶，不信看下面

let nameKeypath = \StarShip.name//对属性的引用，可以获得当前的值
print("\(voyager[keyPath: nameKeypath])")
voyager.name = "changed"
print("\(voyager[keyPath: nameKeypath])")

voyager.goToMaxWarp()
enterWrap()

/// Dictionary changed

let cities = ["shanghai": 24_256_800, "karachi": 23_500_000, "beijing": 21_516_000, "seoul": 9_995_000]
let massiveCities = cities.filter({ $0.value > 10_000_000 })
print(massiveCities["shanghai"])

