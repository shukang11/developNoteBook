import UIKit

var str = "Hello, playground"

struct CountDownGenerator<Element: Hashable> {
    
    var element: [Element]
    
    init(array: [Element]) {
        self.element = array.reversed()
    }
    
    mutating func next() -> Element? {
        return self.element.popLast()
    }
    
    mutating func findPower(predicate: (Element) -> Bool) -> Element? {
        while let x = next() {
            if predicate(x) { return x }
        }
        return nil
    }
}

let xs = ["A", "B", "C"]
var generator = CountDownGenerator.init(array: xs)
//generator.next()
//generator.next()
//generator.next()
//generator.next()

let x = generator.findPower(predicate: {$0 > "B"})
x
