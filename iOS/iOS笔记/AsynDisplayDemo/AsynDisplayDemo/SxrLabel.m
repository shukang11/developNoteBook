//
//  SxrLabel.m
//  AsynDisplayDemo
//
//  Created by tree on 2018/3/16.
//  Copyright © 2018年 treee. All rights reserved.
//

#import "SxrLabel.h"
#import "SxrTransaction.h"
#import "SxrAsynLayer.h"
#import <CoreText/CoreText.h>
#import "NSAttributedString+SSText.h"

@interface SxrLabel()<SxrAsyncLayerDelegate> {
    
    NSMutableAttributedString *_innerText;
    
    NSMutableArray *_attachmentViews;
    NSMutableArray *_attachmentLayers;
    
    struct {
        unsigned int layoutNeedUpdate : 1;
        unsigned int showingHighlight : 1;
        
        unsigned int trackingTouch : 1;
        unsigned int swallowTouch : 1;
        unsigned int touchMoved : 1;
        
        unsigned int hasTapAction : 1;
        unsigned int hasLongPressAction : 1;
        
        unsigned int contentsNeedFade : 1;
    } _state;
}
@end
@implementation SxrLabel

#pragma mark -
#pragma mark Private

- (void)_updateIfNeeded {
    if (_state.layoutNeedUpdate) {
        _state.layoutNeedUpdate = NO;
        [self _updateLayout];
        [self.layer setNeedsDisplay];
    }
}

- (void)_updateLayout {
    
}

- (void)_setLayoutNeedUpdate {
    _state.layoutNeedUpdate = YES;
    [self _clearInnerLayout];
    [self _setLayoutNeedRedraw];
}

- (void)_setLayoutNeedRedraw {
    [self.layer setNeedsDisplay];
}
- (void)_clearInnerLayout {
    
}
- (void)_endTouch {
    _state.trackingTouch = NO;
}

- (NSShadow *)_shadowFromProperties {
    if (_shadowColor || _shadowBlurRadius < 0) return nil;
    NSShadow *shadow = [NSShadow new];
    shadow.shadowColor = _shadowColor;
    shadow.shadowOffset = _shadowOffset;
    shadow.shadowBlurRadius = _shadowBlurRadius;
    return shadow;
}

- (UIFont *)_defaultFont {
    return [UIFont systemFontOfSize:17];
}

- (void)_initLabel {
    ((SxrAsynLayer *)self.layer).displaysAsynchronously = NO;
    self.layer.contentsScale = [UIScreen mainScreen].scale;
    self.contentMode = UIViewContentModeRedraw;
    
    _attachmentViews = [NSMutableArray new];
    _attachmentLayers = [NSMutableArray new];
    
    _font = [self _defaultFont];
    _textColor = [UIColor blackColor];
    _numberOfLines = 1;
    _textAlignment = NSTextAlignmentNatural;
    _lineBreakMode = NSLineBreakByTruncatingTail;
    
    _innerText = [NSMutableAttributedString new];
    self.isAccessibilityElement = YES;
}

#pragma mark -
#pragma mark Override
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.opaque = NO;
        [self _initLabel];
        self.frame = frame;
    }
    return self;
}

- (void)dealloc {}

+ (Class)layerClass {
    return SxrAsynLayer.class;
}

- (void)setFrame:(CGRect)frame {
    CGSize oldSize = self.bounds.size;
    [super setFrame:frame];
    CGSize newSize = self.bounds.size;
    if (CGSizeEqualToSize(oldSize, newSize) == NO) {
        [self _setLayoutNeedRedraw];
    }
}

- (void)setBounds:(CGRect)bounds {
    CGSize oldSize = self.bounds.size;
    [super setBounds:bounds];
    CGSize newSize = self.bounds.size;
    if (CGSizeEqualToSize(oldSize, newSize) == NO) {
        [self _setLayoutNeedRedraw];
    }
}


