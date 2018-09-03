//
//  DriverPage.swift
//  ReactiveCocoaDemo
//
//  Created by tree on 2018/8/27.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class DriverPage: SYViewController {
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
        self.view.backgroundColor = UIColor.white
        /**
         Driver是一个精心准备的特征序列，主要是为了简化UI层的代码，不过如果遇到的序列有如下特征，也可以使用
         
         不会产生 error 事件
         一定在 MainScheduler 监听（主线程监听）
         共享状态变化
         
         
         同样，满足上述条件的序列都可以转换为Driver类型
         */
        
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
        
//        settingNameValid()
        driverHandle()
    }
}

extension DriverPage {
    func settingNameValid() -> Void {
        let nameR = self.nameInput.rx.text.orEmpty.throttle(0.3, scheduler: MainScheduler.instance)
        nameR.map { "\($0.count)" }.bind(to: nameLabel.rx.text).disposed(by: disposeBag)
    }
    
    func driverHandle() -> Void {
        let nameR = self.nameInput.rx.text.orEmpty.asDriver() // 将普通序列转化为Driver
        nameR.throttle(0.3, latest: true).map { "\($0.count)歌" }.drive(nameLabel.rx.text)
        
    }
}

