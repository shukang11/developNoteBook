//
//  NSAttributedString+SSText.m
//  CoreTextDemo
//
//  Created by Mac on 16/12/27.
//  Copyright © 2016年 Blin. All rights reserved.
//

#import "NSAttributedString+SSText.h"
#import <CoreFoundation/CoreFoundation.h>
#import <Foundation/Foundation.h>
#import "NSParagraphStyle+SSText.h"


static double _YYDeviceSystemVersion() {
    static double version;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        version = [UIDevice currentDevice].systemVersion.doubleValue;
    });
    return version;
}
#ifndef kSystemVersion
#define kSystemVersion _YYDeviceSystemVersion()
#endif

#ifndef kiOS6Later
#define kiOS6Later (kSystemVersion >= 6)
#endif

#ifndef kiOS7Later
#define kiOS7Later (kSystemVersion >= 7)
#endif

#ifndef kiOS8Later
#define kiOS8Later (kSystemVersion >= 8)
#endif

#ifndef kiOS9Later
#define kiOS9Later (kSystemVersion >= 9)
#endif
@implementation NSAttributedString (SSText)

- (NSDictionary *)ss_attributesAtIndex:(NSUInteger)index {
    if (index > self.length || index == 0) return nil;
    if (self.length > 0 && index == self.length) index --;
    return [self attributesAtIndex:index effectiveRange:NULL];
}

- (id)ss_attribute:(NSString *)attributeName atIndex:(NSUInteger)index {
    if (!attributeName) return nil;
    if (index > self.length || index == 0) return nil;
    if (self.length > 0 && index == self.length) index --;
    return  [self attribute:attributeName atIndex:index effectiveRange:NULL];
}

- (NSDictionary *)ss_attributes {
    return [self ss_attributesAtIndex:0];
}

- (UIFont *)ss_font {
    return [self ss_fontAtIndex:0];
}

- (UIFont *)ss_fontAtIndex:(NSUInteger)index {
    UIFont *font = [self ss_attribute:NSFontAttributeName atIndex:index];
    if (kSystemVersion <= 6) {
        if (font) {
            if (CFGetTypeID((__bridge CFTypeRef)(font)) == CTFontGetTypeID()) {
                CTFontRef ctFont = (__bridge CTFontRef)(font);
                CFStringRef name = CTFontCopyPostScriptName(ctFont);
                CGFloat size = CTFontGetSize(ctFont);
                if (!name) {
                    font = nil;
                }else {
                    font = [UIFont fontWithName:(__bridge NSString *)(name) size:size];
                }
            }
        }
    }
    return font;
}

- (UIColor *)ss_color {
    return [self ss_colorAtIndex:0];
}
- (UIColor *)ss_colorAtIndex:(NSUInteger)index {
    UIColor *color = [self ss_attribute:NSForegroundColorAttributeName atIndex:index];
    if (!color) {
        CGColorRef ref = (__bridge CGColorRef)([self ss_attribute:(NSString *)kCTForegroundColorAttributeName atIndex:index]);
        color = [UIColor colorWithCGColor:ref];
    }
    if (color && ![color isKindOfClass:[UIColor class]]) {
        color = nil;
        if (CFGetTypeID((__bridge CFTypeRef)(color)) == CGColorGetTypeID()) {
            color = [UIColor colorWithCGColor:(__bridge CGColorRef)(color)];
        }
    }
    return  color;
}

- (UIColor *)ss_backgroundColor {
    return [self ss_backgroundColorAtIndex:0];
}
- (UIColor *)ss_backgroundColorAtIndex:(NSUInteger)index {
    return [self ss_attribute:NSBackgroundColorAttributeName atIndex:index];
}

- (NSNumber *)ss_kern {
    return [self ss_kernAtIndex:0];
}
- (NSNumber *)ss_kernAtIndex:(NSUInteger)index {
    return [self ss_attribute:NSKernAttributeName atIndex:index];
}