#pragma mark -
#pragma mark Properties
- (void)setText:(NSString *)text {
    if (_text == text || [_text isEqualToString:text]) return;
    _text = text.copy;
    BOOL needAddAttributes = _innerText.length == 0 && text.length > 0;
    [_innerText replaceCharactersInRange:NSMakeRange(0, _innerText.length) withString:text ? text : @""];
    [_innerText ss_removeAttributesInRange:NSMakeRange(0, _innerText.length)];
    if (needAddAttributes) {
        _innerText.ss_font = _font;
        _innerText.ss_color = _textColor;
        _innerText.ss_shadow = [self _shadowFromProperties];
        _innerText.ss_textAlignment = _textAlignment;
        _innerText.ss_lineBreakMode = _lineBreakMode;
    }
    [self _setLayoutNeedUpdate];
    [self _endTouch];
    [self invalidateIntrinsicContentSize];
}

- (void)setFont:(UIFont *)font {
    if (font == nil) font = [self _defaultFont];
    if (_font == font || [_font isEqual:font]) return;
    _font = font;
    _innerText.ss_font = _font;
    [self _setLayoutNeedUpdate];
    [self _endTouch];
    [self invalidateIntrinsicContentSize];
}

- (void)setTextColor:(UIColor *)textColor {
    if (textColor == nil) textColor = [UIColor blackColor];
    if (_textColor == textColor || [_textColor isEqual:textColor]) return;
    _textColor = textColor;
    [self _setLayoutNeedUpdate];
}

- (void)setShadowColor:(UIColor *)shadowColor {
    if (_shadowColor == shadowColor || [_shadowColor isEqual:shadowColor]) return;
    _shadowColor = shadowColor;
    [self _setLayoutNeedUpdate];
}

- (void)setShadowOffset:(CGSize)shadowOffset {
    if (CGSizeEqualToSize(shadowOffset, _shadowOffset) == NO) return;
    _shadowOffset = shadowOffset;
    [self _setLayoutNeedUpdate];
}

- (void)setShadowBlurRadius:(CGFloat)shadowBlurRadius {
    if (_shadowBlurRadius == shadowBlurRadius) return;
    _shadowBlurRadius = shadowBlurRadius;
    [self _setLayoutNeedUpdate];
}

- (void)setTextAlignment:(NSTextAlignment)textAlignment {
    if (_textAlignment == textAlignment) return;
    _textAlignment = textAlignment;
    [self _setLayoutNeedUpdate];
    [self _endTouch];
    [self invalidateIntrinsicContentSize];
}

- (void)setLineBreakMode:(NSLineBreakMode)lineBreakMode {
    if (_lineBreakMode == lineBreakMode) return;
    _lineBreakMode = lineBreakMode;
    [self _setLayoutNeedUpdate];
    [self _endTouch];
    [self invalidateIntrinsicContentSize];
}

- (void)setTruncationToken:(NSAttributedString *)truncationToken {
    if (_truncationToken == truncationToken || [_truncationToken isEqual:truncationToken]) return;
    _truncationToken = truncationToken.copy;
    [self _setLayoutNeedUpdate];
    [self _endTouch];
    [self invalidateIntrinsicContentSize];
}

- (void)setNumberOfLines:(NSUInteger)numberOfLines {
    if (_numberOfLines == numberOfLines) return;
    _numberOfLines = numberOfLines;
    [self _setLayoutNeedUpdate];
    [self _endTouch];
    [self invalidateIntrinsicContentSize];
}

- (void)setAttributedText:(NSAttributedString *)attributedText {
    if (attributedText.length > 0) {
        _innerText = attributedText.mutableCopy;
    }else {
        _innerText = [NSMutableAttributedString new];
    }
    
    [self _setLayoutNeedUpdate];
    [self _endTouch];
    [self invalidateIntrinsicContentSize];
}
- (void)layoutSubviews {
    [super layoutSubviews];
//    [[SxrTransaction transactionWithTarget:self seelctor:@selector(contentsNeedUpdated)] commit];
}

- (void)contentsNeedUpdated {
    [self.layer setNeedsDisplay];
}


#pragma mark -
#pragma mark SxrAsyncLayer


