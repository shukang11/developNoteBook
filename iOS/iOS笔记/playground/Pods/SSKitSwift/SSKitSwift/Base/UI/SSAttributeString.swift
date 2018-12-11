//
//  SSAttributeString.swift
//  pandaMaMa
//
//  Created by tree on 2017/8/16.
//  Copyright © 2017年 tree. All rights reserved.
//

import Foundation
import UIKit
import CoreText

extension NSAttributedString {
    
    @discardableResult
    func ss_attributesAtIndex(index: Int) -> Dictionary<NSAttributedString.Key, Any>? {
        guard (index < self.length || index >= 0) else { return nil }
        var calculateIndex = index
        if self.length > 0 && index == self.length { calculateIndex = calculateIndex - 1 }
        return self.attributes(at: index, effectiveRange: nil)
    }
    
    @discardableResult
    func ss_attribute(attributeName: NSAttributedString.Key, At index:Int) -> Any? {
        guard index < self.length || index >= 0 else { return nil }
        var calculateIndex = index
        if self.length > 0 && index == self.length { calculateIndex = calculateIndex - 1 }
        return self.attribute(attributeName, at: calculateIndex, effectiveRange: nil)
    }
    
    @discardableResult
    func ss_attributes() -> [NSAttributedString.Key: Any]? {
        return self.ss_attributesAtIndex(index: 0)
    }
    
    var ss_Font: UIFont? {
        return ss_font(At: 0)
    }
    @discardableResult
    func ss_font(At index: Int) -> UIFont? {
        return ss_attribute(attributeName: .font, At: index) as? UIFont
    }
    
    var ss_Color: UIColor? {
        return ss_color(At: 0)
    }
    @discardableResult
    func ss_color(At index: Int) -> UIColor? {
        return ss_attribute(attributeName: .foregroundColor, At: index) as? UIColor
    }
    
    var ss_BackgroundColor: UIColor? {
        return ss_backgroundColor(At: 0)
    }
    @discardableResult
    func ss_backgroundColor(At index:Int) -> UIColor? {
        return ss_attribute(attributeName: .backgroundColor, At: index) as? UIColor
    }
    
    var ss_Kern: NSNumber? {
        return ss_kern(At: 0)
    }
    @discardableResult
    func ss_kern(At index:Int) -> NSNumber? {
        return ss_attribute(attributeName: .kern, At: index) as? NSNumber
    }
    
    var ss_Shadow: NSShadow? {
        return ss_shadow(At: 0)
    }
    @discardableResult
    func ss_shadow(At index:Int) -> NSShadow? {
        return ss_attribute(attributeName: .shadow, At: index) as? NSShadow
    }
    
    var ss_StrokeWidth: NSNumber? {
        return ss_strokeWidth(At: 0)
    }
    @discardableResult
    func ss_strokeWidth(At index:Int) -> NSNumber? {
        return ss_attribute(attributeName: .strokeWidth, At: index) as? NSNumber
    }
    
    var ss_StrokeColor: UIColor? {
        return ss_strokeColor(At: 0)
    }
    @discardableResult
    func ss_strokeColor(At index:Int) -> UIColor? {
        return ss_attribute(attributeName: .strokeColor, At: index) as? UIColor
    }
    
    var ss_StrikenthroughStyle: NSUnderlineStyle? {
        get { return ss_strikenthroughStyle(At: 0) }
    }
    @discardableResult
    func ss_strikenthroughStyle(At index:Int) -> NSUnderlineStyle? {
        return ss_attribute(attributeName: .strikethroughStyle, At: index) as? NSUnderlineStyle
    }
    
    var ss_StrikenthroughColor: UIColor? {
        return ss_strikenthroughColor(At: 0)
    }
    @discardableResult
    func ss_strikenthroughColor(At index:Int) -> UIColor? {
        return ss_attribute(attributeName: .strikethroughColor, At: index) as? UIColor
    }
    
    var ss_UnderlineStyle: NSUnderlineStyle? {
        return ss_underlineStyle(At: 0)
    }
    @discardableResult
    func ss_underlineStyle(At index:Int) -> NSUnderlineStyle? {
        return ss_attribute(attributeName: .underlineStyle, At: index) as? NSUnderlineStyle
    }
    
