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

if let encoded = try? encoder.encode(swift) { // to data
    if let json = String.init(data: encoded, encoding: String.Encoding.utf8) {
        print(json)
    }
    if let obj = try? decoder.decode(Laungage.self, from: encoded) {
        print("\(obj.name) and version: \(obj.version)")
    }
}

let o = ["real_name": "名字",
         "age": 13] as [String : Any]
struct UU: Codable {
    var real_name: String
    var age: Int
}
if let d = try? JSONSerialization.data(withJSONObject: o, options: []) {
    let u = try? decoder.decode(UU.self, from: d)
    print("\(u?.real_name)")
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

struct User: Codable {
    var id: String
    
    var isMan: Bool
    
    enum CodingKeys: String, CodingKey {
        case id
        // 如果 key 为 female 映射到 isMan 上
        case isMan = "female"
    }
}

let u = User.init(id: "111", isMan: true)
if let encoded = try? encoder.encode(u) {
    if let json = String.init(data: encoded, encoding: .utf8) {
        print(json)
    }
    
    if let data = "{\"id\":\"111\",\"female\":\"true\"}".data(using: .utf8),
        let obj = try? decoder.decode(User.self, from: data) {
        print("\(obj.isMan)")
    }
}

print("===")


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

if let utf8Data = "严".data(using: .utf8) {
    let d = [UInt8](utf8Data)
    for per in d {
        let perString = String(format: "%2X", per)
        print(perString)
    }
}

enum Flow: Codable {
    case login(String, String)
    case logout
}
extension Flow {
    
    enum CodableKeys: String, CodingKey { case login, logout, name, password }
    
    init(from decoder: Decoder) throws {
        do {
            let values = try decoder.container(keyedBy: CodableKeys.self)
            if let name = try? values.decode(String.self, forKey: .name),
                let password = try? values.decode(String.self, forKey: .password) {
                self  = .login(name, password)
                return
            }
            self = .logout
        }catch {
            throw error
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodableKeys.self)
        switch self {
        case .logout:
            try container.encode("logout", forKey: .logout)
        case let .login(name, password):
            try container.encode(name, forKey: .name)
            try container.encode(password, forKey: .password)
        }
    }
}

struct Model: Codable {
    var flow: Flow
}

let s =
"""
{"flow": {"name": "11", "password": "123456"}}
"""
if let data = s.data(using: .utf8) {
    let decoder = JSONDecoder()
    do {
        let c = try decoder.decode(Model.self, from: data)
        print(c)
    } catch let e {
        print(e)
    }
}