- (NSShadow *)ss_shadow {
    return [self ss_shadowAtIndex:0];
}
- (NSShadow *)ss_shadowAtIndex:(NSUInteger)index {
    return [self ss_attribute:NSShadowAttributeName atIndex:index];
}

- (NSNumber *)ss_strokeWidth {
    return [self ss_strokeWidthAtIndex:0];
}
- (NSNumber *)ss_strokeWidthAtIndex:(NSUInteger)index {
    return [self ss_attribute:NSStrokeWidthAttributeName atIndex:index];
}

- (UIColor *)ss_strokeColor {
    return [self ss_strokeColorAtIndex:0];
}
- (UIColor *)ss_strokeColorAtIndex:(NSUInteger)index {
    UIColor *color = [self ss_attribute:NSStrokeColorAttributeName atIndex:index];
    if (!color) {
        CGColorRef ref = (__bridge CGColorRef)([self ss_attribute:(NSString *)kCTStrokeColorAttributeName atIndex:index]);
        color = [UIColor colorWithCGColor:ref];
    }
    return color;
}

- (NSUnderlineStyle)ss_strikenthroughStyle {
    return [self ss_strikenthroughStyleAtIndex:0];
}
- (NSUnderlineStyle)ss_strikenthroughStyleAtIndex:(NSUInteger)index {
    NSNumber *style = [self ss_attribute:NSStrikethroughStyleAttributeName atIndex:index];
    return style.integerValue;
}

- (UIColor *)ss_strikenthroughColor {
    return [self ss_strikenthroughColorAtIndex:0];
}
- (UIColor *)ss_strikenthroughColorAtIndex:(NSUInteger)index {
    if (kSystemVersion >= 7) {
        return [self ss_attribute:NSStrikethroughColorAttributeName atIndex:index];
    }
    return nil;
}

- (NSUnderlineStyle)ss_underlineStyle {
    return [self ss_underlineStyleAtIndex:0];
}
- (NSUnderlineStyle)ss_underlineStyleAtIndex:(NSUInteger)index {
    NSNumber *style = [self ss_attribute:NSUnderlineStyleAttributeName atIndex:index];
    return style.integerValue;
}

- (UIColor *)ss_underlineColor {
    return [self ss_underlineColorAtIndex:0];
}
- (UIColor *)ss_underlineColorAtIndex:(NSUInteger)index {
    UIColor *color = nil;
    if (kSystemVersion >= 7) {
        color = [self ss_attribute:NSUnderlineColorAttributeName atIndex:index];
    }
    if (!color) {
        CGColorRef ref = (__bridge CGColorRef)([self ss_attribute:(NSString *)kCTUnderlineColorAttributeName atIndex:index]);
        color = [UIColor colorWithCGColor:ref];
    }
    return color;
}

- (NSString *)ss_textEffect {
    return [self ss_textEffectAtIndex:0];
}
- (NSString *)ss_textEffectAtIndex:(NSUInteger)index {
    if (kSystemVersion >= 7) {
        return [self ss_attribute:NSTextEffectAttributeName atIndex:index];
    }
    return nil;
}

- (NSNumber *)ss_ligature {
    return [self ss_ligatureAtIndex:0];
}
- (NSNumber *)ss_ligatureAtIndex:(NSUInteger)index {
    return [self ss_attribute:NSLigatureAttributeName atIndex:index];
}

- (NSNumber *)ss_obliqueness {
    return [self ss_obliquenessAtIndex:0];
}
- (NSNumber *)ss_obliquenessAtIndex:(NSUInteger)index {
    if (kSystemVersion >= 7) {
        return [self ss_attribute:NSObliquenessAttributeName atIndex:index];
    }
    return nil;
}

- (NSNumber *)ss_expansion {
    return [self ss_expansionAtIndex:0];
}
- (NSNumber *)ss_expansionAtIndex:(NSUInteger)index {
    if (kSystemVersion >= 7) {
        return [self ss_attribute:NSExpansionAttributeName atIndex:index];
    }
    return nil;
}

