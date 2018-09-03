//
//  CompletePage.swift
//  ReactiveCocoaDemo
//
//  Created by tree on 2018/8/27.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa
class CompletePage: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        /**
         Completable 是 Observable 的另外一个版本。不像 Observable 可以发出多个元素，它要么只能产生一个 completed 事件，要么产生一个 error 事件。
         
         */
        judgeScore(69.0).subscribe(onCompleted: {
            print("通过")
        }) { (error) in
            print("\(error)")
        }
    }
}

extension CompletePage {
    func judgeScore(_ score: Float) -> Completable {
        return Completable.create(subscribe: { (completable) -> Disposable in
            if score > 60 {
                completable(.completed)
            }else {
                enum Score: Error {
                    case notPass
                }
                completable(.error(Score.notPass))
            }
            return Disposables.create { }
        })
    }
}
