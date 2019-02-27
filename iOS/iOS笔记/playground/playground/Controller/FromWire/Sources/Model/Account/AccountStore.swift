//
//  AccountStore.swift
//  playground
//
//  Created by tree on 2018/11/5.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation
import SSKitSwift

class AccountStore: NSObject {
    
    private static let directoryName = "Accounts"
    private let fileManager = FileManager.default
    private let directory: URL // The url to the directory in which accounts are stored in
    
    public required init(root: URL) {
        directory = root.appendingPathComponent(AccountStore.directoryName)
        super.init()
        do {
        try FileManager.default.createDirectory(at: directory, withIntermediateDirectories: true, attributes: nil)
            DLog("\(directory)")
        }catch {
            DLog("创建文件夹失败")
        }
    }
    
    func load() -> Set<Account> {
        return Set<Account>(loadURLs().compactMap(Account.load))
    }
    
    func load(_ uuid: UUID) -> Account? {
        return Account.load(from: url(for: uuid))
    }
    
    @discardableResult func add(_ account: Account) -> Bool {
        do {
            try account.write(to: url(for: account))
            return true
        }catch {
            return false
        }
    }
    
    @discardableResult func remove(_ account: Account) -> Bool {
        do {
            guard contains(account) else { return false }
            try fileManager.removeItem(at: url(for: account))
            return true
        }catch {
            return false
        }
    }
    
    @discardableResult static func delete(at root: URL) -> Bool {
        do {
            try FileManager.default.removeItem(at: root.appendingPathComponent(directoryName))
            return true
        }catch {
            return false
        }
    }
    
    func contains(_ account: Account) -> Bool {
        return fileManager.fileExists(atPath: url(for: account).path)
    }
    
    private func loadURLs() -> Set<URL> {
        do {
            let uuidName: (String) -> Bool = { UUID(uuidString: $0) != nil}
            let paths = try fileManager.contentsOfDirectory(atPath: directory.path)
            return Set<URL>(paths.filter(uuidName).map(directory.appendingPathComponent))
        } catch {
            return []
        }
    }
    
    private func url(for account: Account) -> URL {
        return url(for: account.userIdentifier)
    }
    
    private func url(for uuid: UUID) -> URL {
        return directory.appendingPathComponent(uuid.uuidString)
    }
}
