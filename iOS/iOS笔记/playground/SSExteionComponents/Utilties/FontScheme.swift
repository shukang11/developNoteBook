//
//  FontScheme.swift
//  playground
//
//  Created by tree on 2018/11/5.
//  Copyright © 2018 treee. All rights reserved.
//

import Foundation
import UIKit

public enum FontTextStyle: String {
    case largeTitle = "largeTitle"
    case inputText = "inputText"
}

public enum FontSize: String {
    case large  = "large"
    case normal = "normal"
    case medium = "medium"
    case small  = "small"
}

public enum FontWeight: String {
    case ultraLight = "ultraLight"
    case thin     = "thin"
    case light    = "light"
    case regular  = "regular"
    case medium   = "medium"
    case semibold = "semibold"
    case bold     = "bold"
    case heavy    = "heavy"
    case black    = "black"
}

public extension FontWeight {
    static let weightMapping: [FontWeight: UIFont.Weight] = [
        .ultraLight: UIFont.Weight.ultraLight,
        .thin:       UIFont.Weight.thin,
        .light:      UIFont.Weight.light,
        .regular:    UIFont.Weight.regular,
        .medium:     UIFont.Weight.medium,
        .semibold:   UIFont.Weight.semibold,
        .bold:       UIFont.Weight.bold,
        .heavy:      UIFont.Weight.heavy,
        .black:      UIFont.Weight.black
    ]
    
    static let accessibilityWeightMapping: [FontWeight: UIFont.Weight] = [
        .ultraLight: UIFont.Weight.regular,
        .thin:       UIFont.Weight.regular,
        .light:      UIFont.Weight.regular,
        .regular:    UIFont.Weight.regular,
        .medium:     UIFont.Weight.medium,
        .semibold:   UIFont.Weight.semibold,
        .bold:       UIFont.Weight.bold,
        .heavy:      UIFont.Weight.heavy,
        .black:      UIFont.Weight.black
    ]
    
    public func fontWeight(accessibilityBlodText: Bool? = nil) -> UIFont.Weight {
        let blodTextEnabled = accessibilityBlodText ?? UIAccessibility.isBoldTextEnabled
        let mapping = blodTextEnabled ? type(of: self).accessibilityWeightMapping : type(of: self).weightMapping
        return mapping[self]!
    }
    
    public init(weight: UIFont.Weight) {
        self = (type(of: self).weightMapping.filter({ $0.value == weight }).first?.key) ?? FontWeight.regular
    }
}

extension UIFont {
    public static func systemFont(ofSize size: CGFloat, contentSizeCategory: UIContentSizeCategory, weight: FontWeight) -> UIFont {
        if #available(iOSApplicationExtension 8.2, *) {
            return UIFont.systemFont(ofSize: round(size * UIFont.wr_preferredContentSizeMultiplier(for: contentSizeCategory)), weight: weight.fontWeight())
        }else {
            return UIFont.systemFont(ofSize: round(size * UIFont.wr_preferredContentSizeMultiplier(for: contentSizeCategory)))
        }
    }
    
    @objc public var classyStemFontName: String {
        get {
            let weightSpeciifier = { () -> String in
                guard #available(iOSApplicationExtension 8.2, *),
                    let traits = self.fontDescriptor.object(forKey: .traits) as? NSDictionary,
                    let floatWeight = traits[UIFontDescriptor.TraitKey.weight] as? NSNumber else {
                    return ""
                }
                return "-\(FontWeight.init(weight: .init(rawValue: CGFloat(floatWeight.floatValue))).rawValue.capitalized)"
            }()
            return "System\(weightSpeciifier) \(self.pointSize)"
        }
    }
}

public struct FontSpec: Hashable {
    public let size: FontSize
    
    public let weight: FontWeight?
    
    public let fontTextStyle: FontTextStyle?
    
