//
//  SxrSentinel.m
//  AsynDisplayDemo
//
//  Created by tree on 2018/3/16.
//  Copyright © 2018年 treee. All rights reserved.
//

#import "SxrSentinel.h"
#import <stdatomic.h>

@implementation SxrSentinel {
    int32_t _value;
}

- (int32_t)value {
    return _value;
}
/*
 'OSAtomicIncrement32' is deprecated: first deprecated in iOS 10.0 - Use atomic_fetch_add_explicit(memory_order_relaxed) from <stdatomic.h> instead
 */

/**
 OSAtomicIncrement32 在libkern/OSAtomic.h中，包含了线程安全的操作，
 */
- (int32_t)increase {
    @synchronized (self) {
        _value++;
    }
    return _value;
}
@end
