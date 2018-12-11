//
//  ItemDetailViewModel.swift
//  playground
//
//  Created by tree on 2018/6/4.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation

class ItemDetailViewModel: NSObject {
    
   var datas = [LazyItem]()
    
    func request(completion: @escaping (_ error: String?) -> ()) -> Void {
        for _ in 0..<10 {
            self.datas.append(randomData())
        }
        self.datas.append(
            LazyItem(title: "上拉查看图文详情", desc: "", imageURL: "")
        )
        if self.datas.count > 0 {
            completion(nil)
        }
    }
}


