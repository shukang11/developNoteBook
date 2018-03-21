//
//  SxrSentinel.h
//  AsynDisplayDemo
//
//  Created by tree on 2018/3/16.
//  Copyright © 2018年 treee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/**
 这是一个线程安全的计数器，在某些多线程的场景中
 */
@interface SxrSentinel : NSObject

/** 返回这个计数器最新的值 */
@property (readonly) int32_t value;

/**
 更新值

 @return 返回最新的值
 */
- (int32_t)increase;
@end
NS_ASSUME_NONNULL_END
