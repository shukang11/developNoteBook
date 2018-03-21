//
//  SxrTransaction.m
//  AsynDisplayDemo
//
//  Created by tree on 2018/3/16.
//  Copyright © 2018年 treee. All rights reserved.
//

#import "SxrTransaction.h"

@interface SxrTransaction()
@property (nonatomic, strong) id target;
@property (nonatomic, assign) SEL selector;
@end

static NSMutableSet *transactionSet = nil;

static void SxrRunLoopObserverCallBack(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info) {
    if (transactionSet.count == 0) return;
    NSSet *currentSet = transactionSet;
    transactionSet = [NSMutableSet new];
    [currentSet enumerateObjectsUsingBlock:^(SxrTransaction *transaction, BOOL * stop) {
        if ([transaction.target respondsToSelector:transaction.selector]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
            [transaction.target performSelector:transaction.selector];
#pragma clang diagnostic pop
        }
    }];
}

static void SxrTransactionSetUp() {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        transactionSet = [NSMutableSet new];
        CFRunLoopRef runloop = CFRunLoopGetMain();
        CFRunLoopObserverRef observer;
        // 使用系统内置的方法创建一个Runloop的观察者，在创建的时候指定回调方法
        // 0xFFFFFF是优先级，这个优先级比CATransaction的优先级(2000000)还低，确保动画先执行，再执行异步渲染
        observer = CFRunLoopObserverCreate(CFAllocatorGetDefault(), kCFRunLoopBeforeWaiting | kCFRunLoopExit, true, 0xFFFFFF, SxrRunLoopObserverCallBack, nil);
        CFRunLoopAddObserver(runloop, observer, kCFRunLoopCommonModes);
        CFRelease(observer);
    });
}
@implementation SxrTransaction
+ (SxrTransaction *)transactionWithTarget:(id)target seelctor:(SEL)selector {
    if (!target || !selector) return nil;
    SxrTransaction *t = [SxrTransaction new];
    t.target = target;
    t.selector = selector;
    return t;
}

- (void)commit {
    if (!_target || !_selector) return;
    SxrTransactionSetUp();
    [transactionSet addObject:self];
}

- (NSUInteger)hash {
    long v1 = (long)((void*)_selector);
    long v2 = (long)_target;
    return v1 ^ v2;
}
- (BOOL)isEqual:(id)object {
    if (self == object) return YES;
    if (![object isMemberOfClass:self.class]) return NO;
    SxrTransaction *other = object;
    return other.selector == _selector && other.target == _target;
}
@end
