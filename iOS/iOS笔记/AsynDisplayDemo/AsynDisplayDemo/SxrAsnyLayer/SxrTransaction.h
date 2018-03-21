//
//  SxrTransaction.h
//  AsynDisplayDemo
//
//  Created by tree on 2018/3/16.
//  Copyright © 2018年 treee. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
/**
 可以在runloop休眠之前执行一个动作
 */
@interface SxrTransaction : NSObject

/**
 根据规定的对象和方法生成一个transaction

 @param target 对象
 @param selector 方法
 @return 一个交易对象 (直译)
 */
+ (SxrTransaction *)transactionWithTarget:(id)target seelctor:(SEL)selector;

/**
 提交本次交易到主循环中
 
 会在主循环中最近的一次循环休眠时，将交易提交到主循环中去，如果对象和方法已经提交过了，就不作处理
 */
- (void)commit;

@end
NS_ASSUME_NONNULL_END
