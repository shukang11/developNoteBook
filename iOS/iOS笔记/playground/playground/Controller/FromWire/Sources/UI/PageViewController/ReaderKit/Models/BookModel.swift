//
//  BookModel.swift
//  playground
//
//  Created by tree on 2018/12/11.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation

class BookModel {

    var content: String

    var resource: URL

    var chapters: [String] = []

    init(_ content: String, url: URL) {
        self.content = content
        self.resource = url

        // txt 章节通过正则表达式分割
        ReadKitUtil.seperateChapters(&chapters, content: content)
    }


}
