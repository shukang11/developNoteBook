//
//  MutilDownloadPage.swift
//  playground
//
//  Created by tree on 2018/9/15.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
import UIKit

class MutilDownloadPage: SYViewController {
    private let images:[String] = [
        "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1537022081053&di=eba965b637255f3c27ec9b9cd2fe3372&imgtype=jpg&src=http%3A%2F%2Fimg1.imgtn.bdimg.com%2Fit%2Fu%3D3068506516%2C540373130%26fm%3D214%26gp%3D0.jpg"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        demo1()
        demo2()
    }
}

extension MutilDownloadPage {
    
    func demo1() -> Void {
        let group = DispatchGroup.init()
        for i in 0...10 {
            group.enter()
            let t = DispatchTime.now() + Double(arc4random()%10)
            let q = (i / 2 == 1) ? DispatchQueue.global() : DispatchQueue.global()
//            let item = DispatchWorkItem.init {
//                print("DispatchWorkItem")
//            }
//            item.cancel()
//            q.asyncAfter(deadline: t, execute: item)
            q.asyncAfter(deadline: t) {
                print("\(Thread.isMainThread ?"in Main": "in global") doing something in \(i)")
                group.leave()
            }
        }
        group.notify(queue: DispatchQueue.main) {
            print("over")
        }
    }
}

extension MutilDownloadPage {
    // nsoeration
    func demo2() -> Void {
        let queue = OperationQueue.init()
        queue.maxConcurrentOperationCount = 2
        
        let op1 = BlockOperation.init {
            DispatchQueue.main.asyncAfter(deadline: .now()+2, execute: {
                print("op1  after 2s")
            })
        }
//        op1.cancel()
        op1.addExecutionBlock {
            print("op1 in block \(Thread.isMainThread)")
        }
        
        op1.completionBlock = {
            print("op1 finish")
        }
        let op2 = BlockOperation.init {
            print("op2 in \(Thread.current.name ?? "")")
        }
        
        op2.addDependency(op1)
        
        queue.addOperation(op1)
        queue.addOperation(op2)
    }
}
