import UIKit

var str = "Hello, playground"

/// Map
func map<Element, T>(ins: [Element], transform: (Element) -> T) -> [T] {
    var result = [T]()
    for item in ins {
        result.append(transform(item))
    }
    return result
}

let a = [1,2,3,4,5]
map(ins: a, transform: {"\($0)"})

// Filter
func filter<Element>(ins: [Element], includeElement: (Element) -> Bool) -> [Element] {
    var result = [Element]()
    for x in ins where includeElement(x) {
        result.append(x)
    }
    return result
}
filter(ins: a, includeElement: {$0 < 4})

// Reduce
// give a initial value, and a combine block
func reduce<Element, T>(ins: [Element], initial: T, combine: (T, Element) -> T) -> T {
    var result = initial
    for x in ins {
        result = combine(result, x)
    }
    return result
}
let r = a.reduce(0) { (r, i) -> Int in
    return r + i
}
let r1 = reduce(ins: a, initial: 0, combine: +)
r1 == r

// example

struct City {
    let name: String
    let population: Int
}

let paris = City(name: "paris", population: 2241)
let madrid = City(name: "Madrid", population: 3165)
let amsterdam = City(name: "Amsterdam", population: 827)
let berlin = City(name: "Berlin", population: 3562)

let cities = [paris, madrid, amsterdam, berlin]

extension City {
    func cityByScalingPopulation() -> City {
        return City(name: self.name, population: self.population * 1000)
    }
}

let report = cities.filter({$0.population > 1000})
    .map({$0.cityByScalingPopulation()})
    .reduce("City: Population", {$0 + "\n\($1.name): \($1.population)"})
print(report)