    // a optional value has none, some ... types
    public init(_ size: FontSize, _ weight: FontWeight?, _ fontTextStyle: FontTextStyle? = .none) {
        self.size = size
        self.weight = weight
        self.fontTextStyle = fontTextStyle
    }
}

extension FontSpec {
    var fontWithoutDynamicType: UIFont? {
        return FontScheme(contentSizeCategory: .medium).font(for: self)
    }
}

#if !swift(>=4.2)
extension FontSpec {
    public var hashValue: Int {
        return self.size.hashValue &* 1000 &+ (self.weight?.hashValue ?? 100)
    }
}
#endif

extension FontSpec {
    public var font: UIFont? {
        return defaultFontScheme.font(for: self)
    }
}

extension FontSpec: CustomStringConvertible {
    public var description: String {
        get {
            var descriptionString = "\(self.size)"
            
            if let weight = self.weight {
                descriptionString += "-\(weight)"
            }
            
            if let fontTextStyle = self.fontTextStyle {
                descriptionString += "-\(fontTextStyle.rawValue)"
            }
            
            return descriptionString
        }
    }
}

public func ==(left: FontSpec, right: FontSpec) -> Bool {
    return left.size == right.size
        && left.weight == right.weight
        && left.fontTextStyle == right.fontTextStyle
}

@objcMembers public final class FontScheme {
    public typealias FontMapping = [FontSpec: UIFont]
    
    public var fontMapping: FontMapping = [:]
    
    fileprivate static func mapFontTextStyleAndFontSizeAndPoint(fintSizeTuples allFontSizes: [(fontSize: FontSize, point: CGFloat)], mapping: inout [FontSpec : UIFont], fontTextStyle: FontTextStyle, contentSizeCategory: UIContentSizeCategory) {
        let allFontWeights: [FontWeight] = [.ultraLight, .thin, .light, .regular, .medium, .semibold, .bold, .heavy, .black]
        for fontWeight in allFontWeights {
            for fontSizeTuple in allFontSizes {
                mapping[FontSpec(fontSizeTuple.fontSize, .none, fontTextStyle)] = UIFont.systemFont(ofSize: fontSizeTuple.point, contentSizeCategory: contentSizeCategory, weight: .light)
                mapping[FontSpec(fontSizeTuple.fontSize, fontWeight, fontTextStyle)] = UIFont.systemFont(ofSize: fontSizeTuple.point, contentSizeCategory: contentSizeCategory, weight: fontWeight)
            }
        }
    }

