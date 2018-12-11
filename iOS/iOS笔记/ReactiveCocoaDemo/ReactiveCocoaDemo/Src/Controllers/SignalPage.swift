//
//  SignalPage.swift
//  ReactiveCocoaDemo
//
//  Created by tree on 2018/8/23.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class SignalPage: SYViewController {
    
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
    
    var passwordLabel: UILabel = {
        let o = UILabel.init()
        o.textColor = UIColor.black
        o.text = "Password："
        o.font = UIFont.systemFont(ofSize: 17)
        return o
    }()
    var passwordInput: UITextField = {
        let o = UITextField.init()
        o.placeholder = "enter your password"
        o.backgroundColor = UIColor.randomColor()
        return o
    }()
    
    var button: UIButton = {
        let o = UIButton.init()
        o.setTitle("登录", for: .normal)
        o.setTitleColor(UIColor.randomColor(), for: .normal)
        return o
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.nameLabel)
        self.view.addSubview(self.nameInput)
        self.view.addSubview(self.passwordLabel)
        self.view.addSubview(self.passwordInput)
        self.view.addSubview(self.button)
        
        self.nameLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(20.0)
            make.top.equalTo(self.view.snp.topMargin).offset(30.0)
            make.width.equalTo(140.0)
        }
        self.passwordLabel.snp.makeConstraints { (make) in
            make.size.equalTo(self.nameLabel)
            make.left.equalTo(self.nameLabel)
            make.top.equalTo(self.nameLabel).offset(70)
        }
        
        self.nameInput.snp.makeConstraints { (make) in
            make.height.equalTo(self.nameLabel)
            make.right.equalTo(self.view.snp.right).offset(-20.0)
            make.left.equalTo(self.nameLabel.snp.right)
            make.centerY.equalTo(self.nameLabel)
        }
        
        self.passwordInput.snp.makeConstraints { (make) in
            make.size.equalTo(self.nameInput)
            make.left.equalTo(self.nameInput)
            make.centerY.equalTo(self.passwordLabel)
        }
        
        self.button.snp.makeConstraints { (make) in
            make.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view).offset(-20)
            make.top.equalTo(self.passwordLabel).offset(50)
            make.centerX.equalTo(self.view)
        }
        
        self.demo1()
    }
}


extension SignalPage {
    // 常见用法
    func demo1() -> Void {
        // share(replay: 1) 是用来做什么的？
        //        我们用 usernameValid 来控制用户名提示语是否隐藏以及密码输入框是否可用。shareReplay 就是让他们共享这一个源，而不是为他们单独创建新的源。这样可以减少不必要的开支。
        let nameInputValid = self.nameInput.rx.text.orEmpty.map { $0.trimString.length >= 5 }.share(replay: 1)
        
        let passwordValid = self.passwordInput.rx.text.orEmpty.map { $0.length >= 6}.share(replay: 1)
        
        /**
         disposed(by: disposeBag) 是用来做什么的？
         
         和我们所熟悉的对象一样，每一个绑定也是有生命周期的。并且这个绑定是可以被清除的。disposed(by: disposeBag)就是将绑定的生命周期交给 disposeBag 来管理。当 disposeBag 被释放的时候，那么里面尚未清除的绑定也就被清除了。这就相当于是在用 ARC 来管理绑定的生命周期。 这个内容会在 Disposable 章节详细介绍。
         */
        let _ = nameInputValid.bind(to: passwordInput.rx.isEnabled).disposed(by: disposeBag)
        
        let everythingValid = Observable.combineLatest(nameInputValid, passwordValid) { $0 && $1 }.share(replay: 1)
        let _ = everythingValid.bind(to: button.rx.isEnabled).disposed(by: disposeBag)
        
        // 订阅按钮的点击事件
        let _ = button.rx.controlEvent(UIControlEvents.touchUpInside).subscribe { [unowned self] (event) in
            print("\(self.button.title(for: .normal) ?? "")")
        }
        // 同上
        let _ = button.rx.tap.asObservable().subscribe { [unowned self] (event) in
            self.demo2()
            print("\(self.nameInput.text ?? "")")
            
        }
    }
    
    func demo2() -> Void {
        // 创建被观察者
        let _ = Observable.just("https://api.github.com/users").map {$0.trimString}

//        requestStream.bind(to: self.nameLabel.rx.text)
    }
}

