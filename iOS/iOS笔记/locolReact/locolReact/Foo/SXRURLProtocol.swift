//
//  SXRURLProtocol.swift
//  locolReact
//
//  Created by tree on 2018/5/21.
//  Copyright © 2018年 treee. All rights reserved.
//

import Foundation
import UIKit


/// URLProtocol是一个抽象类，用于处理特定协议的数据加载， 通过继承我们可以定义任何网络协议来返回给app数据，还可以拦截非法请求
/*
 
 */
open class SxrURLProtocol: URLProtocol, URLSessionTaskDelegate, URLSessionDataDelegate {
    var dataTask: URLSessionDataTask?
    var response: URLResponse?
    var receivedData: NSMutableData?
    
    static var sRegisteredClassCounter: [String: Int] = [:]
    
    /// 判断是否可以处理这个request
    ///
    /// - Parameter request: 请求实例
    /// - Returns: 如果可以返回true 否则返回false 返回false的话会由系统接管
    override open class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    /// 返回了原来的请求 应该可以对请求进行修改等 可以将请求转换成另外一个请求处理
    ///
    /// - Parameter request: 原先的请求
    /// - Returns: 根据需要修改或者替换
    override open class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    /// 比较两个请求是否使用相同的缓存
    ///
    /// - Parameters:
    ///   - a: requestA
    ///   - b: requestB
    /// - Returns: 是否使用同样的缓存
    override open class func requestIsCacheEquivalent(_ a: URLRequest, to b: URLRequest) -> Bool {
        return super.requestIsCacheEquivalent(a, to: b)
    }
    
    /// 开始加载数据
    override open func startLoading() {
        assert(false, "Implement this method in a subclass")
    }
    
    /// 加载结束
    override open func stopLoading() {
        if let task = dataTask, task.state != .canceling { task.cancel() }
        self.dataTask = nil
        self.receivedData = nil
        self.response = nil
    }
    
    //MARK:-
    //MARK:URLSessionDataDelegate
    
    /// 接收到数据的回调
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        if self.client != nil && self.dataTask == task {
            
            var urlR: URLResponse? = nil
            if let r: HTTPURLResponse = response as? HTTPURLResponse,
                let uL: URL = response.url,
                let hd: [String: String] = (r.allHeaderFields as? [String : String])
            {
                urlR = HTTPURLResponse.sxr_response(url: uL, statusCode: r.statusCode, headerFields: hd, noAcessControl: true)
            }
            
            self.client?.urlProtocol(self, didReceive: urlR ?? response, cacheStoragePolicy: URLCache.StoragePolicy.notAllowed)
            completionHandler(URLSession.ResponseDisposition.allow)
        }
    }
    
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        if (self.dataTask == dataTask) {
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
    
    /// 重定向的回调
    public func urlSession(_ session: URLSession, task: URLSessionTask, willPerformHTTPRedirection response: HTTPURLResponse, newRequest request: URLRequest, completionHandler: @escaping (URLRequest?) -> Void) {
        if self.client != nil && self.dataTask == task {
            if let m = request as? NSMutableURLRequest {
                SxrURLProtocol.unmarkRequestAsIgnored(request: m)
                self.client?.urlProtocol(self, wasRedirectedTo: request, redirectResponse: response)
                
                let err = NSError.init(domain: NSURLErrorDomain, code: NSURLErrorCancelled, userInfo: nil)
                self.dataTask?.cancel()
                self.client?.urlProtocol(self, didFailWithError: err as Error)
            }
        }
    }
    
    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if (self.client != nil) && ((self.dataTask != nil) || self.dataTask == task) {
            if let e = error {
                // 这里我们直接用系统的处理方法
                self.client?.urlProtocol(self, didFailWithError: e)
            }else {
                self.client?.urlProtocolDidFinishLoading(self)
            }
        }
    }
    
    //MARK:-
    //MARK:public
    class func markRequestAsIgnored(request: NSMutableURLRequest) {
        let key = NSStringFromClass(self)
        URLProtocol.setProperty(NSNumber.init(value: true), forKey: key, in: request)
    }
    
    class func unmarkRequestAsIgnored(request: NSMutableURLRequest) {
        let key = NSStringFromClass(self)
        URLProtocol.removeProperty(forKey: key, in: request)
    }
    
    class func isRequestIgnored(request: URLRequest) -> Bool {
        let key: String = NSStringFromClass(self)
        if URLProtocol.property(forKey: key, in: request) != nil {
            return true
        }
        return false
    }
    
    @discardableResult
    class func registerSxrProtocolClass(clazz: AnyClass) -> Bool {
        assert(clazz.isSubclass(of: self), "Invalid parameter not satisfying: \(clazz)")
        var result: Bool = false
        let count = sxr_counterFotRegisteredClass(clazz: clazz)
        if count <= 0 {
            if URLProtocol.registerClass(clazz) == true {
                sxr_setCount(count: 1, forClazz: clazz)
            }
        }else {
            sxr_setCount(count: count + 1, forClazz: clazz)
            result = true
        }
        return result
    }
    
    class func unregisterSxrProtocolClass(clazz: AnyClass) {
        assert(clazz.isSubclass(of: self), "Invalid parameter not satisfying: \(clazz)")
        let count = sxr_counterFotRegisteredClass(clazz: clazz) - 1
        if count <= 0 {
            URLProtocol.unregisterClass(clazz)
        }else {
            sxr_setCount(count: count, forClazz: clazz)
        }
    }
    
    //MARK:-
    //MARK:private
    private class func sxr_counterFotRegisteredClass(clazz: AnyClass) -> Int {
        let key = NSStringFromClass(clazz)
        if let c = sRegisteredClassCounter[key] {
            return c
        }
        return 0
    }
    
    private class func sxr_setCount(count: Int, forClazz clazz: AnyClass) {
        let key = NSStringFromClass(clazz)
        sRegisteredClassCounter.updateValue(count, forKey: key)
    }
}