- (NSNumber *)ss_baselineOffset {
    return [self ss_baselineOffsetAtIndex:0];
}
- (NSNumber *)ss_baselineOffsetAtIndex:(NSUInteger)index {
    if (kSystemVersion >= 7) {
        return [self ss_attribute:NSBaselineOffsetAttributeName atIndex:index];
    }
    return nil;
}

- (BOOL)ss_verticalGlyphFrom {
    return [self ss_verticalGlyphFromAtIndex:0];
}
- (BOOL)ss_verticalGlyphFromAtIndex:(NSUInteger)index {
    NSNumber *num = [self ss_attribute:NSVerticalGlyphFormAttributeName atIndex:index];
    return num.boolValue;
}

- (NSString *)ss_language {
    return [self ss_languageAtIndex:0];
}
- (NSString *)ss_languageAtIndex:(NSUInteger)index {
    if (kSystemVersion >= 7) {
        return [self ss_attribute:(NSString *)kCTLanguageAttributeName atIndex:index];
    }
    return nil;
}

- (NSArray<NSNumber *> *)ss_writingDirection {
    return [self ss_writingDirectionAtIndex:0];
}
- (NSArray <NSNumber *> *)ss_writingDirectionAtIndex:(NSUInteger)index {
    return [self ss_attribute:(NSString *)kCTWritingDirectionAttributeName atIndex:index];
}

- (NSParagraphStyle *)ss_paragraphStyle {
    return [self ss_paragraphStyleAtIndex:0];
}
- (NSParagraphStyle *)ss_paragraphStyleAtIndex:(NSUInteger)index {
    NSParagraphStyle *style = [self ss_attribute:NSParagraphStyleAttributeName atIndex:index];
    if (!style) {
        if (CFGetTypeID((__bridge CFTypeRef)(style)) == CTParagraphStyleGetTypeID()) {
            style = [NSParagraphStyle ss_styleWithCTStyle:(__bridge CTParagraphStyleRef)(style)];
        }
    }
    return style;
}

#define ParagraphAttribute(_attr_) \
NSParagraphStyle *style = self.ss_paragraphStyle; \
if (!style) style = [NSParagraphStyle defaultParagraphStyle]; \
return style. _attr_;

#define ParagraphAttributeAtIndex(_attr_) \
NSParagraphStyle *style = [self ss_paragraphStyleAtIndex:index]; \
if (!style) style = [NSParagraphStyle defaultParagraphStyle]; \
return style. _attr_;

- (NSTextAlignment)ss_textAlignment {
    ParagraphAttribute(alignment);
}
- (NSTextAlignment)ss_textAlignmentAtIndex:(NSUInteger)index {
    ParagraphAttributeAtIndex(alignment);
}

- (NSLineBreakMode)ss_lineBreakMode {
    ParagraphAttribute(lineBreakMode);
}
- (NSLineBreakMode)ss_lineBreakModeAtIndex:(NSUInteger)index {
    ParagraphAttributeAtIndex(lineBreakMode);
}

- (CGFloat)ss_lineSpacing {
    ParagraphAttribute(lineSpacing);
}
- (CGFloat)ss_lineSpacingAtIndex:(NSUInteger)index {
    ParagraphAttributeAtIndex(lineSpacing);
}

- (CGFloat)ss_paragraphSpacing {
    ParagraphAttribute(paragraphSpacing);
}
- (CGFloat)ss_paragraphSpacingAtIndex:(NSUInteger)index {
    ParagraphAttributeAtIndex(paragraphSpacing);
}

- (CGFloat)ss_paragraphSpacingBefore {
    ParagraphAttribute(paragraphSpacingBefore);
}
- (CGFloat)ss_paragraphSpacingBeforeAtIndex:(NSUInteger)index {
    ParagraphAttributeAtIndex(paragraphSpacingBefore);
}

- (CGFloat)ss_firstLineHeadIndent {
    ParagraphAttribute(firstLineHeadIndent);
}
- (CGFloat)ss_firstLineHeadIndentAtIndex:(NSUInteger)index {
    ParagraphAttributeAtIndex(firstLineHeadIndent);
}