    var ss_UnderlineColor: UIColor? {
        return ss_underlineColor(At: 0)
    }
    @discardableResult
    func ss_underlineColor(At index:Int) -> UIColor? {
        return ss_attribute(attributeName: .underlineColor, At: index) as? UIColor
    }
    
    var ss_TextEffect: String? {
        return ss_textEffect(At: 0)
    }
    @discardableResult
    func ss_textEffect(At index:Int) -> String? {
        return ss_attribute(attributeName: .textEffect, At: index) as? String
    }
    
    var ss_Ligature: NSNumber? {
        return ss_ligature(At: 0)
    }
    @discardableResult
    func ss_ligature(At index:Int) -> NSNumber? {
        return ss_attribute(attributeName: .ligature, At: index) as? NSNumber
    }
    
    var ss_Obliqueness: NSNumber? {
        return ss_obliqueness(At: 0)
    }
    @discardableResult
    func ss_obliqueness(At index:Int) -> NSNumber? {
        return ss_attribute(attributeName: .obliqueness, At: index) as? NSNumber
    }
    
    var ss_Expansion: NSNumber? {
        return ss_expansion(At: 0)
    }
    @discardableResult
    func ss_expansion(At index:Int) -> NSNumber? {
        return ss_attribute(attributeName: .expansion, At: index) as? NSNumber
    }
    
    var ss_BaselineOffset: NSNumber? {
        return ss_baselineOffset(At: 0)
    }
    @discardableResult
    func ss_baselineOffset(At index:Int) -> NSNumber? {
        return ss_attribute(attributeName: .baselineOffset, At: index) as? NSNumber
    }
    
    var ss_VerticalGlyphFrom: Bool? {
        return ss_verticalGlyphFrom(At: 0)
    }
    @discardableResult
    func ss_verticalGlyphFrom(At index:Int) -> Bool? {
        return ss_attribute(attributeName: .verticalGlyphForm, At: index) as? Bool
    }
    
    var ss_Language: String? {
        return ss_language(At: 0)
    }
    @discardableResult
    func ss_language(At index:Int) -> String? {
        return ss_attribute(attributeName: NSAttributedString.Key(rawValue: kCTLanguageAttributeName as String), At: index) as? String
    }
    
    var ss_WritingDirection: [NSNumber]? {
        return ss_writingDirection(At: 0)
    }
    @discardableResult
    func ss_writingDirection(At index:Int) -> [NSNumber]? {
        return ss_attribute(attributeName: NSAttributedString.Key(kCTWritingDirectionAttributeName as String), At: index) as? [NSNumber]
    }
    
    var ss_ParagraphStyle: NSParagraphStyle? {
        return ss_paragraphStyle(At: 0)
    }
    @discardableResult
    func ss_paragraphStyle(At index:Int) -> NSParagraphStyle? {
        return ss_attribute(attributeName: .paragraphStyle, At: index) as? NSParagraphStyle
    }
    
    var ss_TextAlignment: NSTextAlignment {
        return ss_textAlignment(At: 0)
    }
    @discardableResult
    func ss_textAlignment(At index:Int) ->NSTextAlignment {
        guard let style = ss_paragraphStyle(At: index) else {
            return NSParagraphStyle.default.alignment
        }
        return style.alignment
    }
    
    var ss_LineBreakMode: NSLineBreakMode {
        return ss_lineBreakMode(At: 0)
    }
    @discardableResult
    func ss_lineBreakMode(At index:Int) ->NSLineBreakMode {
        guard let style = ss_paragraphStyle(At: index) else {
            return NSParagraphStyle.default.lineBreakMode
        }
        return style.lineBreakMode
    }
    
    var ss_LineSpacing: CGFloat {
        return ss_lineSpacing(At: 0)
    }
    @discardableResult
    func ss_lineSpacing(At index:Int) ->CGFloat {
        guard let style = ss_paragraphStyle(At: index) else {
            return NSParagraphStyle.default.lineSpacing
        }
        return style.lineSpacing
    }
    
    var ss_ParagraphSpacing: CGFloat {
        return ss_paragraphSpacing(At: 0)
    }
    @discardableResult
    func ss_paragraphSpacing(At index:Int) ->CGFloat {
        guard let style = ss_paragraphStyle(At: index) else {
            return NSParagraphStyle.default.paragraphSpacing
        }
        return style.paragraphSpacing
    }
    
