//
//  SettingsPropertyName.swift
//  playground
//
//  Created by tree on 2018/11/7.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation

/**
 Available settings
 
 - ChatHeadsDisabled:      Disable chat heads in conversation and self profile
 - DisableMarkdown:        Disable markdown formatter for messages
 - DarkMode:               Dark mode for conversation
 - PriofileName:           User name
 - SoundAlerts:            Sound alerts level
 - DisableCrashAndAnalyticsSharing: Opt-Out analytics and Hockey
 - DisableSendButton:      Opt-Out of new send button
 - DisableLinkPreviews:    Disable link previews for links you send
 - Disable(.*):            Disable some app features (debug)
 */

public enum SettingsPropertyName: String, CustomStringConvertible {
    // User defaults
    case chatHeadsDisabled = "ChatHeadsDisabled"
    case notificationContentVisible = "NotificationContentVisible"
    case disableMarkdown = "Markdown"
    
    case darkMode = "DarkMode"
    
    case disableSendButton = "DisableSendButton"
    
    case disableLinkPreviews = "DisableLinkPreviews"
    
    // Profile
    case profileName = "ProfileName"
    case accentColor = "AccentColor"
    
    // AVS
    case soundAlerts = "SoundAlerts"
    case callingConstantBitRate = "constantBitRate"
    
    // Sounds
    case messageSoundName = "MessageSoundName"
    case callSoundName = "CallSoundName"
    case pingSoundName = "PingSoundName"
    
    // Open In
    case tweetOpeningOption = "TweetOpeningOption"
    case mapsOpeningOption = "MapsOpeningOption"
    case browserOpeningOption = "BrowserOpeningOption"
    
    // Persoanl Information
    // Analytics
    case disableCrashAndAnalyticsSharing = "DisableCrashAndAnalyticsSharing"
    case receiveNewsAndOffers = "ReceiveNewsAndOffers"
    
    // Debug
    case disableCallKit = "DisableCallKit"
    case callingProtocolStrategy = "CallingProtcolStrategy"
    case enableBatchCollections = "EnableBatchCollections"
    
    case lockApp = "lockApp"
    case lockAppLastDate = "lockAppLastDate"
    
    public var changeNotificationName: String {
        return self.description + "ChangeNotification"
    }
    
    public var description: String {
        return self.rawValue;
    }
}
