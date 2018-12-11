//
//  AccountManager.swift
//  playground
//
//  Created by tree on 2018/11/5.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation

public let AccountManagerDidUpdateAccountsNotificationName = Notification.Name("AccountManagerDidUpdateAccountsNotificationName")

fileprivate extension UserDefaults {
    static let selectedAccountKey = "AccountManagerSelectedAccountKey"
    
    var selectedAccountIdentifier: UUID? {
        get {
            return self.string(forKey: UserDefaults.selectedAccountKey).flatMap(UUID.init)
        }
        set {
            set(newValue?.uuidString, forKey: UserDefaults.selectedAccountKey)
        }
    }
}

@objcMembers public final class AccountManager: NSObject {
    
    private let defaults = UserDefaults.standard
    
    private(set) public var accounts = [Account]()
    
    private(set) public var selectedAccount: Account?
    
    private var store: AccountStore
    
    public var totalUnreadCount: Int {
        return accounts.reduce(0, { return $0 + $1.unreadConversationCount })
    }
    
    @objc(initWithSharedDirectory:)
    public init(sharedDirectory: URL) {
        store = AccountStore(root: sharedDirectory)
        super.init()
        updateAccounts()
    }
    
    @objc(deleteAtRoot:)
    static public func delete(at root: URL) {
        AccountStore.delete(at: root)
        UserDefaults.standard.selectedAccountIdentifier = nil
    }
    
    @objc(addOrUpdateAccount:)
    public func addOrUpdate(_ account: Account) {
        store.add(account)
        updateAccounts()
    }
    
    @objc(removeAccount:)
    public func remove(_ account: Account) {
        store.remove(account)
        updateAccounts()
    }
    
    @objc(selecteAccount:)
    public func select(_ account: Account) {
        guard account != selectedAccount else { return }
        defaults.selectedAccountIdentifier = account.userIdentifier
        updateAccounts()
    }
    
    //MARK: Private Helper
    private func updateAccounts() {
        var updatedAccounts = [Account]()
        
        for account in computeSortedAccounts() {
            if let existingAccount = self.account(with: account.userIdentifier) {
                existingAccount.updateWith(account)
                updatedAccounts.append(existingAccount)
            }else {
                updatedAccounts.append(account)
            }
        }
        accounts = updatedAccounts
        
        let computedAccount = computeSelectedAccount()
        if let account = computedAccount, let exisitingAccount = self.account(with: account.userIdentifier) {
            exisitingAccount.updateWith(account)
            selectedAccount = exisitingAccount
        }else {
            selectedAccount = computedAccount
        }
        
        NotificationCenter.default.post(name: AccountManagerDidUpdateAccountsNotificationName, object: self)
    }
    
    public func account(with id:UUID) -> Account? {
        return accounts.first(where: { return $0.userIdentifier == id })
    }
    
    private func computeSelectedAccount() -> Account? {
        return defaults.selectedAccountIdentifier.flatMap(store.load)
    }
    
    private func computeSortedAccounts() -> [Account] {
        return store.load().sorted(by: { (lhs, rhs) -> Bool in
            switch (lhs.teamName, rhs.teamName) {
            case (.some, .none): return false
            case (.none, .some): return true
            case (.some(let leftName), .some(let rightName)):
                guard leftName != rightName else { fallthrough }
                return leftName < rightName
            default: return lhs.userName < rhs.userName
            }
        })
    }
}
