//: Playground - noun: a place where people can play

import UIKit
import Foundation


class RequestHandler: NSObject, URLSessionDataDelegate {
    var url: URL = {
        let o = URL.init(string: "https://kyfw.12306.cn/otn/leftTicket/init")
        return o!
    }()
    var request: URLRequest!
    
    override init() {
        self.request = URLRequest.init(url: url)
        super.init()
    }
    
    func call() -> Void {
        let session: URLSession = URLSession.init(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: nil)
        let task = session.dataTask(with: request)
        task.resume()
    }
    
    /// 只要访问的是HTTPS的路径就会调用
    /// 该方法的作用就是处理服务器返回的证书, 需要在该方法中告诉系统是否需要安装服务器返回的证书
    /// - Parameters:
    ///   - session: 会话
    ///   - challenge: 授权质问
    ///   - completionHandler: 回调
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        var disposition = URLSession.AuthChallengeDisposition.performDefaultHandling
        // 如果返回的证书是服务器信任的
        let credential = URLCredential.init(trust: challenge.protectionSpace.serverTrust!)
        if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
            /**
            disposition： 如何处理证书
             performDefaultHandling: 默认的处理方式
             useCredential: 使用指定的证书
             cancelAuthenticationChallenge: 取消请求
            */
            if credential != nil {
                disposition = URLSession.AuthChallengeDisposition.useCredential
            }else {
                disposition = URLSession.AuthChallengeDisposition.performDefaultHandling
            }
        }else {
            disposition = URLSession.AuthChallengeDisposition.cancelAuthenticationChallenge
        }
        completionHandler(disposition, credential)
    }
}

let a = RequestHandler.init()
a.call()
