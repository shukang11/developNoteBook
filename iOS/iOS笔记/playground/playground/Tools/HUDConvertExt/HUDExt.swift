//
//  HUDExt.swift
//  SyncTool
//
//  Created by tree on 2018/3/24.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
import UIKit
import NVActivityIndicatorView

var activityIndicatorView: NVActivityIndicatorView?

extension UIView: NVActivityIndicatorViewable {
    
    public func syn_showHub() -> Void {
        if activityIndicatorView?.superview != nil {
            activityIndicatorView?.removeFromSuperview()
        }
        activityIndicatorView = NVActivityIndicatorView.init(frame: self.frame, type: NVActivityIndicatorType.ballRotate, color: UIColor.blue, padding: 10.0)
        self.addSubview(activityIndicatorView!)
        activityIndicatorView?.ss_size = CGSize.init(width: 90.0, height: 90.0)
        activityIndicatorView?.center = self.center
        activityIndicatorView?.startAnimating()
    }
    
    func syn_hidHub() -> Void {
        guard activityIndicatorView != nil else {
            return
        }
        activityIndicatorView?.stopAnimating()
        activityIndicatorView?.removeFromSuperview()
    }
}
