//
//  SYViewVontroller.swift
//  SyncTool
//
//  Created by tree on 2018/3/24.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
import UIKit

class SYViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //MARK:property
    var navigationHeight: CGFloat {// 获得导航栏的高度
        if let navigation = self.navigationController {
            return navigation.navigationBar.frame.height;
        }else { return 0.0; }
    }
    var hasLocolTabBar: Bool {// 当前界面是否有私有的tabbar控制条
        for v in self.view.subviews {
            if v.isKind(of: UITabBar.self) { return true }
        }
        return false
    }
    var tabBarHeight: CGFloat { // tabbar的高度，全局的和私有的不可同时出现
        var height: CGFloat = 0.0
        if (self.hasRootTabBar) {
            if let tabBarController: UITabBarController = self.tabBarController {
                height =  tabBarController.tabBar.frame.height
            }
        }else if (self.hasLocolTabBar) {
            for v in self.view.subviews {
                if v.isKind(of: UITabBar.self) {
                    height = v.bounds.height
                }
            }
        }
        return height
    }
    var hasRootTabBar: Bool {// 当前是否显示了跟tabbar控制条
        if let tabBarController: UITabBarController = self.tabBarController, let controller: UIViewController = tabBarController.selectedViewController {// 是导航控制器
            if let navi: UINavigationController = controller as? UINavigationController, let curPage: UIViewController = navi.topViewController {// 导航
                if curPage.hidesBottomBarWhenPushed == true { return false }
                return true
            }
            else if controller.presentedViewController != nil {
                return false
            }
            else if (controller.tabBarController?.tabBar.isHidden == true) {
                return false
            }
        }
        return false
    }
    lazy var tableView: UITableView = {
        let o = UITableView.tableView()
        o.delegate = self
        o.dataSource = self
        return o
    }()
    
    lazy var groupTableView: UITableView = {
        let o = UITableView.groupTableView()
        o.delegate = self
        o.dataSource = self
        return o
    }()
    
    private var _titleLabel: UILabel = {
        let o: UILabel = UILabel.init()
        o.textColor = UIColor.black
        o.backgroundColor = UIColor.clear
        o.font = UIFont.systemFont(ofSize: 19)
        o.textAlignment = .center
        return o
    }()
    override var title: String? { // 设置页面的标题
        didSet {
            self._titleLabel.text = title
            if self.navigationItem.titleView != _titleLabel {
                self.navigationItem.titleView = _titleLabel
            }
        }
    }
    
    var attributeTitle: NSAttributedString? {
        didSet {
            self._titleLabel.attributedText = attributeTitle
            self.navigationItem.titleView = _titleLabel
        }
    }
    
    //MARK:systemCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
        let value: NSNumber = NSNumber.init(value: UIInterfaceOrientation.portrait.rawValue)
        UIDevice.current.setValue(value, forKey: "orientation")
    }
    //MARK:delegate&dataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        assert(false, "please implement this method to adapt UITableViewDelegate&DataSource")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        assert(false, "please implement this method to adapt UITableViewDelegate&DataSource")
    }
    //MARK:customMethod
}

