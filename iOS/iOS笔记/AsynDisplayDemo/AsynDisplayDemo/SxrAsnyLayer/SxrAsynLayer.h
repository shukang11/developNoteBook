//
//  SxrAsynLayer.h
//  AsynDisplayDemo
//
//  Created by tree on 2018/3/16.
//  Copyright © 2018年 treee. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 是一个CALayer的子类，用作异步绘制内容
 
 当layer需要更新其内容的时候，在多线程会要求其代理实现相关的方法，来提供绘制内容
 */
@interface SxrAsynLayer : CALayer

/**
 是否在后台线程提供、默认为YES
 */
@property (nonatomic, assign) BOOL displaysAsynchronously;
@end

@class SxrAsyncLayerDisplayTask;

/**
 SxrAsyncLayer的代理
 */
@protocol SxrAsyncLayerDelegate<NSObject>
@required
- (SxrAsyncLayerDisplayTask *)newAsyncDisplayTask;
@end

/**
 这个显示任务被用于SxrAsyncLayer在后台线程提供内容
 */
@interface SxrAsyncLayerDisplayTask: NSObject

/**
 这个回调会在线程开始绘制的时候调用，会在主线程调用
 */
@property (nullable, nonatomic, copy) void (^willDisplay)(CALayer *layer);

/**
 这个回调会在绘制的时候调用
 */
@property (nullable, nonatomic, copy) void (^display)(CGContextRef context, CGSize size, BOOL(^isCanceled)(void));

/**
 这个回调会在异步绘制结束之后调用
 */
@property (nullable, nonatomic, copy) void (^didDisplay)(CALayer *layer, BOOL finished);
@end

NS_ASSUME_NONNULL_END
