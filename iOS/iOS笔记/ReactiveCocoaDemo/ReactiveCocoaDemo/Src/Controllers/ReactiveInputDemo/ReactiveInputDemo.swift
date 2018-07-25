//
//  ReactiveInputDemo.swift
//  ReactiveCocoaDemo
//
//  Created by tree on 2018/7/20.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
import UIKit

class ReactiveInputDemo: SYViewController {
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
            make.top.equalTo(self.view.snp.topMargin)
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
        self.setUp()
    }
    
    func setUp() -> Void {
        self.button.reactive.controlEvents(.touchUpInside).observeValues { (sender) in
            print("\(self.nameInput.text)")
        }
        let validUsernameSignal = self.nameInput.reactive.continuousTextValues.map { (text) -> Bool in
            return self.isValidUsername(text: text)
        }
        validUsernameSignal.map { (isValidUsername) -> UIColor in
            return isValidUsername ? UIColor.clear : UIColor.cyan
            }.observeValues { (backgroundColor) in
                self.nameInput.backgroundColor = backgroundColor
        }
        
        let validPasswordSignal = self.passwordInput.reactive.continuousTextValues.map { (text) -> Bool in
            return self.isValidPassword(text: text)
        }
        
        let signUpActiveSignal = validUsernameSignal.combineLatest(with: validPasswordSignal)
        signUpActiveSignal.map { $0 && $1 }.observeValues {self.button.isEnabled = $0 }
    }
    
    func isValidUsername(text: String?) -> Bool {
        return (text ?? "").count > 6
    }
    
    func isValidPassword(text: String?) -> Bool {
        return (text ?? "").count > 6
    }
}