- (CGFloat)ss_headIndent {
    ParagraphAttribute(headIndent);
}
- (CGFloat)ss_headIndentAtIndex:(NSUInteger)index {
    ParagraphAttributeAtIndex(headIndent);
}

- (CGFloat)ss_tailIndent {
    ParagraphAttribute(tailIndent);
}
- (CGFloat)ss_tailIndentAtIndex:(NSUInteger)index {
    ParagraphAttributeAtIndex(tailIndent);
}

- (CGFloat)ss_minimumLineHeight {
    ParagraphAttribute(minimumLineHeight);
}
- (CGFloat)ss_minimumLineHeightAtIndex:(NSUInteger)index {
    ParagraphAttributeAtIndex(minimumLineHeight);
}

- (CGFloat)ss_maximumLineHeight {
    ParagraphAttribute(maximumLineHeight);
}
- (CGFloat)ss_maximumLineHeightAtIndex:(NSUInteger)index {
    ParagraphAttributeAtIndex(maximumLineHeight);
}

- (CGFloat)ss_lineHeightMultiple {
    ParagraphAttribute(lineHeightMultiple);
}
- (CGFloat)ss_lineHeightMultipleAtIndex:(NSUInteger)index {
    ParagraphAttributeAtIndex(lineHeightMultiple);
}

- (NSWritingDirection)ss_baseWritingDirection {
    ParagraphAttribute(baseWritingDirection);
}
- (NSWritingDirection)ss_baseWritingDirectionAtIndex:(NSUInteger)index {
    ParagraphAttributeAtIndex(baseWritingDirection);
}

- (float)ss_hyphenationFactor {
    ParagraphAttribute(hyphenationFactor);
}
- (float)ss_hyphenationFactorAtIndex:(NSUInteger)index {
    ParagraphAttributeAtIndex(hyphenationFactor);
}

- (CGFloat)ss_defaultTabInterval {
    if (!kiOS7Later) return 0;
    ParagraphAttribute(defaultTabInterval);
}
- (CGFloat)ss_defaultTabIntervalAtIndex:(NSUInteger)index {
    if (!kiOS7Later) return 0;
    ParagraphAttributeAtIndex(defaultTabInterval);
}

- (NSArray *)ss_tabStops {
    if (!kiOS7Later) return nil;
    ParagraphAttribute(tabStops);
}
- (NSArray *)ss_tabStopsAtIndex:(NSUInteger)index {
    if (!kiOS7Later) return nil;
    ParagraphAttributeAtIndex(tabStops);
}

@end



@implementation NSMutableAttributedString (SSText)

- (void)ss_setAttributes:(NSDictionary *)attributes {
    [self setSs_attributes:attributes];
}

- (void)setSs_attributes:(NSDictionary *)attributes {
    if (attributes == (id)[NSNull null]) attributes = nil;
    [self setAttributes:@{} range:NSMakeRange(0, self.length)];
    [attributes enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [self ss_setAttribute:key value:obj];
    }];
}


- (void)ss_setAttribute:(NSString *)name value:(id)value {
    [self ss_setAttribute:name value:value range:NSMakeRange(0, self.length)];
}

- (void)ss_setAttribute:(NSString *)name value:(id)value range:(NSRange)range {
    if (!name || [NSNull isEqual:name]) return;
    if (value && ![NSNull isEqual:value]) {
        [self addAttribute:name value:value range:range];
    }else {
        [self removeAttribute:name range:range];
    }
}

