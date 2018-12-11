//
//  SSFont.swift
//  SSKitSwiftCDemo
//
//  Created by Mac on 17/1/20.
//  Copyright © 2017年 YD. All rights reserved.
//

import Foundation
import UIKit

public extension UIFont {
    
    //MARK:Method
    public class func canFindFont(_ fontName:String, _ printInfo:Bool = false) -> Bool {
        let familyNames:[String] = UIFont.familyNames
        var fontNames:[String]
        for familyName in familyNames {
            if (printInfo) { print("Family name ：\(familyName)")}
            if (familyName==fontName) { return true}
            fontNames = UIFont.fontNames(forFamilyName: familyName)
            for tempFontName in fontNames {
                if (printInfo) { print("Font name ：\(tempFontName)")}
                if (tempFontName==fontName) { return true}
            }
        }
        return false
    }
}
