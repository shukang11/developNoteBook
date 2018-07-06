//
//  ViewController.swift
//  URLProtocolDemo
//
//  Created by tree on 2018/5/16.
//  Copyright © 2018年 treee. All rights reserved.
//

import UIKit

class ViewController: UIViewController, URLSessionDataDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        URLProtocol.registerClass(BaseProtocol.self)
        let url = URL.init(string: "http://sxrcontainer/api/geo")!
        var r = URLRequest.init(url: url)
        r.httpMethod = "GET"
        send(request: r)
    }
    
    func send(request: URLRequest) {
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in
            if error != nil {
                print("\(error?.localizedDescription ?? "")")
                return
            }
            if let json = try? JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String: Any] {
                print("\(json)")
            }
            if let str = String.init(data: data!, encoding: String.Encoding.utf8) {
                print("\(str)")
            }
        }
        task.resume()
    }
}