    var ss_ParagraphSpacingBefore: CGFloat {
        return ss_paragraphSpacingBefore(At: 0)
    }
    @discardableResult
    func ss_paragraphSpacingBefore(At index:Int) ->CGFloat {
        guard let style = ss_paragraphStyle(At: index) else {
            return NSParagraphStyle.default.paragraphSpacingBefore
        }
        return style.paragraphSpacingBefore
    }
    
    var ss_FirstLineHeadIndent: CGFloat {
        return ss_firstLineHeadIndent(At: 0)
    }
    @discardableResult
    func ss_firstLineHeadIndent(At index:Int) ->CGFloat {
        guard let style = ss_paragraphStyle(At: index) else {
            return NSParagraphStyle.default.firstLineHeadIndent
        }
        return style.firstLineHeadIndent
    }
    
    var ss_HeadIndent: CGFloat {
        return ss_headIndent(At: 0)
    }
    @discardableResult
    func ss_headIndent(At index:Int) ->CGFloat {
        guard let style = ss_paragraphStyle(At: index) else {
            return NSParagraphStyle.default.headIndent
        }
        return style.headIndent
    }
    
    var ss_TailIndent: CGFloat {
        return ss_tailIndent(At: 0)
    }
    @discardableResult
    func ss_tailIndent(At index:Int) ->CGFloat {
        guard let style = ss_paragraphStyle(At: index) else {
            return NSParagraphStyle.default.tailIndent
        }
        return style.tailIndent
    }
    
    var ss_MinimumLineHeight: CGFloat {
        return ss_minimumLineHeight(At: 0)
    }
    @discardableResult
    func ss_minimumLineHeight(At index:Int) ->CGFloat {
        guard let style = ss_paragraphStyle(At: index) else {
            return NSParagraphStyle.default.minimumLineHeight
        }
        return style.minimumLineHeight
    }
    
    var ss_MaximumLineHeight: CGFloat {
        return ss_maximumLineHeight(At: 0)
    }
    @discardableResult
    func ss_maximumLineHeight(At index:Int) ->CGFloat {
        guard let style = ss_paragraphStyle(At: index) else {
            return NSParagraphStyle.default.maximumLineHeight
        }
        return style.maximumLineHeight
    }
    
    var ss_LineHeightMultiple: CGFloat {
        return ss_lineHeightMultiple(At: 0)
    }
    @discardableResult
    func ss_lineHeightMultiple(At index:Int) ->CGFloat {
        guard let style = ss_paragraphStyle(At: index) else {
            return NSParagraphStyle.default.lineHeightMultiple
        }
        return style.lineHeightMultiple
    }
    
    var ss_BaseWritingDirection: NSWritingDirection {
        return ss_baseWritingDirection(At: 0)
    }
    @discardableResult
    func ss_baseWritingDirection(At index:Int) ->NSWritingDirection {
        guard let style = ss_paragraphStyle(At: index) else {
            return NSParagraphStyle.default.baseWritingDirection
        }
        return style.baseWritingDirection
    }
    
    var ss_HyphenationFactor: Float {
        return ss_hyphenationFactor(At: 0)
    }
    @discardableResult
    func ss_hyphenationFactor(At index:Int) ->Float {
        guard let style = ss_paragraphStyle(At: index) else {
            return NSParagraphStyle.default.hyphenationFactor
        }
        return style.hyphenationFactor
    }
    
    var ss_DefaultTabInterval: CGFloat {
        return ss_defaultTabInterval(At: 0)
    }
    @discardableResult
    func ss_defaultTabInterval(At index:Int) ->CGFloat {
        guard let style = ss_paragraphStyle(At: index) else {
            return NSParagraphStyle.default.defaultTabInterval
        }
        return style.defaultTabInterval
    }
    
    var ss_TabStops: [NSTextTab] {
        return ss_tabStops(At: 0)
    }
    @discardableResult
    func ss_tabStops(At index:Int) ->[NSTextTab] {
        guard let style = ss_paragraphStyle(At: index) else {
            return NSParagraphStyle.default.tabStops
        }
        return style.tabStops
    }
    
}


//MARK:-
//MARK:NSMutableAttributedString
extension NSMutableAttributedString {
    
    func ss_setAttibutes(attributes: Dictionary<NSAttributedString.Key, Any>) {
        self.setSs_attributes(attributes: attributes)
    }
    
