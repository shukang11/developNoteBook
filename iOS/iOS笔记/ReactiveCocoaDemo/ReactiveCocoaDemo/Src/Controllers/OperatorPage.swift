//
//  OperatorPage.swift
//  ReactiveCocoaDemo
//
//  Created by tree on 2018/8/28.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

enum TestError: Error {
    case test
}

class OperatorPage: SYViewController {
    
    let bag: DisposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /**
         操作符
         */
//        self.amb()
//        self.buffer()
//        self.catchError()
//        self.combineLatest()
    }
}

extension OperatorPage {
    /**
     决策树
     我想要创建一个 Observable
     
     产生特定的一个元素：just
     经过一段延时：timer
     从一个序列拉取元素：from
     重复的产生某一个元素：repeatElement
     存在自定义逻辑：create
     每次订阅时产生：deferred
     每隔一段时间，发出一个元素：interval
     在一段延时后：timer
     一个空序列，只有一个完成事件：empty
     一个任何事件都没有产生的序列：never
     我想要创建一个 Observable 通过组合其他的 Observables
     
     任意一个 Observable 产生了元素，就发出这个元素：merge
     让这些 Observables 一个接一个的发出元素，当上一个 Observable 元素发送完毕后，下一个 Observable 才能开始发出元素：concat
     组合多个 Observables 的元素
     当每一个 Observable 都发出一个新的元素：zip
     当任意一个 Observable 发出一个新的元素：combineLatest
     我想要转换 Observable 的元素后，再将它们发出来
     
     对每个元素直接转换：map
     转换到另一个 Observable：flatMap
     只接收最新的元素转换的 Observable 所产生的元素：flatMapLatest
     每一个元素转换的 Observable 按顺序产生元素：concatMap
     基于所有遍历过的元素： scan
     我想要将产生的每一个元素，拖延一段时间后再发出：delay
     
     我想要将产生的事件封装成元素发送出来
     
     将他们封装成 Event<Element>：materialize
     然后解封出来：dematerialize
     我想要忽略掉所有的 next 事件，只接收 completed 和 error 事件：ignoreElements
     
     我想创建一个新的 Observable 在原有的序列前面加入一些元素：startWith
     
     我想从 Observable 中收集元素，缓存这些元素之后在发出：buffer
     
     我想将 Observable 拆分成多个 Observables：window
     
     基于元素的共同特征：groupBy
     我想只接收 Observable 中特定的元素
     
     发出唯一的元素：single
     我想重新从 Observable 中发出某些元素
     
     通过判定条件过滤出一些元素：filter
     仅仅发出头几个元素：take
     仅仅发出尾部的几个元素：takeLast
     仅仅发出第 n 个元素：elementAt
     跳过头几个元素
     跳过头 n 个元素：skip
     跳过头几个满足判定的元素：skipWhile，skipWhileWithIndex
     跳过某段时间内产生的头几个元素：skip
     跳过头几个元素直到另一个 Observable 发出一个元素：skipUntil
     只取头几个元素
     只取头几个满足判定的元素：takeWhile，takeWhileWithIndex
     只取某段时间内产生的头几个元素：take
     只取头几个元素直到另一个 Observable 发出一个元素：takeUntil
     周期性的对 Observable 抽样：sample
     发出那些元素，这些元素产生后的特定的时间内，没有新的元素产生：debounce
     直到元素的值发生变化，才发出新的元素：distinctUntilChanged
     并提供元素是否相等的判定函数：distinctUntilChanged
     在开始发出元素时，延时后进行订阅：delaySubscription
     我想要从一些 Observables 中，只取第一个产生元素的 Observable：amb
     
     我想评估 Observable 的全部元素
     
     并且对每个元素应用聚合方法，待所有元素都应用聚合方法后，发出结果：reduce
     并且对每个元素应用聚合方法，每次应用聚合方法后，发出结果：scan
     我想把 Observable 转换为其他的数据结构：as...
     
     我想在某个 Scheduler 应用操作符：subscribeOn
     
     在某个 Scheduler 监听：observeOn
     我想要 Observable 发生某个事件时, 采取某个行动：do
     
     我想要 Observable 发出一个 error 事件：error
     
     如果规定时间内没有产生元素：timeout
     我想要 Observable 发生错误时，优雅的恢复
     
     如果规定时间内没有产生元素，就切换到备选 Observable ：timeout
     如果产生错误，将错误替换成某个元素 ：catchErrorJustReturn
     如果产生错误，就切换到备选 Observable ：catchError
     如果产生错误，就重试 ：retry
     我创建一个 Disposable 资源，使它与 Observable 具有相同的寿命：using
     
     我创建一个 Observable，直到我通知它可以产生元素后，才能产生元素：publish
     
     并且，就算是在产生元素后订阅，也要发出全部元素：replay
     并且，一旦所有观察者取消观察，他就被释放掉：refCount
     通知它可以产生元素了：connect
     */
    /// 在多个源序列中，取第一个发出元素或者产生事件的序列，然后只发出它的元素
    func amb() {
        let aObs = Observable<String>.create { (observer) -> Disposable in
            observer.onNext("hi")
            observer.onNext("hi1")
            return Disposables.create()
        }
        let bObs = Observable<String>.create { (observer) -> Disposable in
            observer.onNext("1")
            observer.onNext("2")
            return Disposables.create()
        }
        
        let cObs = Observable<String>.just("no1")
        
        Observable<String>.amb([aObs, bObs, cObs]).subscribe { (event) in
            switch event {
            case .next(let elm):
                print("\(elm)")
            case .error(let err):
                print("\(err)")
            case .completed:
                print("completed")
            }
        }.disposed(by: bag)
    }
}