- (void)ss_removeAttributesInRange:(NSRange)range {
    [self setAttributes:nil range:range];
}
#pragma mark - Property Setter
- (void)setSs_font:(UIFont * _Nullable)ss_font {
    [self ss_setFont:ss_font range:NSMakeRange(0, self.length)];
}
- (void)setSs_color:(UIColor * _Nullable)ss_color {
    [self ss_setColor:ss_color range:NSMakeRange(0, self.length)];
}
- (void)setSs_backgroundColor:(UIColor *)ss_backgroundColor {
    [self ss_setBackgroundColor:ss_backgroundColor range:NSMakeRange(0, self.length)];
}
- (void)setSs_kern:(NSNumber *)ss_kern {
    [self ss_setKern:ss_kern range:NSMakeRange(0, self.length)];
}
- (void)setSs_shadow:(NSShadow *)ss_shadow {
    [self ss_setShadow:ss_shadow range:NSMakeRange(0, self.length)];
}
- (void)setSs_strokeWidth:(NSNumber *)ss_strokeWidth {
    [self ss_setStrokeWidth:ss_strokeWidth range:NSMakeRange(0, self.length)];
}
- (void)setSs_strokeColor:(UIColor *)ss_strokeColor {
    [self ss_setStrokeColor:ss_strokeColor range:NSMakeRange(0, self.length)];
}
- (void)setSs_strikenthroughStyle:(NSUnderlineStyle)ss_strikenthroughStyle {
    [self ss_setStrikenthroughStyle:ss_strikenthroughStyle range:NSMakeRange(0, self.length)];
}
- (void)setSs_strikenthroughColor:(UIColor *)ss_strikenthroughColor {
    [self ss_setStrikenthroughColor:ss_strikenthroughColor range:NSMakeRange(0, self.length)];
}
- (void)setSs_underlineStyle:(NSUnderlineStyle)ss_underlineStyle {
    [self ss_setUnderlineStyle:ss_underlineStyle range:NSMakeRange(0, self.length)];
}
- (void)setSs_underlineColor:(UIColor *)ss_underlineColor {
    [self ss_setUnderlineColor:ss_underlineColor range:NSMakeRange(0, self.length)];
}
- (void)setSs_textEffect:(NSString *)ss_textEffect {
    [self ss_setTextEffect:ss_textEffect range:NSMakeRange(0, self.length)];
}
- (void)setSs_ligature:(NSNumber *)ss_ligature {
    [self ss_setLigature:ss_ligature range:NSMakeRange(0, self.length)];
}
- (void)setSs_obliqueness:(NSNumber *)ss_obliqueness {
    [self ss_setObliqueness:ss_obliqueness range:NSMakeRange(0, self.length)];
}
- (void)setSs_expansion:(NSNumber *)ss_expansion {
    [self ss_setExpansion:ss_expansion range:NSMakeRange(0, self.length)];
}
- (void)setSs_baselineOffset:(NSNumber *)ss_baselineOffset {
    [self ss_setBaselineOffset:ss_baselineOffset range:NSMakeRange(0, self.length)];
}
- (void)setSs_verticalGlyphFrom:(BOOL)ss_verticalGlyphFrom {
    [self ss_setVerticalGlyphFrom:ss_verticalGlyphFrom range:NSMakeRange(0, self.length)];
}
- (void)setSs_language:(NSString *)ss_language {
    [self ss_setLanguage:ss_language range:NSMakeRange(0, self.length)];
}
- (void)setSs_writingDirection:(NSArray<NSNumber *> *)ss_writingDirection {
    [self ss_setWritingDirection:ss_writingDirection range:NSMakeRange(0, self.length)];
}
- (void)setSs_paragraphStyle:(NSParagraphStyle *)ss_paragraphStyle {
    [self ss_setParagraphStyle:ss_paragraphStyle range:NSMakeRange(0, self.length)];
}


