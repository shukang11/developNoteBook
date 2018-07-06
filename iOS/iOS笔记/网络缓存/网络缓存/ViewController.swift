//
//  ViewController.swift
//  网络缓存
//
//  Created by tree on 2018/5/18.
//  Copyright © 2018年 treee. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        cache01()
        cache02()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func cache01() -> Void {
        if let url = URL.init(string: "https://rexxar.douban.com/api/routes") {
            print(url)
            let request = URLRequest.init(url: url, cachePolicy: .returnCacheDataElseLoad, timeoutInterval: 10)
            let session = URLSession.init(configuration: URLSessionConfiguration.default)
            session.dataTask(with: request, completionHandler: { (data, response, error) in
                if let e = error {
                    print(e)
                }
                if let j: [String: Any] = try! JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.allowFragments) as? [String: Any] {
                    SXRRouteFileCache.shared.saveRouteMap(data: data)
                    SXRRouteFileCache.shared.saveRouteFile(data: data, remoteURL: url)
                    print("获得数据")
                }
            }).resume()
        }
        print("`\(SXRRouteFileCache.shared.routeFileURLFor(remoteURL: URL.init(string: "https://rexxar.douban.com/api/routes")!))")
        //        print("\(SXRRouteFileCache.shared.cacheFileSize)")
        if let url = URL.init(string: "https://rexxar.douban.com/api/routes") {
            if let data = SXRRouteFileCache.shared.dataFor(remoteURL: url),
                let j: [String: Any] = try! JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] {
                //                print("\(j["items"])")
            }
        }
    }

    func cache02() -> Void {
        if let path = Bundle.main.path(forResource: "demo01", ofType: "html"),
            let url = URL.init(string: path) {
            SXRRouteFileCache.shared.saveRouteFile(data: NSData.init(contentsOf: url)! as Data, remoteURL: url)
        }
    }
}