extension OperatorPage {
    
    /// 缓存元素，然后将缓存的元素集合，周期性的发出来
    func buffer() -> Void {
         let subject = PublishSubject<String>()
        
        subject.buffer(timeSpan: 1, count: 3, scheduler: MainScheduler.instance)
            .subscribe { print("\($0)") }.disposed(by: bag)
        
        subject.onNext("1")
        subject.onNext("2")
        subject.onNext("3")
        
        subject.onNext("a")
        subject.onNext("b")
        subject.onNext("c")
        subject.onCompleted()
    }
}

extension OperatorPage {
    
    /// 从一个错误事件中恢复，将错误的事件替换成备选序列
    /// catchErrorJustReturn 操作符会将error 事件替换成其他的一个元素，然后结束该序列。
    func catchError() -> Void {
        let sequenceThatFails = PublishSubject<String>()
        let recoverySequence = PublishSubject<String>()
        
        sequenceThatFails.catchError {
            print("Error \($0)")
            return recoverySequence
        }
            .subscribe { print("on \($0)") }
        .disposed(by: bag)
        
        sequenceThatFails.onNext("😬")
        sequenceThatFails.onNext("😨")
        sequenceThatFails.onNext("😡")
        sequenceThatFails.onNext("🔴")
        sequenceThatFails.onError(TestError.test)
        
        recoverySequence.onNext("😊")
    }
}


extension OperatorPage {
    
    /// 当多个 Observables 中任何一个发出一个元素，就发出一个元素。这个元素是由这些 Observables 中最新的元素，通过一个函数组合起来的
    func combineLatest() -> Void {
        let first = PublishSubject<String>()
        let second = PublishSubject<String>()
        
        Observable.combineLatest(first, second) { $0 + $1 }
            .subscribe { print("\($0)") }
        .disposed(by: bag)
        
        first.onNext("1")
        second.onNext("A")
        first.onNext("2")
        second.onNext("B")
        second.onNext("C")
        second.onNext("D")
        first.onNext("3")
        first.onNext("4")
        
        first.onCompleted()
        second.onCompleted()
    }
}
