//
//  BaseProtocol.swift
//  URLProtocolDemo
//
//  Created by tree on 2018/5/16.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
import UIKit

public class BaseProtocol: URLProtocol, URLSessionTaskDelegate, URLSessionDataDelegate {
    
    var dataTask: URLSessionTask?
    
    /// 判断请求是否需要被接管
    ///
    /// - Parameter request: 判断的请求
    /// - Returns: 如果需要自己来处理，返回true， 如果需要交给系统处理，返回false
    public override class func canInit(with request: URLRequest) -> Bool {
        if request.url?.scheme == "http"
            && request.url?.host == "sxrcontainer" {
            return true
        }
        return false
    }
    
    /// 如果有需要，可以对请求进行修改
    ///
    public override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    /// 用于判断两个请求是否相同
    ///
    public override class func requestIsCacheEquivalent(_ a: URLRequest, to b: URLRequest) -> Bool {
        return super.requestIsCacheEquivalent(a, to: b)
    }
    
    public override func startLoading() {
        print("开始处理网络请求")
        if let url = request.url, let hd = request.allHTTPHeaderFields {
            
            let d: [String : Any] = [
                "name": "我是博得",
                "age": 15
                ]
            if let data = try? JSONSerialization.data(withJSONObject: d, options: .prettyPrinted),
                let response = HTTPURLResponse.init(url: url, statusCode: 200, httpVersion: "HTTP/1.1", headerFields: hd) {
                
                self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
                self.client?.urlProtocol(self, didLoad: data)
                self.client?.urlProtocolDidFinishLoading(self)
            }
        }
    }
    
    public override func stopLoading() {
        if let task = self.dataTask,
            task.state != .canceling {
            task.cancel()
        }
        self.dataTask = nil
    }
    
    
    //MARK:-
    //MARK:URLSessionDataDelegate
    
    /// 接收到了请求的返回数据
    ///
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        if(self.client != nil)
            && self.dataTask == task {
            self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
            completionHandler(.allow)
        }
    }
    
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        if self.dataTask == dataTask {
            self.client?.urlProtocol(self, didLoad: data)
        }
    }
    
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, willCacheResponse proposedResponse: CachedURLResponse, completionHandler: @escaping (CachedURLResponse?) -> Void) {
        if self.dataTask == dataTask {
            completionHandler(proposedResponse)
        }
    }
    
    
    //MARK:-
    //MARK:URLSessionTaskDelegate
    public func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
        if self.client != nil
            && self.dataTask == dataTask {
            print("我发现了一个重定向的请求哦：\(request.url?.absoluteString ?? "")")
            self.client?.urlProtocol(self, wasRedirectedTo: request, redirectResponse: response)
            
        }
    }

}