    public static func defaultFontMapping(with contentSizeCategory: UIContentSizeCategory) -> FontMapping {
        var mapping: FontMapping = [:]
        // the ratio is following 11:12:16:24, same as default case
        let largeTitleFontSizeTuples: [(fontSize: FontSize, point: CGFloat)] = [(fontSize: .large, point: 40),
                                                                                (fontSize: .normal, point: 26),
                                                                                (fontSize: .medium, point: 20),
                                                                                (fontSize: .small, point: 18)]
        mapFontTextStyleAndFontSizeAndPoint(fintSizeTuples: largeTitleFontSizeTuples, mapping: &mapping, fontTextStyle: .largeTitle, contentSizeCategory: contentSizeCategory)
        
        let inputTextFontSizeTuples: [(fontSize: FontSize, point: CGFloat)] = [(fontSize: .large,  point: 21),
                                                                               (fontSize: .normal, point: 14),
                                                                               (fontSize: .medium, point: 11),
                                                                               (fontSize: .small,  point: 10)]
        mapFontTextStyleAndFontSizeAndPoint(fintSizeTuples: inputTextFontSizeTuples, mapping: &mapping, fontTextStyle: .inputText, contentSizeCategory: contentSizeCategory)
        
        // fontTextStyle: none
        mapping[FontSpec(.large, .none, .none)]      = UIFont.systemFont(ofSize: 24, contentSizeCategory: contentSizeCategory, weight: .light)
        mapping[FontSpec(.large, .medium, .none)]    = UIFont.systemFont(ofSize: 24, contentSizeCategory: contentSizeCategory, weight: .medium)
        mapping[FontSpec(.large, .semibold, .none)]  = UIFont.systemFont(ofSize: 24, contentSizeCategory: contentSizeCategory, weight: .semibold)
        mapping[FontSpec(.large, .regular, .none)]   = UIFont.systemFont(ofSize: 24, contentSizeCategory: contentSizeCategory, weight: .regular)
        mapping[FontSpec(.large, .light, .none)]     = UIFont.systemFont(ofSize: 24, contentSizeCategory: contentSizeCategory, weight: .light)
        mapping[FontSpec(.large, .thin, .none)]      = UIFont.systemFont(ofSize: 24, contentSizeCategory: contentSizeCategory, weight: .thin)
        
        mapping[FontSpec(.normal, .none, .none)]     = UIFont.systemFont(ofSize: 16, contentSizeCategory: contentSizeCategory, weight: .light)
        mapping[FontSpec(.normal, .light, .none)]    = UIFont.systemFont(ofSize: 16, contentSizeCategory: contentSizeCategory, weight: .light)
        mapping[FontSpec(.normal, .thin, .none)]     = UIFont.systemFont(ofSize: 16, contentSizeCategory: contentSizeCategory, weight: .thin)
        mapping[FontSpec(.normal, .regular, .none)]  = UIFont.systemFont(ofSize: 16, contentSizeCategory: contentSizeCategory, weight: .regular)
        mapping[FontSpec(.normal, .semibold, .none)] = UIFont.systemFont(ofSize: 16, contentSizeCategory: contentSizeCategory, weight: .semibold)
        mapping[FontSpec(.normal, .medium, .none)]   = UIFont.systemFont(ofSize: 16, contentSizeCategory: contentSizeCategory, weight: .medium)
        
        mapping[FontSpec(.medium, .none, .none)]     = UIFont.systemFont(ofSize: 12, contentSizeCategory: contentSizeCategory, weight: .light)
        mapping[FontSpec(.medium, .medium, .none)]   = UIFont.systemFont(ofSize: 12, contentSizeCategory: contentSizeCategory, weight: .medium)
        mapping[FontSpec(.medium, .semibold, .none)] = UIFont.systemFont(ofSize: 12, contentSizeCategory: contentSizeCategory, weight: .semibold)
        mapping[FontSpec(.medium, .regular, .none)]  = UIFont.systemFont(ofSize: 12, contentSizeCategory: contentSizeCategory, weight: .regular)
        
        mapping[FontSpec(.small, .none, .none)]      = UIFont.systemFont(ofSize: 11, contentSizeCategory: contentSizeCategory, weight: .light)
        mapping[FontSpec(.small, .medium, .none)]    = UIFont.systemFont(ofSize: 11, contentSizeCategory: contentSizeCategory, weight: .medium)
        mapping[FontSpec(.small, .semibold, .none)]  = UIFont.systemFont(ofSize: 11, contentSizeCategory: contentSizeCategory, weight: .semibold)
        mapping[FontSpec(.small, .regular, .none)]   = UIFont.systemFont(ofSize: 11, contentSizeCategory: contentSizeCategory, weight: .regular)
        mapping[FontSpec(.small, .light, .none)]     = UIFont.systemFont(ofSize: 11, contentSizeCategory: contentSizeCategory, weight: .light)
        return mapping
    }
    
    convenience init(contentSizeCategory: UIContentSizeCategory) {
        self.init(fontMapping: type(of: self).defaultFontMapping(with: contentSizeCategory))
    }
    
    public init(fontMapping: FontMapping) {
        self.fontMapping = fontMapping
    }
    
    public func font(for fontType: FontSpec) -> UIFont? {
        return self.fontMapping[fontType]
    }
}

public var defaultFontScheme: FontScheme = FontScheme.init(contentSizeCategory: UIApplication.shared.preferredContentSizeCategory)
