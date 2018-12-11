//
//  NSSecureCoding+Swift.swift
//  playground
//
//  Created by tree on 2018/11/5.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation

extension NSCoder {
    func decodeString(forKey key: String) -> String? {
        return decodeObject(forKey: key) as? String
    }
    
    func decodeData(forKey key: String) -> Data? {
        return decodeObject(of: NSData.self, forKey: key) as Data?
    }
}