- (void)setSs_textAlignment:(NSTextAlignment)ss_textAlignment {
    [self ss_setTextAlignment:ss_textAlignment range:NSMakeRange(0, self.length)];
}
- (void)setSs_lineBreakMode:(NSLineBreakMode)ss_lineBreakMode {
    [self ss_setLineBreakMode:ss_lineBreakMode range:NSMakeRange(0, self.length)];
}
- (void)setSs_lineSpacing:(CGFloat)ss_lineSpacing {
    [self ss_setLineSpacing:ss_lineSpacing range:NSMakeRange(0, self.length)];
}
- (void)setSs_paragraphSpacing:(CGFloat)ss_paragraphSpacing {
    [self ss_setParagraphSpacing:ss_paragraphSpacing range:NSMakeRange(0, self.length)];
}
- (void)setSs_paragraphSpacingBefore:(CGFloat)ss_paragraphSpacingBefore {
    [self ss_setParagraphSpacingBefore:ss_paragraphSpacingBefore range:NSMakeRange(0, self.length)];
}
- (void)setSs_firstLineHeadIndent:(CGFloat)ss_firstLineHeadIndent {
    [self ss_setFirstLineHeadIndent:ss_firstLineHeadIndent range:NSMakeRange(0, self.length)];
}
- (void)setSs_headIndent:(CGFloat)ss_headIndent {
    [self ss_setHeadIndent:ss_headIndent range:NSMakeRange(0, self.length)];
}
- (void)setSs_tailIndent:(CGFloat)ss_tailIndent {
    [self ss_setTailIndent:ss_tailIndent range:NSMakeRange(0, self.length)];
}
- (void)setSs_minimumLineHeight:(CGFloat)ss_minimumLineHeight {
    [self ss_setMinimumLineHeight:ss_minimumLineHeight range:NSMakeRange(0, self.length)];
}
- (void)setSs_maximumLineHeight:(CGFloat)ss_maximumLineHeight {
    [self ss_setMaximumLineHeight:ss_maximumLineHeight range:NSMakeRange(0, self.length)];
}
- (void)setSs_lineHeightMultiple:(CGFloat)ss_lineHeightMultiple {
    [self ss_setLineHeightMultiple:ss_lineHeightMultiple range:NSMakeRange(0, self.length)];
}
- (void)setSs_baseWritingDirection:(NSWritingDirection)ss_baseWritingDirection {
    [self ss_setBaseWritingDirection:ss_baseWritingDirection range:NSMakeRange(0, self.length)];
}
- (void)setSs_hyphenationFactor:(float)ss_hyphenationFactor {
    [self  ss_setHyphenationFactor:ss_hyphenationFactor range:NSMakeRange(0, self.length)];
}
- (void)setSs_defaultTabInterval:(CGFloat)ss_defaultTabInterval {
    [self ss_setDefaultTabInterval:ss_defaultTabInterval range:NSMakeRange(0, self.length)];
}
- (void)setSs_tabStops:(NSArray<NSTextTab *> *)ss_tabStops {
    [self ss_setTabStops:ss_tabStops range:NSMakeRange(0, self.length)];
}
#pragma mark - Range Setter
- (void)ss_setFont:(UIFont *)font range:(NSRange)range {
    [self ss_setAttribute:NSFontAttributeName value:font range:range];
}
- (void)ss_setColor:(nullable UIColor *)color range:(NSRange)range {
    [self ss_setAttribute:NSForegroundColorAttributeName value:color range:range];
    [self ss_setAttribute:(NSString *)kCTForegroundColorAttributeName value:(id)color.CGColor range:range];
}
- (void)ss_setBackgroundColor:(nullable UIColor *)backgroundColor range:(NSRange)range {
    [self ss_setAttribute:NSBackgroundColorAttributeName value:backgroundColor range:range];
}
- (void)ss_setKern:(nullable NSNumber *)kern range:(NSRange)range {
    [self ss_setAttribute:NSKernAttributeName value:kern range:range];
}
- (void)ss_setShadow:(nullable NSShadow *)shadow range:(NSRange)range {
    [self ss_setAttribute:NSShadowAttributeName value:shadow range:range];
}
- (void)ss_setStrokeWidth:(nullable NSNumber *)strokeWidth range:(NSRange)range {
    [self ss_setAttribute:NSStrokeWidthAttributeName value:strokeWidth range:range];
}
- (void)ss_setStrokeColor:(nullable UIColor *)strokeColor range:(NSRange)range {
    [self ss_setAttribute:NSStrokeColorAttributeName value:strokeColor range:range];
}
- (void)ss_setStrikenthroughStyle:(NSUnderlineStyle)strikenthroughStyle range:(NSRange)range {
    NSNumber *style = strikenthroughStyle == 0?nil:@(strikenthroughStyle);
    [self ss_setAttribute:NSStrikethroughStyleAttributeName value:style range:range];
}
- (void)ss_setStrikenthroughColor:(nullable UIColor *)strikenthrouthColor range:(NSRange)range {
    if (kSystemVersion >= 7) {
        [self ss_setAttribute:NSStrikethroughColorAttributeName value:strikenthrouthColor range:range];
    }
}
- (void)ss_setUnderlineStyle:(NSUnderlineStyle)underlineStyle range:(NSRange)range {
    NSNumber *style = underlineStyle == 0?nil:@(underlineStyle);
    [self ss_setAttribute:NSUnderlineStyleAttributeName value:style range:range];
}
- (void)ss_setUnderlineColor:(UIColor *)underlinColor range:(NSRange)range {
    [self ss_setAttribute:(id)kCTUnderlineStyleAttributeName value:(id)underlinColor.CGColor range:range];
    if (kSystemVersion >= 7) {
        [self ss_setAttribute:NSUnderlineColorAttributeName value:underlinColor range:range];
    }
}
- (void)ss_setTextEffect:(NSString *)textEffect range:(NSRange)range {
    if (kSystemVersion >= 7) {
        [self ss_setAttribute:NSTextEffectAttributeName value:textEffect range:range];
    }
}
- (void)ss_setLigature:(NSNumber *)ligature range:(NSRange)range {
    [self ss_setAttribute:NSLigatureAttributeName value:ligature range:range];
}
- (void)ss_setObliqueness:(NSNumber *)obliqueness range:(NSRange)range {
    if (kSystemVersion >= 7) {
        [self ss_setAttribute:NSObliquenessAttributeName value:obliqueness range:range];
    }
}
- (void)ss_setExpansion:(NSNumber *)expansion range:(NSRange)range {
    if (kSystemVersion >= 7) {
        [self ss_setAttribute:NSExpansionAttributeName value:expansion range:range];
    }
}
- (void)ss_setBaselineOffset:(NSNumber *)baselineOffset range:(NSRange)range {
    if (kSystemVersion >= 7) {
        [self ss_setAttribute:NSBaselineOffsetAttributeName value:baselineOffset range:range];
    }
}
- (void)ss_setVerticalGlyphFrom:(BOOL)verticalGlyphFrom range:(NSRange)range {
    NSNumber *v = verticalGlyphFrom?@(YES):nil;
    [self ss_setAttribute:NSVerticalGlyphFormAttributeName value:v range:range];
}
- (void)ss_setLanguage:(NSString *)language range:(NSRange)range {
    if (kSystemVersion >= 7) {
        [self ss_setAttribute:(id)kCTLanguageAttributeName value:language range:range];
    }
}
- (void)ss_setWritingDirection:(NSArray<NSNumber *> *)writingDirection range:(NSRange)range {
    [self ss_setAttribute:(id)kCTWritingDirectionAttributeName value:writingDirection range:range];
}

