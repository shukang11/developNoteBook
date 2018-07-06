//
//  NSAttributedString+SSText.h
//  CoreTextDemo
//
//  Created by Mac on 16/12/27.
//  Copyright © 2016年 Blin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSAttributedString (SSText)
@property (nullable, nonatomic, strong, readonly)UIFont *ss_font;
- (nullable UIFont *)ss_fontAtIndex:(NSUInteger)index;

@property (nullable, nonatomic, strong, readonly)UIColor *ss_color;
- (nullable UIColor *)ss_colorAtIndex:(NSUInteger)index;

@property (nullable, nonatomic, strong, readonly)UIColor *ss_backgroundColor;
- (nullable UIColor *)ss_backgroundColorAtIndex:(NSUInteger)index;

@property (nullable, nonatomic, strong, readonly)NSNumber *ss_kern;
- (nullable NSNumber *)ss_kernAtIndex:(NSUInteger)index;

@property (nullable, nonatomic, strong, readonly)NSShadow *ss_shadow;
- (nullable NSShadow *)ss_shadowAtIndex:(NSUInteger)index;

@property (nullable, nonatomic, strong, readonly)NSNumber *ss_strokeWidth;
- (nullable NSNumber *)ss_strokeWidthAtIndex:(NSUInteger)index;

@property (nullable, nonatomic, strong, readonly)UIColor *ss_strokeColor;
- (nullable UIColor *)ss_strokeColorAtIndex:(NSUInteger)index;

@property (nonatomic, readonly)NSUnderlineStyle ss_strikenthroughStyle;
- (NSUnderlineStyle)ss_strikenthroughStyleAtIndex:(NSUInteger)index;

@property (nullable, nonatomic, strong, readonly)UIColor *ss_strikenthroughColor;
- (UIColor *)ss_strikenthroughColorAtIndex:(NSUInteger)index;

@property (nonatomic, readonly)NSUnderlineStyle ss_underlineStyle;
- (NSUnderlineStyle)ss_underlineStyleAtIndex:(NSUInteger)index;

@property (nullable, nonatomic, strong, readonly)UIColor *ss_underlineColor;
- (nullable UIColor *)ss_underlineColorAtIndex:(NSUInteger)index;

@property (nullable, nonatomic, strong, readonly)NSString *ss_textEffect;
- (nullable NSString *)ss_textEffectAtIndex:(NSUInteger)index;

@property (nullable, nonatomic, strong, readonly)NSNumber *ss_ligature;
- (nullable NSNumber *)ss_ligatureAtIndex:(NSUInteger)index;

@property (nullable, nonatomic, strong, readonly)NSNumber *ss_obliqueness;
- (nullable NSNumber *)ss_obliquenessAtIndex:(NSUInteger)index;

@property (nullable, nonatomic, strong, readonly)NSNumber *ss_expansion;
- (nullable NSNumber *)ss_expansionAtIndex:(NSUInteger)index;

@property (nullable, nonatomic, strong, readonly)NSNumber *ss_baselineOffset;
- (nullable NSNumber *)ss_baselineOffsetAtIndex:(NSUInteger)index;

@property (nonatomic, readonly)BOOL ss_verticalGlyphFrom;
- (BOOL)ss_verticalGlyphFromAtIndex:(NSUInteger)index;

@property (nullable, nonatomic, strong, readonly)NSString *ss_language;
- (nullable NSString *)ss_languageAtIndex:(NSUInteger)index;

@property (nullable, nonatomic, strong, readonly)NSArray<NSNumber *> *ss_writingDirection;
- (nullable NSArray<NSNumber *> *)ss_writingDirectionAtIndex:(NSUInteger)index;

@property (nullable, nonatomic, strong, readonly)NSParagraphStyle *ss_paragraphStyle;
- (nullable NSParagraphStyle *)ss_paragraphStyleAtIndex:(NSUInteger)index;

@property (nonatomic, readonly)NSTextAlignment ss_textAlignment;
- (NSTextAlignment)ss_textAlignmentAtIndex:(NSUInteger)index;

@property (nonatomic, readonly)NSLineBreakMode ss_lineBreakMode;
- (NSLineBreakMode)ss_lineBreakModeAtIndex:(NSUInteger)index;

@property (nonatomic, readonly)CGFloat ss_lineSpacing;
- (CGFloat)ss_lineSpacingAtIndex:(NSUInteger)index;

@property (nonatomic, readonly)CGFloat ss_paragraphSpacing;
- (CGFloat)ss_paragraphSpacingAtIndex:(NSUInteger)index;

@property (nonatomic, readonly)CGFloat ss_paragraphSpacingBefore;
- (CGFloat)ss_paragraphSpacingBeforeAtIndex:(NSUInteger)index;

@property (nonatomic, readonly)CGFloat ss_firstLineHeadIndent;
- (CGFloat)ss_firstLineHeadIndentAtIndex:(NSUInteger)index;

@property (nonatomic, readonly)CGFloat ss_headIndent;
- (CGFloat)ss_headIndentAtIndex:(NSUInteger)index;

