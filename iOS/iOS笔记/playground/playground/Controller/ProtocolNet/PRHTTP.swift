//
//  PRHTTP.swift
//  playground
//
//  Created by tree on 2019/2/26.
//  Copyright © 2019 treee. All rights reserved.
//

import UIKit

enum PRMethod: String {
    case GET
    case POST
}

protocol PRRequest {
    
    var path: String { get }
    
    var method: PRMethod { get }
    var paramter: [String: Any] { get }
    
    associatedtype PRResponse: PRDecodable
//    func parse(data: Data) -> PRResponse?
}

protocol Client {
    var host: String { get }
    
    func send<T: PRRequest>(_ r: T, handler: @escaping ((T.PRResponse?) -> Void))
    
}

protocol PRDecodable {
    static func parse(data: Data) -> Self?
}

struct PRUserRequest: PRRequest {
    
    typealias PRResponse = PRUser
    
    let name: String
    
    var path: String {
        return "/users/\(name)"
    }
    
    var method: PRMethod = .GET
    
    var paramter: [String : Any] = [:]
    
    init(name: String) {
        self.name = name
    }
    
}

func guardSharedProperty<T>(_ input: T?) -> T {
    guard let shared = input else {
        Log.fatalError("Use \(T.self) before setup. " +
            "Please call `LoginManager.setup` before you do any other things in LineSDK.")
    }
    return shared
}
