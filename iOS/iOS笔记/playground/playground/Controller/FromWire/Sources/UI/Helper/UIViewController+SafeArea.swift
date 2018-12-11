//
//  UIViewController+SafeArea.swift
//  playground
//
//  Created by tree on 2018/11/29.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {

    @available(iOS 9.0, *)
    var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.view.safeAreaLayoutGuide.bottomAnchor
        } else {
            return self.bottomLayoutGuide.topAnchor
        }
    }

    @available(iOS 9.0, *)
    var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11.0, *) {
            return self.view.safeAreaLayoutGuide.topAnchor
        } else {
            return self.topLayoutGuide.topAnchor
        }
    }
}

@available(iOS 9.0, *)
extension UIView {
    @objc var safeAreaLayoutGuideOrFallback: UILayoutGuide {
        if #available(iOS 11.0, *) {
            return self.safeAreaLayoutGuide
        } else {
            return self.layoutMarginsGuide
        }
    }

    @objc var safeAreaInsetsOrFallback: UIEdgeInsets {
        if #available(iOS 11, *) {
            return safeAreaInsets
        } else {
            return .zero
        }
    }

    @objc var safeLeadingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11, *) {
            return safeAreaLayoutGuide.leadingAnchor
        } else {
            return leadingAnchor
        }
    }

    @objc var safeTrailingAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11, *) {
            return safeAreaLayoutGuide.trailingAnchor
        } else {
            return trailingAnchor
        }
    }

    @objc var safeBottomAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11, *) {
            return safeAreaLayoutGuide.bottomAnchor
        }
        else {
            return bottomAnchor
        }
    }

    @objc var safeTopAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11, *) {
            return safeAreaLayoutGuide.topAnchor
        }
        else {
            return topAnchor
        }
    }

    @objc var safeCenterYAnchor: NSLayoutYAxisAnchor {
        if #available(iOS 11, *) {
            return safeAreaLayoutGuide.centerYAnchor
        }
        else {
            return centerYAnchor
        }
    }

    @objc var safeCenterXAnchor: NSLayoutXAxisAnchor {
        if #available(iOS 11, *) {
            return safeAreaLayoutGuide.centerXAnchor
        }
        else {
            return centerXAnchor
        }
    }
}
