//
//  SSDevice.swift
//  SSKitSwiftCDemo
//
//  Created by Mac on 17/1/20.
//  Copyright © 2017年 YD. All rights reserved.
//

import Foundation
import UIKit

public extension UIDevice {
    ///系统的版本
    public class func systemVersion() -> Double {
        let version = Double.init(UIDevice.current.systemVersion)
        return version!
    }
    
    public func isPad() -> Bool {
        let isPad: Bool = UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad
        return isPad
    }
    
    public func isSimulator() -> Bool {
        var isSim = false
        #if arch(i386) || arch(x86_64)
            isSim = true
        #endif
        return isSim
    }
    
    public func isJailbroken() -> Bool {
        if (self.isSimulator()==true) {
            return false
        }
        let paths:Array = ["/Applications/Cydia.app",
                           "/private/var/lib/apt/",
                           "/private/var/lib/cydia",
                           "/private/var/stash"]
        for path in paths {
            if (FileManager.default.fileExists(atPath: path)) {
                return true
            }
        }
        /**
         let s = "/bin/bash"
         let cs = (s as NSString).utf8String
         let r = "r"
         let rs = (r as NSString).utf8String
         中间这个不会翻译
         FILE *bash = fopen("/bin/bash", "r");
         if (bash != NULL) {
         fclose(bash);
         return YES;
         }
         */
        //待验证
        let path:String = "/private/\(String.stringWithUUID())"
        do {
            let test:String = "test"
            try test.write(toFile: path, atomically: true, encoding: String.Encoding.utf8)
            if (FileManager.default.fileExists(atPath: path)) {
                return true
            }
        } catch {}
        return false
    }
    
    #if __IPHONE_OS_VERSION_MIN_REQUIRED
    public func canMakePhoneCalls() -> Bool {
    let can: Bool = false
    can = UIApplication.shared.canOpenURL(URL.init(string: "tel://"))
    return can
    }
    #endif
    
    public var modelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        switch identifier {
        case "iPod5,1":                                 return "iPod Touch 5"
        case "iPod7,1":                                 return "iPod Touch 6"
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":     return "iPhone 4"
        case "iPhone4,1":                               return "iPhone 4s"
        case "iPhone5,1", "iPhone5,2":                  return "iPhone 5"
        case "iPhone5,3", "iPhone5,4":                  return "iPhone 5c"
        case "iPhone6,1", "iPhone6,2":                  return "iPhone 5s"
        case "iPhone7,2":                               return "iPhone 6"
        case "iPhone7,1":                               return "iPhone 6 Plus"
        case "iPhone8,1":                               return "iPhone 6s"
        case "iPhone8,2":                               return "iPhone 6s Plus"
        case "iPhone8,4":                               return "iPhone 5SE"
        case "iPhone9,1":                               return "iPhone 7"
        case "iPhone9,2":                               return "iPhone 7 Plus"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":return "iPad 2"
        case "iPad3,1", "iPad3,2", "iPad3,3":           return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":           return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":           return "iPad Air"
        case "iPad5,3", "iPad5,4":                      return "iPad Air 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":           return "iPad Mini"
        case "iPad4,4", "iPad4,5", "iPad4,6":           return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":           return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":                      return "iPad Mini 4"
        case "iPad6,7", "iPad6,8":                      return "iPad Pro"
        case "AppleTV5,3":                              return "Apple TV"
        case "i386", "x86_64":                          return "Simulator"
        default:                                        return identifier
        }
    }
    
}

import AVFoundation
import AssetsLibrary
public extension UIImagePickerController {
    ///能否打开摄像头
    public var canOpenCamera: Bool {
        let mediaType: AVMediaType = AVMediaType.video
        let authStatus: AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: mediaType)
        if (authStatus==AVAuthorizationStatus.restricted || authStatus==AVAuthorizationStatus.denied) {
            return false
        }
        return true
    }
    ///能否打开相册
    public var canOpenPhotoLibaray: Bool {
        let author: ALAuthorizationStatus = ALAssetsLibrary.authorizationStatus()
        if (author==ALAuthorizationStatus.restricted || author==ALAuthorizationStatus.denied) { return false}
        return true
    }
}


public extension UIScreen {
    /// 获得屏幕的分辨率
    public var resolutionSize: CGSize {
        let screenSize: CGSize = UIScreen.main.bounds.size;
        let scale = UIScreen.main.scale
        return CGSize.init(width: screenSize.width * scale, height: screenSize.height * scale)
    }
}

public extension Bundle {
    public var preferredScales: [Float] {
        var scales: [Float]
        let screenScale: CGFloat = UIScreen.main.scale
        if screenScale <= 1 { scales = [1.0, 2.0, 3.0]}
        else if screenScale <= 2 { scales = [2.0, 3.0, 1.0]}
        else { scales = [3.0, 2.0, 1.0]}
        return scales
    }
}
