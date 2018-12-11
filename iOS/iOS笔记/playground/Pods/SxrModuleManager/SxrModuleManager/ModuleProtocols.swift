//
//  ModuleProtocols.swift
//  pandaMaMa
//
//  Created by tree on 2018/1/29.
//  Copyright © 2018年 tree. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit

@objc public protocol HookModuleProtocol: UIApplicationDelegate, UNUserNotificationCenterDelegate where Self : NSObject {}


public final class HookM<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public protocol SingletonProtocol {
    static var shared: Self { get }
}

public extension HookModuleProtocol {
    public var hm: HookM<Self> {
        get { return HookM(self) }
    }
}