@property (nonatomic, readonly)CGFloat ss_tailIndent;
- (CGFloat)ss_tailIndentAtIndex:(NSUInteger)index;

@property (nonatomic, readonly)CGFloat ss_minimumLineHeight;
- (CGFloat)ss_minimumLineHeightAtIndex:(NSUInteger)index;

@property (nonatomic, readonly)CGFloat ss_maximumLineHeight;
- (CGFloat)ss_maximumLineHeightAtIndex:(NSUInteger)index;

@property (nonatomic, readonly)CGFloat ss_lineHeightMultiple;
- (CGFloat)ss_lineHeightMultipleAtIndex:(NSUInteger)index;

@property (nonatomic, readonly)NSWritingDirection ss_baseWritingDirection;
- (NSWritingDirection)ss_baseWritingDirectionAtIndex:(NSUInteger)index;

@property (nonatomic, readonly)float ss_hyphenationFactor;
- (float)ss_hyphenationFactorAtIndex:(NSUInteger)index;

@property (nonatomic, readonly)CGFloat ss_defaultTabInterval;
- (CGFloat)ss_defaultTabIntervalAtIndex:(NSUInteger)index;

@property (nullable, nonatomic, strong, readonly)NSArray<NSTextTab *> *ss_tabStops;
- (nullable NSArray<NSTextTab *> *)ss_tabStopsAtIndex:(NSUInteger)index;


@end


@interface NSMutableAttributedString (SSText)
- (void)ss_setAttributes:(nullable NSDictionary<NSString *, id> *)attributes;
- (void)setSs_attributes:(nullable NSDictionary<NSString *, id> *)attributes;
- (void)ss_setAttribute:(nullable NSString *)name value:(nullable id)value;
- (void)ss_setAttribute:(nullable NSString *)name value:(nullable id)value range:(NSRange)range;
- (void)ss_removeAttributesInRange:(NSRange)range;

#pragma mark - Set character attribute as property

/**
 文本的字体
 */
@property (nullable, nonatomic, strong, readwrite)UIFont *ss_font;
- (void)ss_setFont:(nullable UIFont *)font range:(NSRange)range;


/**
 文本的颜色
 */
@property (nullable, nonatomic, strong, readwrite)UIColor *ss_color;
- (void)ss_setColor:(nullable UIColor *)color range:(NSRange)range;


/**
 文字的背景色
 */
@property (nullable, nonatomic,  strong, readwrite)UIColor *ss_backgroundColor;
- (void)ss_setBackgroundColor:(nullable UIColor *)backgroundColor range:(NSRange)range;

/**
 文本的间距
 */
@property (nullable, nonatomic, strong, readwrite)NSNumber *ss_kern;
- (void)ss_setKern:(nullable NSNumber *)kern range:(NSRange)range;


/**
 文字的阴影
 */
@property (nullable, nonatomic, strong, readwrite) NSShadow *ss_shadow;
- (void)ss_setShadow:(nullable NSShadow *)shadow range:(NSRange)range;

/**
 文字的描边宽度
 */
@property (nullable, nonatomic,strong, readwrite)NSNumber *ss_strokeWidth;
- (void)ss_setStrokeWidth:(nullable NSNumber *)strokeWidth range:(NSRange)range;


/**
 文字的描边颜色
 */
@property (nullable, nonatomic, strong, readwrite) UIColor *ss_strokeColor;
- (void)ss_setStrokeColor:(nullable UIColor *)strokeColor range:(NSRange)range;


/**
 文字的删除线
 */
@property (nonatomic, readwrite) NSUnderlineStyle ss_strikenthroughStyle;
- (void)ss_setStrikenthroughStyle:(NSUnderlineStyle)strikenthroughStyle range:(NSRange)range;


/**
 文字删除线颜色
 */
@property (nullable, nonatomic, strong, readwrite)UIColor *ss_strikenthroughColor;
- (void)ss_setStrikenthroughColor:(nullable UIColor *)strikenthrouthColor range:(NSRange)range NS_AVAILABLE_IOS(7);

/**
 文字下划线的样式
 */
@property (nonatomic,readwrite) NSUnderlineStyle ss_underlineStyle;
- (void)ss_setUnderlineStyle:(NSUnderlineStyle)underlineStyle range:(NSRange)range;


/**
 文字下划线的颜色
 */
@property (nullable, nonatomic, strong, readwrite)UIColor *ss_underlineColor;
- (void)ss_setUnderlineColor:(nullable UIColor *)underlinColor range:(NSRange)range;


/**
 文字效果？
 */
@property (nullable, nonatomic, strong, readwrite)NSString *ss_textEffect;
- (void)ss_setTextEffect:(nullable NSString *)textEffect range:(NSRange)range NS_AVAILABLE_IOS(7_0);

/**
 文字连词
 */
@property (nullable, nonatomic,strong,readwrite) NSNumber *ss_ligature;
- (void)ss_setLigature:(nullable NSNumber *)ligature range:(NSRange)range NS_AVAILABLE_IOS(7_0);



/**
 文字斜体
 */