- (void)ss_setParagraphStyle:(nullable NSParagraphStyle *)paragraphStyle range:(NSRange)range {
    /*
     NSParagraphStyle is NOT toll-free bridged to CTParagraphStyleRef.
     
     CoreText can use both NSParagraphStyle and CTParagraphStyleRef,
     but UILabel/UITextView can only use NSParagraphStyle.
     
     We use NSParagraphStyle in both CoreText and UIKit.
     */
    [self ss_setAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:range];
}

#define ParagraphStyleSet(_attr_) \
[self enumerateAttribute:NSParagraphStyleAttributeName \
                inRange:range \
                options:kNilOptions \
                usingBlock:^(NSParagraphStyle *value, NSRange subRange, BOOL * _Nonnull stop) { \
                NSMutableParagraphStyle *style = nil; \
                if (value) { \
                    if (CFGetTypeID((__bridge CFTypeRef) (value)) == CTParagraphStyleGetTypeID()) { \
                    value = [NSParagraphStyle ss_styleWithCTStyle:(__bridge CTParagraphStyleRef)(value)]; \
                    } \
                    if (value. _attr_ == _attr_) return; \
                    if ([value isKindOfClass:[NSMutableParagraphStyle class]]) { \
                    style = (id)value; \
                    }else { \
                    style = value.mutableCopy; \
                } \
                }else { \
                if ([NSParagraphStyle defaultParagraphStyle]. _attr_ == _attr_) return ; \
                style = [NSParagraphStyle defaultParagraphStyle].mutableCopy; \
                } \
                style. _attr_ = _attr_; \
                [self ss_setParagraphStyle:style range:subRange]; \
                }];

