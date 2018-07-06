//
//  SxrLabel.h
//  AsynDisplayDemo
//
//  Created by tree on 2018/3/16.
//  Copyright © 2018年 treee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SxrLabel : UIView
@property (nonatomic, copy) NSString *text;
@property (nonatomic, strong) UIFont *font;
@property (nonatomic, strong) UIColor *textColor;
@property (nonatomic, strong) UIColor *shadowColor;
@property (nonatomic, assign) CGSize shadowOffset;
@property (nonatomic, assign) CGFloat shadowBlurRadius;
@property (nonatomic, assign) NSTextAlignment textAlignment;

@property (nonatomic, copy) NSAttributedString *attributedText;
@property (nonatomic, assign) NSLineBreakMode lineBreakMode;
@property (nonatomic, copy) NSAttributedString *truncationToken;
@property (nonatomic, assign) NSUInteger numberOfLines;


#pragma mark - Configuring the Text Container
@property (nonatomic, copy) UIBezierPath *textContainerPath;
@end
