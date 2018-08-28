//
//  SinglePage.swift
//  ReactiveCocoaDemo
//
//  Created by tree on 2018/8/27.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class SinglePage: UIViewController {
    var disponseBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        /**
         Single 是 序列的另外一个版本,不像Observable可以发出多个元素，它要么只能发出一个元素，要么产生一个error时间
         
         同时不会共享状态变化
         */
        self.demo1()
        
    }
}

extension SinglePage {
    // 基本用法
    func demo1() -> Void {
        getRepo("ReactiveX/RxSwift").subscribe(onSuccess: { (json) in
            print("json: \(json)")
        }) { (error) in
            print("error: \(error)")
        }.disposed(by: disponseBag)
    }
    
    func getRepo(_ repo: String) -> Single<[String: Any]> {
        return Single<[String: Any]>.create(subscribe: { (single) -> Disposable in
            let url = URL.init(string: "https://api.github.com/repos/\(repo)")!
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) in
                if let err = error {
                    single(.error(err))
                    return
                }
                
                guard let data = data,
                    let json = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves) else {
                    single(.error(SerializErr.cantSerialize))
                    return
                }
                if let j: [String: Any] = json as? [String : Any] {
                    single(.success(j))
                }
            })
            task.resume()
            return Disposables.create { task.cancel() }
        })
    }
}