    func setSs_attributes(attributes: Dictionary<NSAttributedString.Key, Any>) {
        self.setAttributes([:], range: NSRange.init(location: 0, length: self.length))
        for (key, value) in attributes {
            self.ss_setAttribute(name: key, value: value)
        }
    }
    
    func ss_setAttribute(name: NSAttributedString.Key, value: Any) {
        self.ss_setAttribute(name: name, value: value, range: NSRange.init(location: 0, length: self.length))
    }
    
    func ss_setAttribute(name: NSAttributedString.Key, value: Any, range: NSRange) {
        self.addAttribute(name, value: value, range: range)
    }
    
    func ss_removeAttributesInRange(range: NSRange) {
        self.setAttributes(nil, range: range)
    }
    
    //MARK:-
    //MARK:property setter
    var ss_font: UIFont {
        get {
            guard let font: UIFont = ss_font(At: 0) else { return UIFont.systemFont(ofSize: UIFont.systemFontSize) }
            return font
        }
        set {
            ss_setFont(value: newValue, range: NSRange.init(location: 0, length: self.length))
        }
    }
    
    func ss_setFont(value: UIFont, range: NSRange) {
        ss_setAttribute(name: .font, value: value, range: range)
    }
    
    var ss_color: UIColor? {
        get { return ss_color(At: 0) }
        set {
            guard let color = newValue else { return }
            ss_setColor(value: color, range: NSRange.init(location: 0, length: self.length))
        }
    }
    func ss_setColor(value: UIColor, range: NSRange) {
        ss_setAttribute(name: .foregroundColor, value: value, range: range)
    }
    
    var ss_backgroundColor: UIColor? {
        get { return ss_backgroundColor(At: 0) }
        set {
            guard let value = newValue else { return }
            ss_setBackgroundColor(value: value, range: NSRange.init(location: 0, length: self.length))
        }
    }
    func ss_setBackgroundColor(value: UIColor, range: NSRange) {
        ss_setAttribute(name: .backgroundColor, value: value, range: range)
    }
    
    var ss_kern: NSNumber? {
        get { return ss_kern(At: 0) }
        set {
            guard let value = newValue else { return }
            ss_setKern(value: value, range: NSRange.init(location: 0, length: self.length))
        }
    }
    func ss_setKern(value: NSNumber, range: NSRange) {
        ss_setAttribute(name: .kern, value: value, range: range)
    }
    
    var ss_shadow: NSShadow? {
        get { return ss_shadow(At: 0) }
        set {
            guard let value = newValue else { return }
            ss_setShadow(value: value, range: NSRange.init(location: 0, length: self.length))
        }
    }
    func ss_setShadow(value: NSShadow, range: NSRange) {
        ss_setAttribute(name: .shadow, value: value, range: range)
    }
    
    var ss_strokeWidth: NSNumber? {
        get { return ss_strokeWidth(At: 0) }
        set {
            guard let value = newValue else { return }
            ss_setStrokeWidth(value: value, range: NSRange.init(location: 0, length: self.length))
        }
    }
    func ss_setStrokeWidth(value: NSNumber, range: NSRange) {
        ss_setAttribute(name: .strokeWidth, value: value, range: range)
    }
    
    var ss_strokeColor: UIColor? {
        get { return ss_strokeColor(At: 0) }
        set {
            guard let value = newValue else { return }
            ss_setStrokeColor(value: value, range: NSRange.init(location: 0, length: self.length))
        }
    }
    func ss_setStrokeColor(value: UIColor, range: NSRange) {
        ss_setAttribute(name: .strokeColor, value: value, range: range)
    }
    
    
    var ss_strikenthroughStyle: NSUnderlineStyle? {
        get { return ss_strikenthroughStyle(At: 0) }
        set {
            guard let value = newValue else { return }
            ss_setStrikenthroughStyle(value: value, range: NSRange.init(location: 0, length: self.length))
        }
    }
    func ss_setStrikenthroughStyle(value: NSUnderlineStyle, range: NSRange) {
        ss_setAttribute(name: .strikethroughStyle, value: value, range: range)
    }
    
    var ss_strikenthroughColor: UIColor? {
        get { return ss_strikenthroughColor(At: 0 )}
        set {
            guard let value = newValue else { return }
            ss_setStrikenthroughColor(value: value, range: NSRange.init(location: 0, length: self.length))
        }
    }
    func ss_setStrikenthroughColor(value: UIColor, range: NSRange) {
        ss_setAttribute(name: .strikethroughColor, value: value, range: range)
    }
    
