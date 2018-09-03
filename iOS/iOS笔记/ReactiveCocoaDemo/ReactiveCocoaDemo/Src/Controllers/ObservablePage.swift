//
//  ObservablePage.swift
//  ReactiveCocoaDemo
//
//  Created by tree on 2018/8/24.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum SerializErr: Error {
    case cantSerialize
}

class ObservablePage: SYViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /**
         所有的事物都是序列，可以用作描述元素异步产生的序列
         
         例如可以将温度看做一个序列，然后检测这个温度值，如果高于某个值的时候，就将空调打开
         */
//        demo1()
        demo2()
        
    }
    
    func demo1() -> Void {
        let numbers = Observable<Int>.create { (observer) -> Disposable in
            observer.onNext(1)
            observer.onNext(2)
            observer.onNext(3)
            observer.onNext(4)
            observer.onNext(5)
            observer.onCompleted()
            return Disposables.create()
        }
        let _ = numbers.map { $0 > 4 }.subscribe { (bigger) in
            if bigger.element == true {
                print("大点\(bigger.isCompleted)")
            }
        }
    }
    
    /// 将json序列化的请求
    func demo2() -> Void {
        let json: Observable = Observable<Any>.create { (observer) -> Disposable in
            let task = URLSession.shared.dataTask(with: URL.init(string: "https://api.github.com/repos/octokit/octokit.rb")!, completionHandler: { (data, response, error) in
                if let e = error {
                    observer.onError(e)
                    return
                }
                guard let data = data,
                    let jsonObj = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves) else {
                        observer.onError(SerializErr.cantSerialize)
                    return
                }
                observer.onNext(jsonObj)
                observer.onCompleted()
            })
            task.resume()
            return Disposables.create { task.cancel() }
        }
        
        let _ = json.subscribe(onNext: { (json) in
            print("on Next: \(json)")
        }, onError: { (error) in
            print("on error: \(error)")
        }, onCompleted: {
            print("on completed:")
        }, onDisposed: nil)
    }
    
    func demo3() -> Void {
        
    }
}

