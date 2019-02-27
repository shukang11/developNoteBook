//
//  PRSession.swift
//  playground
//
//  Created by tree on 2019/2/27.
//  Copyright © 2019 treee. All rights reserved.
//

import UIKit

protocol PRSessionDelegateType: URLSessionDataDelegate {
    func add(_ task: URLSessionTask)
    func remove(_ task: URLSessionTask)
    func task(for task: URLSessionTask) -> URLSessionTask?
    func shouldTaskStart(_ task: URLSessionTask) -> Bool
}

class PRSessionDelegate: NSObject {
    private var tasks: [Int: URLSessionTask] = [:]
    private var lock: NSLock = NSLock()
    
    func add(_ task: URLSessionTask) {
        lock.lock()
        defer { lock.unlock() }
        tasks[task.taskIdentifier] = task
    }
    
    func remove(_ task: URLSessionTask) {
        lock.lock()
        defer { lock.unlock() }
        tasks.removeValue(forKey: task.taskIdentifier)
    }
    
    func task(for task: URLSessionTask) -> URLSessionTask? {
        lock.lock()
        defer { lock.unlock() }
        return tasks[task.taskIdentifier]
    }
    
    func shouldTaskStart(_ task: URLSessionTask) -> Bool {
        return true
    }
}

extension PRSessionDelegate: PRSessionDelegateType {
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        guard let task = tasks[dataTask.taskIdentifier] else {
            return
        }
        
    }
    
}
public class PRSession: Client {
    let host: String = "https://api.github.com"
    
    private static var _shared: PRSession?
    public static var shared: PRSession {
        return guardSharedProperty(_shared)
    }
    
    
    func send<T>(_ r: T, handler: @escaping ((T.PRResponse?) -> Void)) where T : PRRequest {
        let url = URL(string: self.host.appending(r.path))!
        var request = URLRequest(url: url)
        request.httpMethod = r.method.rawValue
        
        let task = URLSession.shared.dataTask(with: request) { (data, _, error) in
            if let data = data, let res = T.PRResponse.parse(data: data) {
                DispatchQueue.main.async { handler(res) }
            } else {
                DispatchQueue.main.async { handler(nil) }
            }
        }
        task.resume()
    }
}