@property (nullable, nonatomic, strong, readwrite)NSNumber *ss_obliqueness;
- (void)ss_setObliqueness:(nullable NSNumber *)obliqueness range:(NSRange)range;


/**
 文字膨胀字？
 */
@property (nullable, nonatomic, strong,readwrite)NSNumber *ss_expansion;
- (void)ss_setExpansion:(nullable NSNumber *)expansion range:(NSRange)range NS_AVAILABLE_IOS(7_0);


/**
 文字的基线位置
 */
@property (nullable, nonatomic, strong, readwrite)NSNumber *ss_baselineOffset;
- (void)ss_setBaselineOffset:(nullable NSNumber *)baselineOffset range:(NSRange)range NS_AVAILABLE_IOS(7_0);


/**
 垂直字体？
 */
@property (nonatomic, readwrite)BOOL ss_verticalGlyphFrom;
- (void)ss_setVerticalGlyphFrom:(BOOL)verticalGlyphFrom range:(NSRange)range;


/**
 字体语言
 */
@property (nullable, nonatomic, strong, readwrite)NSString *ss_language;
- (void)ss_setLanguage:(nullable NSString *)language range:(NSRange)range NS_AVAILABLE_IOS(7_0);


/**
 字体方向
 */
@property (nullable, nonatomic, strong, readwrite)NSArray<NSNumber *> *ss_writingDirection;
- (void)ss_setWritingDirection:(nullable NSArray<NSNumber *> *)writingDirection range:(NSRange)range;


/**
 文字的段落格式
 */
@property (nullable, nonatomic, strong, readwrite)NSParagraphStyle *ss_paragraphStyle;
- (void)ss_setParagraphStyle:(nullable NSParagraphStyle *)paragraphStyle range:(NSRange)range;
/**
 文字的对其方式
 */
@property (nonatomic, assign, readwrite)NSTextAlignment ss_textAlignment;
- (void)ss_setTextAlignment:(NSTextAlignment)textAlignment range:(NSRange)range;


/**
 文字的转行模式
 */
@property (nonatomic,assign, readwrite) NSLineBreakMode ss_lineBreakMode;
- (void)ss_setLineBreakMode:(NSLineBreakMode) lineBreakMode range:(NSRange)range;


/**
 行间距
 */
@property (nonatomic, readwrite)CGFloat ss_lineSpacing;
- (void)ss_setLineSpacing:(CGFloat)lineSpacing range:(NSRange)range;


/**
 段落间距
 */
@property (nonatomic,readwrite)CGFloat ss_paragraphSpacing;
- (void)ss_setParagraphSpacing:(CGFloat)paragraphSpacing range:(NSRange)range;


/**
 段首空间
 */
@property (nonatomic,readwrite)CGFloat ss_paragraphSpacingBefore;
- (void)ss_setParagraphSpacingBefore:(CGFloat)paragraphSpacingBefore range:(NSRange)range;


/**
 首行缩进
 */
@property (nonatomic,readwrite)CGFloat ss_firstLineHeadIndent;
- (void)ss_setFirstLineHeadIndent:(CGFloat)firstLineHeadIndent range:(NSRange)range;

/**
 首行
 */
@property (nonatomic,readwrite)CGFloat ss_headIndent;
- (void)ss_setHeadIndent:(CGFloat)headIndent range:(NSRange)range;


/**
 尾行
 */
@property (nonatomic,readwrite)CGFloat ss_tailIndent;
- (void)ss_setTailIndent:(CGFloat)tailIndent range:(NSRange)range;


/**
 最小行高
 */
@property (nonatomic,readwrite)CGFloat ss_minimumLineHeight;
- (void)ss_setMinimumLineHeight:(CGFloat)minimumLineHeight range:(NSRange)range;


/**
 最大行高
 */
@property (nonatomic,readwrite)CGFloat ss_maximumLineHeight;
- (void)ss_setMaximumLineHeight:(CGFloat)maximumLineHeight range:(NSRange)range;


/**
 行高倍数
 */
@property (nonatomic,readwrite)CGFloat ss_lineHeightMultiple;
- (void)ss_setLineHeightMultiple:(CGFloat)lineHeightMultiple range:(NSRange)range;


/**
 方向
 */
@property (nonatomic,readwrite)NSWritingDirection ss_baseWritingDirection;
- (void)ss_setBaseWritingDirection:(NSWritingDirection)baseWritingDirection range:(NSRange)range;

/**
 断字
 */
@property (nonatomic, readwrite)float ss_hyphenationFactor;
- (void)ss_setHyphenationFactor:(float)hyphenationFactor range:(NSRange)range;


/**
 默认缩进
 */
@property (nonatomic,readwrite)CGFloat ss_defaultTabInterval;
- (void)ss_setDefaultTabInterval:(CGFloat)defaultTabInterval range:(NSRange)range;


/**
 制表符的相关
 */
@property (nullable, nonatomic, copy, readwrite)NSArray<NSTextTab *> *ss_tabStops;
- (void)ss_setTabStops:(nullable NSArray <NSTextTab *>*)tabStops range:(NSRange)range;

@end
NS_ASSUME_NONNULL_END
