//
//  PageViewController.swift
//  playground
//
//  Created by tree on 2018/12/10.
//  Copyright © 2018 treee. All rights reserved.
//

import UIKit

class PageViewController: UIViewController {

    var controllers: [UIViewController] = []

    var pageViewController: UIPageViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        // temp code
        if let url = Bundle.main.url(forResource: "mdjyml.txt", withExtension: nil),
            let content = ReadKitUtil.encodeStringFile(url) {
            let model = BookModel.init(content, url: url)
            print("\(model.chapters[0...10])")
        }
        if let url = Bundle.main.url(forResource: "wallhaven-540738", withExtension: "png"), let data = try? Data.init(contentsOf: url) {
            print("\(ReadKitUtil.fileType(data))")
        }
        self.setupControllers()
        self.setupPageViewController()
    }

    func setupControllers() {
        for _ in 1...5 {
            let p = UIViewController()
            p.view.backgroundColor = UIColor.randomColor()
            self.controllers.append(p)
        }
    }

    func setupPageViewController() {
        let options = [UIPageViewControllerOptionSpineLocationKey: NSNumber.init(value: UIPageViewControllerSpineLocation.min.rawValue)]
        self.pageViewController = UIPageViewController.init(transitionStyle: .pageCurl, navigationOrientation: .horizontal, options: options)
        self.pageViewController.delegate = self
        self.pageViewController.dataSource = self
        
        self.pageViewController.setViewControllers([self.controllers.first!], direction: .reverse, animated: false, completion: nil)
        self.pageViewController.view.frame = self.view.bounds
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
    }
}

extension PageViewController: UIPageViewControllerDelegate {

}

extension PageViewController: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let index = self.controllers.firstIndex(of: viewController) {
            if index > 0 {
                return self.controllers[index - 1]
            }
        }
        return nil
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
//        if let index = self.controllers.firstIndex(of: viewController) {
//            if index < self.controllers.count - 1 {
//                return self.controllers[index + 1]
//            }
//        }
//        return nil
        let page = UIViewController()
        page.view.backgroundColor = UIColor.randomColor()
        return page
    }



}
