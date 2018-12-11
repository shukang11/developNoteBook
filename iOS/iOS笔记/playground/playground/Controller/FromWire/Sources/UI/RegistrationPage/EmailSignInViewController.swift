//
//  EmailSignInViewController.swift
//  playground
//
//  Created by tree on 2018/11/22.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation
import UIKit
import PlayloadDataModel

class EmailSignInViewController: UIViewController {

    var coordinator: AuthenticationCoordinator?

    var loginCredentials: LoginCredentials?

    var emailField: UITextField = {
        let o = UITextField.init()
        return o
    }()

    var passwordField: UITextField = {
        let o = UITextField.init()
        return o
    }()

    var forgotPasswordButton: UIButton = {
        let o = UIButton.init()
        return o
    }()

    var companyLoginButton: UIButton = {
        let o = UIButton.init()
        return o
    }()

    var buttonsView: UIView = {
        let o = UIView.init()
        return o
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.green
        self.createEmailField()
        self.createPasswordField()
        self.createButtons()

        self.createConstraints()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.emailField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
    }
    func takeFirstResponder() {
        
    }
}

extension EmailSignInViewController {
    func createEmailField() {
        if #available(iOS 11.0, *) {
            emailField.textContentType = UITextContentType.username
        }

        emailField.placeholder = "请填写邮箱地址"
        emailField.accessibilityLabel = "请填写邮箱地址"
        emailField.keyboardType = .emailAddress
        emailField.returnKeyType = .next
        emailField.keyboardAppearance = .dark
        emailField.autocapitalizationType = .none
        emailField.autocorrectionType = .no
        emailField.minimumFontSize = 15.0
        emailField.accessibilityIdentifier = "EmailField"
        if #available(iOS 10.0, *) {
            emailField.textContentType = UITextContentType.emailAddress
        }
        emailField.delegate = self

        if self.loginCredentials?.emailAddress != nil {
            self.emailField.text = self.loginCredentials?.emailAddress
        }
        self.view.addSubview(emailField)
    }

    func createPasswordField() {
        passwordField.placeholder = "请输入密码"
        passwordField.accessibilityLabel = "请输入密码"
        passwordField.isSecureTextEntry = true
        passwordField.keyboardAppearance = .dark
        passwordField.accessibilityIdentifier = "PasswordField"
        passwordField.returnKeyType = .done
        passwordField.delegate = self
        view.addSubview(passwordField)
    }

    func createForgotPasswordButton() {
        forgotPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        forgotPasswordButton.setTitleColor(UIColor.white, for: .normal)
        forgotPasswordButton.setTitleColor(UIColor.white.withAlphaComponent(0.4), for: .highlighted)
        forgotPasswordButton.setTitle("忘记密码", for: .normal)
        forgotPasswordButton.titleLabel?.font = UIFont.smallLightFont
        forgotPasswordButton.addTarget(self, action: #selector(forgotPassword), for: .touchUpInside)
    }

    func createCompanyLoginButton() {
        companyLoginButton.translatesAutoresizingMaskIntoConstraints = false
        companyLoginButton.setTitleColor(UIColor.white, for: .normal)
        companyLoginButton.setTitleColor(UIColor.white.withAlphaComponent(0.4), for: .highlighted)
        companyLoginButton.setTitle("组织登录", for: .normal)
        companyLoginButton.titleLabel?.font = UIFont.smallLightFont
    }

    func createButtons() {
        self.createForgotPasswordButton()

        self.createCompanyLoginButton()
        view.addSubview(buttonsView)

        self.buttonsView.addSubview(companyLoginButton)
        self.buttonsView.addSubview(forgotPasswordButton)
        forgotPasswordButton.snp.makeConstraints {
            $0.top.right.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
        }
        companyLoginButton.snp.makeConstraints {
            $0.top.left.bottom.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.5)
        }
    }

    func createConstraints() {
        emailField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(28)
            $0.top.equalTo(self.view.snp.top)
            $0.trailing.equalToSuperview().inset(28)
            $0.height.equalTo(40.0)
        }

        passwordField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(28.0)
            $0.top.equalTo(self.emailField.snp.bottom).offset(8)
            $0.trailing.equalToSuperview().inset(28)
            $0.height.equalTo(40.0)
        }

        buttonsView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(28)
            $0.top.equalTo(self.passwordField.snp.bottom).offset(13)
            $0.trailing.equalToSuperview().inset(28)
            $0.bottom.equalToSuperview().inset(13)
        }
    }
}

extension EmailSignInViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.emailField {
            self.passwordField.becomeFirstResponder()
            return false
        } else if textField == self.passwordField {
            // pass
            return false
        }
        return true
    }

    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
}

extension EmailSignInViewController {

    @objc func forgotPassword() {
        if let coor = self.coordinator {
            coor.forgotPassword()
        }
    }
}
