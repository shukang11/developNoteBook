//
//  ObserverPage.swift
//  ReactiveCocoaDemo
//
//  Created by tree on 2018/8/27.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class ObserverPage: SYViewController {
    var disposeBag = DisposeBag()
    
    var nameLabel: UILabel = {
        let o = UILabel.init()
        o.textColor = UIColor.black
        o.text = "Username："
        o.font = UIFont.systemFont(ofSize: 17)
        return o
    }()
    var nameInput: UITextField = {
        let o = UITextField.init()
        o.placeholder = "enter your name"
        o.backgroundColor = UIColor.randomColor()
        return o
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /**
         观察者， 用来监听事件，然后需要这个事物作出相应
         */
        self.view.addSubview(self.nameLabel)
        self.view.addSubview(self.nameInput)
        
        self.nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(20.0)
            make.top.equalTo(self.view.snp.topMargin).offset(30.0)
            make.width.equalTo(140.0)
        }
        self.nameInput.snp.makeConstraints { (make) in
            make.height.equalTo(self.nameLabel)
            make.right.equalTo(self.view.snp.right).offset(-20.0)
            make.left.equalTo(self.nameLabel.snp.right)
            make.centerY.equalTo(self.nameLabel)
        }
        self.demo1()
    }
}
extension ObserverPage {
    // AnyObserver
    func demo1() -> Void {
        let _ = self.nameInput.rx.text.orEmpty.map { $0.count == 4 }.bind(to: self.nameLabel.rx.isHidden)
        
        // equal
        
        let observer: AnyObserver<Bool> = AnyObserver.init { [weak self] (event) in
            switch event {
            case .next(let isHidden):
                self?.nameLabel.isHidden = isHidden
            default:
                break
            }
        }
        // 如果是同一种，后者会覆盖前者
        self.nameInput.rx.text.orEmpty.map { $0.count == 6 }.bind(to: observer).disposed(by: disposeBag)
        
        // equal
        // Binder => 不处理错误事件, 绑定在Scheduler, 因此在UI场景，一般用Binder不用AnyObserver
        let observerBinder: Binder<Bool> = Binder.init(self.nameLabel) { (view, isHidden) in
            view.isHidden = isHidden
        }
        
       self.nameInput.rx.text.orEmpty.map { $0.count == 8 }.bind(to: observerBinder).disposed(by: disposeBag)
    }
}

extension ObserverPage {
    
    /// AsyncSubject 将在源 Observable 产生完成事件后，发出最后一个元素（仅仅只有最后一个元素），如果源 Observable 没有发出任何元素，只有一个完成事件。那 AsyncSubject 也只有一个完成事件。
    
    /// 它会对随后的观察者发出最终元素。如果源 Observable 因为产生了一个 error 事件而中止， AsyncSubject 就不会发出任何元素，而是将这个 error 事件发送出来。
    func asyncSubject() -> Void {
        let subject = AsyncSubject<String>()
        subject.subscribe { print("Subscription: 1 Event:", $0) }
        .disposed(by: disposeBag)
        
        subject.onNext("🐶")
        subject.onNext("🐱")
        subject.onNext("🐹")
        subject.onCompleted()
        
        /*
         Output:
         Subscription: 1 Event: next(🐹)
         Subscription: 1 Event: completed
         */
    }
}

extension ObserverPage {
    
    /// PublishSubject 将对观察者发送订阅后产生的元素，而在订阅前发出的元素将不会发送给观察者。如果你希望观察者接收到所有的元素，你可以通过使用 Observable 的 create 方法来创建 Observable，或者使用 ReplaySubject。
    

    func publishSubject() -> Void {
        let subject = PublishSubject<String>()
        
        subject.subscribe { print("Subscription: 1 Event:", $0) }
        .disposed(by: disposeBag)
        
        subject.onNext("🐶")
        subject.onNext("🐱")
        
        subject
            .subscribe { print("Subscription: 2 Event:", $0) }
            .disposed(by: disposeBag)
        
        subject.onNext("🅰️")
        subject.onNext("🅱️")
        
        /**
         输出结果：
         
         Subscription: 1 Event: next(🐶)
         Subscription: 1 Event: next(🐱)
         Subscription: 1 Event: next(🅰️)
         Subscription: 2 Event: next(🅰️)
         Subscription: 1 Event: next(🅱️)
         Subscription: 2 Event: next(🅱️)
         */
    }
}

