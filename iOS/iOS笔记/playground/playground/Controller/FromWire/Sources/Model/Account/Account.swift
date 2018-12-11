//
//  Account.swift
//  playground
//
//  Created by tree on 2018/11/5.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation

extension Notification.Name {
    public static let AccountUnreadCountDidChangeNotification = Notification.Name("AccountUnreadCountDidChangeNotification")
}

public final class Account: NSObject, Codable {
    public var userName: String
    
    public var teamName: String?
    
    public var userIdentifier: UUID
    
    public var imageData: Data?
    
    public var teamImageData: Data?
    
    public var loginCredentials: LoginCredentials?
    
    public var unreadConversationCount: Int = 0 {
        didSet {
            if oldValue != self.unreadConversationCount {
                NotificationCenter.default.post(Notification.init(name: .AccountUnreadCountDidChangeNotification))
            }
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case userName = "name"
        case teamName = "team"
        case userIdentifier = "identifier"
        case imageData = "image"
        case teamImageData = "teamImage"
        case unreadConversationCount = "unreadConversationCount"
        case loginCredentials = "loginCredentials"
    }
    
    public required init(userName: String,
                                  userIdentifier: UUID,
                                  teamName: String? = nil,
                                  imageData: Data? = nil,
                                  teamImageData: Data? = nil,
                                  unreadConversationCount: Int = 0,
                                  loginCredentials: LoginCredentials? = nil) {
        self.userName = userName
        self.userIdentifier = userIdentifier
        self.teamName = teamName
        self.imageData = imageData
        self.teamImageData = teamImageData
        self.unreadConversationCount = unreadConversationCount
        self.loginCredentials = loginCredentials
        super.init()
    }
    
    public func updateWith(_ account: Account) {
        guard self.userIdentifier == account.userIdentifier else { return }
        self.userName = account.userName
        self.teamName = account.teamName
        self.imageData = account.imageData
        self.teamImageData = account.teamImageData
        self.loginCredentials = account.loginCredentials
    }
    
    public override func isEqual(_ object: Any?) -> Bool {
        guard let other = object as? Account else { return false }
        return userIdentifier == other.userIdentifier
    }
    
    public override var hash: Int {
        return userIdentifier.hashValue
    }
    
    public override var debugDescription: String {
        return "<Account>:\n\tname: \(userName)\n\tid: \(userIdentifier)\n\tcredentials:\n\t\(String(describing: loginCredentials?.debugDescription))\n\tteam: \(String(describing: teamName))\n\timage: \(String(describing: imageData?.count))\n\tteamImageData: \(String(describing: teamImageData?.count))\n"
    }
}

extension Account {
    func write(to url: URL) throws {
        let encoder = JSONEncoder()
        let data = try encoder.encode(self)
        try data.write(to: url, options: [.atomic])
    }
    
    static func load(from url: URL) -> Account? {
        let data = try? Data.init(contentsOf: url)
        let decoder = JSONDecoder.init()
        return data.flatMap({ try? decoder.decode(Account.self, from: $0) })
    }
}
