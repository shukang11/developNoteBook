//
//  MVVMViewModel.swift
//  playground
//
//  Created by tree on 2018/11/8.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class MVVMViewModel: NSObject {
    
    @objc dynamic var originObserve: String = ""
    
    var navigationTitle: Observable<String> {
        return Observable.create({ (observer) -> Disposable in
            observer.onNext("title of MVVM")
            return Disposables.create()
        })
    }
    
    override init() {
        super.init()
    }
}

extension NSObjectProtocol where Self: NSObject {
    func observe<Value>(_ keyPath: KeyPath<Self, Value>, onChange: @escaping (Value) -> ()) -> NSKeyValueObservation {
        return observe(keyPath, options: [.initial, .new], changeHandler: { (_, change) in
            guard let newValue = change.newValue else { return }
            onChange(newValue)
        })
    }
    
    func bind<Value, Target>(_ sourceKeyPath: KeyPath<Self, Value>, to target: Target, at targetKeyPath: ReferenceWritableKeyPath<Target, Value>) -> NSKeyValueObservation {
        return observe(sourceKeyPath, onChange: { target[keyPath: targetKeyPath] = $0 })
    }
}
