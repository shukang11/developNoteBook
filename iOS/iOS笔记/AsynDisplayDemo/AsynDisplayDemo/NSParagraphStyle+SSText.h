//
//  NSParagraphStyle+SSText.h
//  CoreTextDemo
//
//  Created by Mac on 16/12/27.
//  Copyright © 2016年 Blin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSParagraphStyle (SSText)

/**
 根据传入的参数创建并返回一个新的段落样式
 */
+ (nullable NSParagraphStyle *)ss_styleWithCTStyle:(CTParagraphStyleRef)CTStyle;

/**
 创建并返回一个Coretext 的段落样式，需要在使用之后调用CFRelease()
 */
- (nullable CTParagraphStyleRef)ss_CTStyle CF_RETURNS_RETAINED;
@end
NS_ASSUME_NONNULL_END
