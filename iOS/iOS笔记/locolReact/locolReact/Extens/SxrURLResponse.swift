//
//  SxrURLResponse.swift
//  locolReact
//
//  Created by tree on 2018/5/21.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
public extension HTTPURLResponse {
    class func sxr_response(url: URL, statusCode: Int, headerFields: [String: String], noAcessControl: Bool) -> HTTPURLResponse? {
        if noAcessControl == false {
            return HTTPURLResponse.init(url: url, statusCode: statusCode, httpVersion: "HTTP/1.1", headerFields: headerFields)
        }
        var hdFields = headerFields
        hdFields.updateValue("*", forKey: "Access-Control-Allow-Origin")
        hdFields.updateValue("Origin, X-Requested-With, Content-Type", forKey: "Access-Control-Allow-Headers")
        return HTTPURLResponse.init(url: url, statusCode: statusCode, httpVersion: "http/1.1", headerFields: hdFields)
    }
}
