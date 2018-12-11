//
//  SYNavigationController.swift
//  SyncTool
//
//  Created by tree on 2018/3/24.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
import UIKit

class SYNavigationController: UINavigationController {
    //MARK:property
    
    //MARK:systemCycle
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK:delegate&dataSource
    
    
    //MARK:-
    //MARK:public
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            viewController.navigationItem.leftBarButtonItem = self.itemWith(self, action: #selector(self.backForward), image: "StaticResource.bundle/icon_navi_back", highlightImage: "StaticResource.bundle/icon_navi_back")
            self.interactivePopGestureRecognizer?.delegate = viewController as? UIGestureRecognizerDelegate
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    @discardableResult
    override func popViewController(animated: Bool) -> UIViewController? {
        return super.popViewController(animated: animated)
    }
    
    
    @objc func backForward() {
        popViewController(animated: true)
    }
    //MARK:customMethod
    func itemWith(_ target:Any, action:Selector, image:String, highlightImage:String) -> UIBarButtonItem {
        let btn: UIButton = UIButton.init(type: .custom)
        btn.setBackgroundImage(UIImage.init(named: image), for: .normal)
        btn.setBackgroundImage(UIImage.init(named: highlightImage), for: .highlighted)
        if let size = (btn.currentBackgroundImage?.size) { btn.frame.size = size }else {
            btn.frame.size = CGSize.init(width: 45.0, height: 35.0)
        }
        btn.addTarget(target, action: action, for: .touchUpInside)
        return UIBarButtonItem.init(customView: btn)
    }
    
    //MARK:-
    //MARK:转屏设置
    override var shouldAutorotate: Bool {
        guard self.topViewController != nil else {
            return false
        }
        return (self.topViewController?.shouldAutorotate)!
    }
    //支持的转屏方向
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        guard self.topViewController != nil else {
            return .portrait
        }
        return (self.topViewController?.supportedInterfaceOrientations)!
    }
}
