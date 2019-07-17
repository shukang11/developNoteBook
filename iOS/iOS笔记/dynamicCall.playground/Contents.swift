import UIKit

struct RandomNumberGenrator {
    func generate(numberOfZeros: Int) -> Double {
        let maximum = pow(10, Double(numberOfZeros))
        return Double.random(in: 0...maximum)
    }
}

let rand = RandomNumberGenrator()
rand.generate(numberOfZeros: 4)

// 做了注解之后需要实现必要的方法
@dynamicCallable
struct DynamicRandomNumberGenerator {
    /*
     您的密钥不需要符合Hashable.
     您可以使用重复的键添加项。(不会覆盖自定中添加的值)
     添加项的顺序将保留。(是DictionAry变有序)

     */
    func dynamicallyCall(withKeywordArguments kargs: KeyValuePairs<String, Int>) -> Double {
        for pair in kargs {
            if pair.key == "numberOfZeroes" {
                let numberOfZeros = Double(pair.value)
                let maximum = pow(10, numberOfZeros)
                return Double.random(in: 0...maximum)
            }
        }
        return 0
    }
    func dynamicallyCall(withArguments args: [Int]) -> Double {
        if let random = args.randomElement() {
            return Double(random)
        }
        return 0
    }
}

let random = DynamicRandomNumberGenerator()
random(numberOfZeroes: 2)

@dynamicMemberLookup
struct Member {
    var pool: [String: Any] = [:]
    
    subscript (dynamicMember member: String) -> String {
        return self.pool[member, default: ""] as! String
    }
    
    subscript (dynamicMember member: String) -> Int {
        return self.pool[member, default: 0] as! Int
    }
}

let member = Member(pool: ["name": "jack", "age": 12])
let name: String = member.name
let age: Int = member.age
print("\(name), \(age)")


// 官方实例
@dynamicMemberLookup
enum JSON {
    case intValue(Int)
    case stringValue(String)
    case arrayValue(Array<JSON>)
    case dictionaryValue(Dictionary<String, JSON>)
    
    var stringValue: String? {
        if case .stringValue(let str) = self {
            return str
        }
        return nil
    }
    
    var intValue: Int? {
        if case .intValue(let int) = self {
            return int
        }
        return nil
    }
    
    subscript(dynamicMember member: String) -> JSON? {
        if case .dictionaryValue(let dict) = self {
            return dict[member]
        }
        return nil
    }
    
    subscript(key: String) -> JSON? {
        if case .dictionaryValue(let dict) = self {
            return dict[key]
        }
        return nil
    }
    
    subscript(index: Int) -> JSON? {
        if case .arrayValue(let array) = self {
            return index < array.count ? array[index] : nil
        }
        return nil
    }
}

let json = JSON.stringValue("Example")
json[0]?["name"]?.stringValue