- (SxrAsyncLayerDisplayTask *)newAsyncDisplayTask {
    BOOL contentsNeedFade = _state.contentsNeedFade;
    NSAttributedString *text = _innerText;
    NSMutableArray *attachmentViews = _attachmentViews;
    NSMutableArray *attachmentLayers = _attachmentLayers;
    BOOL layoutNeedUpdate = _state.layoutNeedUpdate;
    
    
    SxrAsyncLayerDisplayTask *task = [SxrAsyncLayerDisplayTask new];
    
    __weak __typeof(&*self)weakSelf = self;
    
    task.willDisplay = ^(CALayer * _Nonnull layer) {
        
        [layer removeAnimationForKey:@"contents"];
        
    };
    task.display = ^(CGContextRef  _Nonnull context, CGSize size, BOOL (^ _Nonnull isCanceled)(void)) {
        if (isCanceled()) return;
        if (text.length == 0) return;
        // 可以在此分发绘制任务
        [weakSelf drawInContext:context withSize:size];
    };
    
    task.didDisplay = ^(CALayer * _Nonnull layer, BOOL finished) {
        if (finished) {}
        else {}
    };
    return task;
}

- (void)drawInContext:(CGContextRef)context withSize:(CGSize)size {
    //设置context的ctm，用于适应core text的坐标体系
    CGContextSaveGState(context);
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    //设置CTFramesetter
    CTFramesetterRef framesetter =  CTFramesetterCreateWithAttributedString((CFAttributedStringRef)_innerText);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, size.width, size.height));
    //创建CTFrame
    CTFrameRef ctFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    //    if (ctFrame == NULL) {
    //        return;
    //    }
    //把文字内容绘制出来
    CTFrameDraw(ctFrame, context);
    //获取画出来的内容的行数
    CFArrayRef lines = CTFrameGetLines(ctFrame);
    
    //获取每行的原点坐标
    CGPoint lineOrigins[CFArrayGetCount(lines)];
    CTFrameGetLineOrigins(ctFrame, CFRangeMake(0, 0), lineOrigins);
    
    for (int i = 0; i < CFArrayGetCount(lines); i++) {
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        CGFloat lineAscent;
        CGFloat lineDescent;
        CGFloat lineLeading;
        //获取每行的宽度和高度
        CTLineGetTypographicBounds(line, &lineAscent, &lineDescent, &lineLeading);
        //获取每个CTRun
        CFArrayRef runs = CTLineGetGlyphRuns(line);
        CGFloat lineWidth = 0.;
        for (int j = 0; j < CFArrayGetCount(runs); j++) {
            CGFloat runAscent;
            CGFloat runDescent;
            CGPoint lineOrigin = lineOrigins[i];
            //获取每个CTRun
            CTRunRef run = CFArrayGetValueAtIndex(runs, j);
            NSDictionary* attributes = (NSDictionary*)CTRunGetAttributes(run);
            CGRect runRect;
            //调整CTRun的rect
            runRect.size.width = CTRunGetTypographicBounds(run, CFRangeMake(0,0), &runAscent, &runDescent, NULL);
            lineWidth+=runRect.size.width;
            
            runRect=CGRectMake(lineOrigin.x + CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, NULL), lineOrigin.y , runRect.size.width, runAscent+runDescent);
            //CFRelease(run);
            NSString *imageName = [attributes objectForKey:@"imageName"];
            if (imageName) {
                UIImage *image = [UIImage imageNamed:imageName];
                if (image) {
                    CGRect imageDrawRect;
                    imageDrawRect.size =CGSizeMake(18., 18.);
                    imageDrawRect.origin.x = runRect.origin.x + lineOrigin.x;
                    imageDrawRect.origin.y = lineOrigin.y-lineDescent-2;//+drawRect.origin.y;
                    CGContextDrawImage(context, imageDrawRect, image.CGImage);
                }
            }
        }
    }
    CGContextRestoreGState(context);
    CFRelease(framesetter);
    if (path) {
        CGPathRelease(path);
    }
    if (ctFrame) {
//        self.ctFrame = CFRetain(ctFrame);
        CFRelease(ctFrame);
    }
}
@end
