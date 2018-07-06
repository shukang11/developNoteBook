//: Playground - noun: a place where people can play

import UIKit

// swift 中的Error和OC中的大不相同
enum PrintError: Error {
    case outOfPaper
    case onFire
    case noToner
}

struct SError: Error {
    let domain: String
    let code: Int
    var userInfo: Any?
}

func sxr_send(job: Int, to printerName: String) throws -> String {
    
    if printerName == "n" {
        throw SError.init(domain: "Print.sxr.error", code: 2, userInfo: nil)
    }
    return "Job sent"
}


do {
    let result = try sxr_send(job: 11, to: "n")
    print("\(result)")
}catch let error as SError {
    print("\(error)")
}

class A {
    func test() {
        fatalError("Not impemented yet.")
    }
}

class subA: A {
    
}