    var ss_underlineStyle: NSUnderlineStyle? {
        get { return ss_underlineStyle(At: 0) }
        set {
            guard let value = newValue else { return }
            ss_setUnderlinestyle(value: value, range: NSRange.init(location: 0, length: self.length))
        }
    }
    func ss_setUnderlinestyle(value: NSUnderlineStyle, range: NSRange) {
        ss_setAttribute(name: .underlineStyle, value: value, range: range)
    }
    
    var ss_underlineColor: UIColor? {
        get { return ss_underlineColor(At: 0) }
        set {
            guard let value = newValue else { return }
            ss_setUnderlineColor(value: value, range: NSRange.init(location: 0, length: self.length))
        }
    }
    func ss_setUnderlineColor(value: UIColor, range: NSRange) {
        ss_setAttribute(name: .underlineColor, value: value, range: range)
    }
    
    var ss_textEffect: String? {
        get { return ss_textEffect(At: 0) }
        set {
            guard let value = newValue else { return }
            ss_setTextEffect(value: value, range: NSRange.init(location: 0, length: self.length))
        }
    }
    func ss_setTextEffect(value: String, range: NSRange) {
        ss_setAttribute(name: .textEffect, value: value, range: range)
    }
    
    var ss_ligature: NSNumber? {
        get { return ss_ligature(At: 0) }
        set {
            guard let value = newValue else { return }
            ss_setTextLigature(value: value, range: NSRange.init(location: 0, length: self.length))
        }
    }
    func ss_setTextLigature(value: NSNumber, range: NSRange) {
        ss_setAttribute(name: .ligature, value: value, range: range)
    }
    
    var ss_obliqueness: NSNumber? {
        get { return ss_obliqueness(At: 0) }
        set {
            guard let value = newValue else { return }
            ss_setObliqueness(value: value, range: NSRange.init(location: 0, length: self.length))
        }
    }
    func ss_setObliqueness(value: NSNumber, range: NSRange) {
        ss_setAttribute(name: .obliqueness, value: value, range: range)
    }
    
    var ss_expansion: NSNumber? {
        get { return ss_expansion(At: 0) }
        set {
            guard let value = newValue else { return }
            ss_setExpansion(value: value, range: NSRange.init(location: 0, length: self.length))
        }
    }
    func ss_setExpansion(value: NSNumber, range: NSRange) {
        ss_setAttribute(name: .expansion, value: value, range: range)
    }

    var ss_baselineOffset: NSNumber? {
        get { return ss_baselineOffset(At: 0) }
        set {
            guard let value = newValue else { return }
            ss_setBaselineOffset(value: value, range: NSRange.init(location: 0, length: self.length))
        }
    }
    func ss_setBaselineOffset(value: NSNumber, range: NSRange) {
        ss_setAttribute(name: .baselineOffset, value: value, range: range)
    }
    
    var ss_verticalGlyphFrom: Bool? {
        get { return ss_verticalGlyphFrom(At: 0) }
        set {
            guard let value = newValue else { return }
            ss_setVerticalGlyphFrom(value: value, range: NSRange.init(location: 0, length: self.length))
        }
    }
    func ss_setVerticalGlyphFrom(value: Bool, range: NSRange) {
        ss_setAttribute(name: .verticalGlyphForm, value: value, range: range)
    }
    
    var ss_language: String? {
        get { return ss_language(At: 0) }
        set {
            guard let value = newValue else { return }
            ss_setLanguage(value: value, range: NSRange.init(location: 0, length: self.length))
        }
    }
    func ss_setLanguage(value: String, range: NSRange) {
        ss_setAttribute(name: NSAttributedString.Key(rawValue: kCTLanguageAttributeName as String), value: value, range: range)
    }
    
    var ss_writingDirection: [NSNumber]? {
        get { return ss_writingDirection(At: 0) }
        set {
            guard let value = newValue else { return }
            ss_setWritingDirection(value: value, range: NSRange.init(location: 0, length: self.length))
        }
    }
    func ss_setWritingDirection(value: [NSNumber], range: NSRange) {
        ss_setAttribute(name: NSAttributedString.Key(kCTWritingDirectionAttributeName as String), value: value, range: range)
    }
    
