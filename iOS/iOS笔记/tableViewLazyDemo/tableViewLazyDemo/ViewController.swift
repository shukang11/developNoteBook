//
//  ViewController.swift
//  tableViewLazyDemo
//
//  Created by tree on 2018/3/15.
//  Copyright © 2018年 treee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var tableView: UITableView = {
        let o = UITableView.init()
        return o
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "表格滑动不加载"
        self.view.addSubview(self.tableView)
        self.tableView.frame = CGRect.init(x: 0.0, y: 64.0, width: self.view.frame.size.width, height: self.view.frame.size.height - 64.0)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    //MARK:-
    //MARK:delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1000;
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var t = tableView.dequeueReusableCell(withIdentifier: "cell")
        if t == nil {
            t = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        }
        let cell = t!
        cell.textLabel?.text = "预加载的？\(indexPath)"
        return cell
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.loadVisableCells()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if decelerate == false { self.loadVisableCells() }
        
    }
    func loadVisableCells() {
        guard let array: [IndexPath] = self.tableView.indexPathsForVisibleRows else { return }
        for indexpath in array {
            if let cell = self.tableView.cellForRow(at: indexpath) {
                cell.textLabel?.text = "开始加载数据——>\(indexpath)"
                if (indexpath.row%2 == 0) {
                    cell.transform = CGAffineTransform.init(translationX: -self.view.frame.width, y: 0)
                }else {
                    cell.transform = CGAffineTransform.init(translationX: self.view.frame.width, y: 0)
                }
                UIView.animate(withDuration: 0.4, delay: TimeInterval(Float(indexpath.row)*0.03), usingSpringWithDamping: 0.75, initialSpringVelocity: 1/0.75, options: UIViewAnimationOptions(rawValue: 0), animations: {
                    cell.transform = .identity
                }, completion: nil)
            }
        }
    }
}