extension ObserverPage {
    /**
     ReplaySubject 将对观察者发送全部的元素，无论观察者是何时进行订阅的。
     
     这里存在多个版本的 ReplaySubject，有的只会将最新的 n 个元素发送给观察者，有的只会将限制时间段内最新的元素发送给观察者。
     
     如果把 ReplaySubject 当作观察者来使用，注意不要在多个线程调用 onNext, onError 或 onCompleted。这样会导致无序调用，将造成意想不到的结果。
     */
    func replaySubject() {
        let subject = ReplaySubject<String>.create(bufferSize: 1)
        
        subject
            .subscribe { print("Subscription: 1 Event:", $0) }
            .disposed(by: disposeBag)
        
        subject.onNext("🐶")
        subject.onNext("🐱")
        
        subject
            .subscribe { print("Subscription: 2 Event:", $0) }
            .disposed(by: disposeBag)
        
        subject.onNext("🅰️")
        subject.onNext("🅱️")
        
        /**
         输出结果：
         
         Subscription: 1 Event: next(🐶)
         Subscription: 1 Event: next(🐱)
         Subscription: 2 Event: next(🐱)
         Subscription: 1 Event: next(🅰️)
         Subscription: 2 Event: next(🅰️)
         Subscription: 1 Event: next(🅱️)
         Subscription: 2 Event: next(🅱️)
         */
    }
}

extension ObserverPage {
    /**
     当观察者对 BehaviorSubject 进行订阅时，它会将源 Observable 中最新的元素发送出来（如果不存在最新的元素，就发出默认元素）。然后将随后产生的元素发送出来。
     如果源 Observable 因为产生了一个 error 事件而中止， BehaviorSubject 就不会发出任何元素，而是将这个 error 事件发送出来。
     */
    func behaviorSubject() {
        let subject = BehaviorSubject(value: "🔴")
        
        subject
            .subscribe { print("Subscription: 1 Event:", $0) }
            .disposed(by: disposeBag)
        
        subject.onNext("🐶")
        subject.onNext("🐱")
        
        subject
            .subscribe { print("Subscription: 2 Event:", $0) }
            .disposed(by: disposeBag)
        
        subject.onNext("🅰️")
        subject.onNext("🅱️")
        
        subject
            .subscribe { print("Subscription: 3 Event:", $0) }
            .disposed(by: disposeBag)
        
        subject.onNext("🍐")
        subject.onNext("🍊")
        /**
        输出结果：
        
        Subscription: 1 Event: next(🔴)
        Subscription: 1 Event: next(🐶)
        Subscription: 1 Event: next(🐱)
        Subscription: 2 Event: next(🐱)
        Subscription: 1 Event: next(🅰️)
        Subscription: 2 Event: next(🅰️)
        Subscription: 1 Event: next(🅱️)
        Subscription: 2 Event: next(🅱️)
        Subscription: 3 Event: next(🅱️)
        Subscription: 1 Event: next(🍐)
        Subscription: 2 Event: next(🍐)
        Subscription: 3 Event: next(🍐)
        Subscription: 1 Event: next(🍊)
        Subscription: 2 Event: next(🍊)
        Subscription: 3 Event: next(🍊)
        */
    }
}

extension ObserverPage {
    /**
     在 Swift 中我们经常会用 var 关键字来声明变量。RxSwift 提供的 Variable 实际上是 var 的 Rx 版本，你可以将它看作是 RxVar。
     
     第二种使用 Variable 则是 RxSwift 独有的。Variable 几乎提供了 var 的所有功能。另外，加上一条非常重要的特性，就是可以通过调用 asObservable() 方法转换成序列。然后你可以对这个序列应用操作符，来合成其他的序列。所以，如果我们声明的变量需要提供 Rx 支持，那就选用 Variable 这个类型。
     
     Variable 封装了一个 BehaviorSubject，所以它会持有当前值，并且 Variable 会对新的观察者发送当前值。它不会产生 error 事件。Variable 在 deinit 时，会发出一个 completed 事件。
     */
    func variable() -> Void {
        let model: Variable<String?> = Variable(nil)
        
        model.asObservable().subscribe { print("\($0)")}.disposed(by: disposeBag)
    }
}