    var ss_paragraphStyle: NSParagraphStyle? {
        get { return ss_paragraphStyle(At: 0) }
        set {
            guard let value = newValue else { return }
            ss_setParagraphStyle(value: value, range: NSRange.init(location: 0, length: self.length))
        }
    }
    func ss_setParagraphStyle(value: NSParagraphStyle, range: NSRange) {
        ss_setAttribute(name: .paragraphStyle, value: value, range: range)
    }
    
    
    private func ss_paragraphStyleSet(range: NSRange, block:(_ mutableParagraphStyle: NSMutableParagraphStyle) -> NSMutableParagraphStyle) {
        self.enumerateAttribute(.paragraphStyle, in: range, options: [.longestEffectiveRangeNotRequired]) { (subStyle, subRange, stop) in
            var mutableParagraphStyle: NSMutableParagraphStyle
            if let paragraphStyle = subStyle as? NSParagraphStyle {
                mutableParagraphStyle = (paragraphStyle.mutableCopy() as? NSMutableParagraphStyle)!
            }else if ((subStyle as? NSMutableParagraphStyle) != nil) {
                mutableParagraphStyle = subStyle as! NSMutableParagraphStyle
            }else {
                mutableParagraphStyle = NSMutableParagraphStyle()
            }
            mutableParagraphStyle = block(mutableParagraphStyle)
            ss_setAttribute(name: .paragraphStyle, value: mutableParagraphStyle, range: range)
        }
    }
    
    var ss_textAlignment: NSTextAlignment {
        get { return ss_textAlignment(At: 0) }
        set {
            ss_setTextAlignment(value: newValue, range: NSRange.init(location: 0, length: self.length))
        }
    }
    func ss_setTextAlignment(value: NSTextAlignment, range: NSRange) {
        ss_paragraphStyleSet(range: range) { (style) -> NSMutableParagraphStyle in
            style.alignment = value
            return style
        }
    }
    
    var ss_lineBreakMode: NSLineBreakMode {
        get { return ss_lineBreakMode(At: 0) }
        set {
            ss_setLineBreakMode(value: newValue, range: NSRange.init(location: 0, length: self.length))
        }
    }
    func ss_setLineBreakMode(value: NSLineBreakMode, range: NSRange) {
        ss_paragraphStyleSet(range: range) { (style) -> NSMutableParagraphStyle in
            style.lineBreakMode = value
            return style
        }
    }
    
    var ss_lineSpacing: CGFloat {
        get { return ss_lineSpacing(At: 0) }
        set {
            ss_setLineSpacing(value: newValue, range: NSRange.init(location: 0, length: self.length))
        }
    }
    func ss_setLineSpacing(value: CGFloat, range: NSRange) {
        ss_paragraphStyleSet(range: range) { (style) -> NSMutableParagraphStyle in
            style.lineSpacing = value
            return style
        }
    }
    
    var ss_paragraphSpacing: CGFloat {
        get { return ss_paragraphSpacing(At: 0) }
        set {
            ss_setParagraphSpacing(value: newValue, range: NSRange.init(location: 0, length: self.length))
        }
    }
    func ss_setParagraphSpacing(value: CGFloat, range: NSRange) {
        ss_paragraphStyleSet(range: range) { (style) -> NSMutableParagraphStyle in
            style.paragraphSpacing = value
            return style
        }
    }
    
    var ss_paragraphSpacingBefore: CGFloat {
        get { return ss_paragraphSpacingBefore(At: 0) }
        set {
            ss_setParagraphSpacingBefore(value: newValue, range: NSRange.init(location: 0, length: self.length))
        }
    }
    func ss_setParagraphSpacingBefore(value: CGFloat, range: NSRange) {
        ss_paragraphStyleSet(range: range) { (style) -> NSMutableParagraphStyle in
            style.paragraphSpacingBefore = value
            return style
        }
    }
    
    var ss_firstLineHeadIndent: CGFloat {
        get { return ss_firstLineHeadIndent(At: 0) }
        set {
            ss_setFirstLineHeadIndent(value: newValue, range: NSRange.init(location: 0, length: self.length))
        }
    }
    func ss_setFirstLineHeadIndent(value: CGFloat, range: NSRange) {
        ss_paragraphStyleSet(range: range) { (style) -> NSMutableParagraphStyle in
            style.firstLineHeadIndent = value
            return style
        }
    }
    
