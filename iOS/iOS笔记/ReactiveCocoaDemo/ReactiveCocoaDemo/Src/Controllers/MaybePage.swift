//
//  MaybePage.swift
//  ReactiveCocoaDemo
//
//  Created by tree on 2018/8/27.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class MaybePage: SYViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        /**
         Maybe 是 Observable 的另外一个版本。它介于 Single 和 Completable 之间，它要么只能发出一个元素，要么产生一个 completed 事件，要么产生一个 error 事件。
         
         发出一个元素或者一个 completed 事件或者一个 error 事件
         不会共享状态变化
         
         如果你遇到那种可能需要发出一个元素，又可能不需要发出时，就可以使用 Maybe。
         
         
         你同样可以对 Observable 调用 .asMaybe() 方法，将它转换为 Maybe。
         */
        getAValue(6).subscribe(onSuccess: { (value) in
            print("\(value)")
        }, onError: { (error) in
            print("\(error)")
        }) {
            print("completed")
        }
    }
}

extension MaybePage {
    func getAValue(_ type: Int) -> Maybe<String> {
        return Maybe.create(subscribe: { (maybe) -> Disposable in
            if type < 3 {
                maybe(.success("success"))
            }else if type < 8 {
                maybe(.completed)
            }else {
                enum F: Error {
                    case eight
                }
                maybe(.error(F.eight))
            }
            return Disposables.create { }
        })
    }
}