- (void)ss_setTextAlignment:(NSTextAlignment)alignment range:(NSRange)range {
    ParagraphStyleSet(alignment);
}
- (void)ss_setLineBreakMode:(NSLineBreakMode)lineBreakMode range:(NSRange)range {
    ParagraphStyleSet(lineBreakMode);
}
- (void)ss_setLineSpacing:(CGFloat)lineSpacing range:(NSRange)range {
    ParagraphStyleSet(lineSpacing);
}
- (void)ss_setParagraphSpacing:(CGFloat)paragraphSpacing range:(NSRange)range {
    ParagraphStyleSet(paragraphSpacing);
}
- (void)ss_setParagraphSpacingBefore:(CGFloat)paragraphSpacingBefore range:(NSRange)range {
    ParagraphStyleSet(paragraphSpacingBefore);
}
- (void)ss_setFirstLineHeadIndent:(CGFloat)firstLineHeadIndent range:(NSRange)range {
    ParagraphStyleSet(firstLineHeadIndent);
}
- (void)ss_setHeadIndent:(CGFloat)headIndent range:(NSRange)range {
    ParagraphStyleSet(headIndent);
}
- (void)ss_setTailIndent:(CGFloat)tailIndent range:(NSRange)range {
    ParagraphStyleSet(tailIndent);
}
- (void)ss_setMinimumLineHeight:(CGFloat)minimumLineHeight range:(NSRange)range {
    ParagraphStyleSet(minimumLineHeight);
}
- (void)ss_setMaximumLineHeight:(CGFloat)maximumLineHeight range:(NSRange)range {
    ParagraphStyleSet(maximumLineHeight);
}
- (void)ss_setLineHeightMultiple:(CGFloat)lineHeightMultiple range:(NSRange)range {
    ParagraphStyleSet(lineHeightMultiple);
}
- (void)ss_setBaseWritingDirection:(NSWritingDirection)baseWritingDirection range:(NSRange)range {
    ParagraphStyleSet(baseWritingDirection);
}
- (void)ss_setHyphenationFactor:(float)hyphenationFactor range:(NSRange)range {
    ParagraphStyleSet(hyphenationFactor);
}
- (void)ss_setDefaultTabInterval:(CGFloat)defaultTabInterval range:(NSRange)range {
    if (!kiOS7Later) return;
    ParagraphStyleSet(defaultTabInterval);
}
- (void)ss_setTabStops:(NSArray<NSTextTab *> *)tabStops range:(NSRange)range {
    if (!kiOS7Later) return;
    ParagraphStyleSet(tabStops);
}

- (void)ss_removeDiscontinuousAttributesInRange:(NSRange)range {
    NSArray *keys = [NSMutableAttributedString ss_allDiscontinuousAttributeKeys];
    for (NSString *key in keys) {
        [self removeAttribute:key range:range];
    }
}

+ (NSArray *)ss_allDiscontinuousAttributeKeys {
    static NSMutableArray *keys;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        keys = @[(id)kCTSuperscriptAttributeName,
                 (id)kCTRunDelegateAttributeName].mutableCopy;
        if (kiOS8Later) {
            [keys addObject:(id)kCTRubyAnnotationAttributeName];
        }
        if (kiOS7Later) {
            [keys addObject:NSAttachmentAttributeName];
        }
    });
    return keys;
}
@end