    var ss_headIndent: CGFloat {
        get { return ss_headIndent(At: 0) }
        set {
            ss_setHeadIndent(value: newValue, range: NSRange.init(location: 0, length: self.length))
        }
    }
    func ss_setHeadIndent(value: CGFloat, range: NSRange) {
        ss_paragraphStyleSet(range: range) { (style) -> NSMutableParagraphStyle in
            style.headIndent = value
            return style
        }
    }
    
    var ss_tailIndent: CGFloat {
        get { return ss_tailIndent(At: 0) }
        set {
            ss_setTailIndent(value: newValue, range: NSRange.init(location: 0, length: self.length))
        }
    }
    func ss_setTailIndent(value: CGFloat, range: NSRange) {
        ss_paragraphStyleSet(range: range) { (style) -> NSMutableParagraphStyle in
            style.tailIndent = value
            return style
        }
    }
    
    var ss_minimumLineHeight: CGFloat {
        get { return ss_minimumLineHeight(At: 0) }
        set {
            ss_setMinimumLineHeight(value: newValue, range: NSRange.init(location: 0, length: self.length))
        }
    }
    func ss_setMinimumLineHeight(value: CGFloat, range: NSRange) {
        ss_paragraphStyleSet(range: range) { (style) -> NSMutableParagraphStyle in
            style.minimumLineHeight = value
            return style
        }
    }
    
    var ss_maximumLineHeight: CGFloat {
        get { return ss_maximumLineHeight(At: 0) }
        set {
            ss_setMaximumLineHeight(value: newValue, range: NSRange.init(location: 0, length: self.length))
        }
    }
    func ss_setMaximumLineHeight(value: CGFloat, range: NSRange) {
        ss_paragraphStyleSet(range: range) { (style) -> NSMutableParagraphStyle in
            style.maximumLineHeight = value
            return style
        }
    }
    
    var ss_lineHeightMultiple: CGFloat {
        get { return ss_lineHeightMultiple(At: 0) }
        set {
            ss_setLineHeightMultiple(value: newValue, range: NSRange.init(location: 0, length: self.length))
        }
    }
    func ss_setLineHeightMultiple(value: CGFloat, range: NSRange) {
        ss_paragraphStyleSet(range: range) { (style) -> NSMutableParagraphStyle in
            style.lineHeightMultiple = value
            return style
        }
    }
    
    var ss_baseWritingDirection: NSWritingDirection {
        get { return ss_baseWritingDirection(At: 0) }
        set {
            ss_setBaseWritingDirection(value: newValue, range: NSRange.init(location: 0, length: self.length))
        }
    }
    func ss_setBaseWritingDirection(value: NSWritingDirection, range: NSRange) {
        ss_paragraphStyleSet(range: range) { (style) -> NSMutableParagraphStyle in
            style.baseWritingDirection = value
            return style
        }
    }
    
    var ss_hyphenationFactor: Float {
        get { return ss_hyphenationFactor(At: 0) }
        set {
            ss_setHyphenationFactor(value: newValue, range: NSRange.init(location: 0, length: self.length))
        }
    }
    func ss_setHyphenationFactor(value: Float, range: NSRange) {
        ss_paragraphStyleSet(range: range) { (style) -> NSMutableParagraphStyle in
            style.hyphenationFactor = value
            return style
        }
    }
    
    var ss_defaultTabInterval: CGFloat {
        get { return ss_defaultTabInterval(At: 0) }
        set {
            ss_setDefaultTabInterval(value: newValue, range: NSRange.init(location: 0, length: self.length))
        }
    }
    func ss_setDefaultTabInterval(value: CGFloat, range: NSRange) {
        ss_paragraphStyleSet(range: range) { (style) -> NSMutableParagraphStyle in
            style.defaultTabInterval = value
            return style
        }
    }
    
    var ss_tabStops: [NSTextTab] {
        get { return ss_tabStops(At: 0) }
        set {
            ss_setTabStops(value: newValue, range: NSRange.init(location: 0, length: self.length))
        }
    }
    func ss_setTabStops(value: [NSTextTab], range: NSRange) {
        ss_paragraphStyleSet(range: range) { (style) -> NSMutableParagraphStyle in
            style.tabStops = value
            return style
        }
    }
}
