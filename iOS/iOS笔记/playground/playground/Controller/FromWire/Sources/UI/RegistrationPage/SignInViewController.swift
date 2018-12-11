//
//  SignInViewController.swift
//  playground
//
//  Created by tree on 2018/11/22.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation
import UIKit
import PlayloadDataModel

class SignInViewController: UIViewController {
    var loginCredentials: LoginCredentials?

    var authenticationCoordinator: AuthenticationCoordinator = AuthenticationCoordinator()

    var emailSignInViewControllerContainer: UIViewController?
    var phoneSignInViewControllerContainer: UIViewController?

    var presentedSignInViewController: UIViewController?

    var phoneSignInViewController: PhoneSignInViewController?
    var emailSignInViewController: EmailSignInViewController?

    private var viewControllerContainer: UIView = {
        let o = UIView.init()
        return o
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        view.addSubview(viewControllerContainer)
        viewControllerContainer.snp.makeConstraints {
            $0.top.equalTo(self.view.snp.centerY)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.view.snp.bottom)
        }
        presentEmailSignInViewControllerToEnterPassword()
    }
}

extension SignInViewController {
    func presentSignInViewController(_ credentials: LoginCredentials) {
        self.loginCredentials = credentials
        if credentials.emailAddress != nil {
            presentEmailSignInViewControllerToEnterPassword()
        }else {
            presentPhoneSignInViewControllerToEnterPassword()
        }
    }

    func presentSignInViewController(viewController: UIViewController) {
        updateSignInButtonsForPresentedViewController(viewController: viewController)

        guard let presented = self.presentedSignInViewController else { return }
        presented.willMove(toParentViewController: nil)
        presented.view.removeFromSuperview()
        presented.removeFromParentViewController()

        self.presentedSignInViewController = presented

        self.addChildViewController(presented)
        self.viewControllerContainer.addSubview(presented.view)

        presented.view.translatesAutoresizingMaskIntoConstraints = false

        presented.view.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        presented.didMove(toParentViewController: self)
    }

    func swapFromViewController(fromViewController: UIViewController, toViewController: UIViewController) {
        if self.childViewControllers.contains(toViewController) { return }
        self.updateSignInButtonsForPresentedViewController(viewController: toViewController)
        self.presentedSignInViewController = toViewController

        fromViewController.willMove(toParentViewController: nil)
        self.addChildViewController(toViewController)

        toViewController.view.translatesAutoresizingMaskIntoConstraints = true
        toViewController.view.frame = fromViewController.view.frame
        toViewController.view.layoutIfNeeded()

        self.transition(from: fromViewController, to: toViewController, duration: 0.35, options: [.transitionCrossDissolve], animations: {

        }) { (_) in
            toViewController.didMove(toParentViewController: self)
            fromViewController.removeFromParentViewController()
        }
    }

    func presentEmailSignInViewControllerToEnterPassword() {
        setupEmailSignInViewController()
    }

    func presentPhoneSignInViewControllerToEnterPassword() {
        setupPhoneSignInViewController()
    }
}

extension SignInViewController {
    func setupEmailSignInViewController() {
        let emailSignInViewController = EmailSignInViewController()
        emailSignInViewController.coordinator = self.authenticationCoordinator
        emailSignInViewController.loginCredentials = self.loginCredentials
        emailSignInViewController.view.frame = self.viewControllerContainer.bounds
        emailSignInViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.emailSignInViewControllerContainer = emailSignInViewController
        self.viewControllerContainer.addSubview(emailSignInViewController.view)
    }

    func setupPhoneSignInViewController() {
        let phoneSignInViewController = PhoneSignInViewController()
        phoneSignInViewController.view.frame = self.viewControllerContainer.frame
        phoneSignInViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.phoneSignInViewController =  phoneSignInViewController
        self.viewControllerContainer.addSubview(phoneSignInViewController.view)
    }
}

extension SignInViewController {
    func updateSignInButtonsForPresentedViewController(viewController: UIViewController) {

    }
}
