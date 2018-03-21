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

@interface SxrLabel()<SxrAsyncLayerDelegate>
@end
@implementation SxrLabel

- (void)setText:(NSString *)text {
    _text = text.copy;
    [[SxrTransaction transactionWithTarget:self seelctor:@selector(contentsNeedUpdated)] commit];
}

- (void)setFont:(UIFont *)font {
    _font = font;
    [[SxrTransaction transactionWithTarget:self seelctor:@selector(contentsNeedUpdated)] commit];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [[SxrTransaction transactionWithTarget:self seelctor:@selector(contentsNeedUpdated)] commit];
}

- (void)contentsNeedUpdated {
    [self.layer setNeedsDisplay];
}


#pragma mark -
#pragma mark SxrAsyncLayer
+ (Class)layerClass {
    return SxrAsynLayer.class;
}

- (SxrAsyncLayerDisplayTask *)newAsyncDisplayTask {
    NSString *text = _text;
    UIFont *font = _font;
    SxrAsyncLayerDisplayTask *task = [SxrAsyncLayerDisplayTask new];
    task.willDisplay = ^(CALayer * _Nonnull layer) {
        
    };
    task.display = ^(CGContextRef  _Nonnull context, CGSize size, BOOL (^ _Nonnull isCanceled)(void)) {
        if (isCanceled()) return;
        
    };
    
    task.didDisplay = ^(CALayer * _Nonnull layer, BOOL finished) {
        if (finished) {}
        else {}
    };
    return task;
}
@end
