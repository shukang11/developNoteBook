//
//  PRModels.swift
//  playground
//
//  Created by tree on 2019/2/26.
//  Copyright © 2019 treee. All rights reserved.
//

import UIKit

struct PRUser: Codable, PRDecodable {
    var login: String
    var id: Int
    var node_id: String
    
    static func parse(data: Data) -> PRUser? {
        let decoder = JSONDecoder.init()
        let user = try? decoder.decode(PRUser.self, from: data)
        return user
    }
}
