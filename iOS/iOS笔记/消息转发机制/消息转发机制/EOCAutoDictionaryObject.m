//
//  EOCAutoDictionaryObject.m
//  消息转发机制
//
//  Created by tree on 2018/5/8.
//  Copyright © 2018年 treee. All rights reserved.
//

#import "EOCAutoDictionaryObject.h"
#import <objc/runtime.h>

@interface EOCAutoDictionaryObject()
@property (nonatomic, strong) NSMutableDictionary *backingStore;
@end

@implementation EOCAutoDictionaryObject
@dynamic string, number, data, opaqueObject; // 不会自动生成getter/setter

- (instancetype)init {
    self = [super init];
    if (self) {
        _backingStore = [NSMutableDictionary dictionary];
    }
    return self;
}

id autoDictionaryGetter(id self, SEL _cmd) {
    EOCAutoDictionaryObject *typedSelf = (EOCAutoDictionaryObject *)self;
    NSMutableDictionary *backingStore = typedSelf.backingStore;
    NSString *key = NSStringFromSelector(_cmd);
    return [backingStore objectForKey:key];
}

void autoDictionarySetter(id self, SEL _cmd, id value) {
    EOCAutoDictionaryObject *typedSelf = (EOCAutoDictionaryObject *)self;
    NSMutableDictionary *backingStore = typedSelf.backingStore;
    NSString *selectorString = NSStringFromSelector(_cmd);
    NSLog(@"%@", selectorString);
    NSMutableString *key = [selectorString mutableCopy];
    // remove ":"
    [key deleteCharactersInRange:NSMakeRange(key.length-1, 1)];
    // remove "set"
    [key deleteCharactersInRange:NSMakeRange(0, 3)];
    
    NSString *lowercaseFirstChar = [[key substringToIndex:1] lowercaseString];
    [key replaceCharactersInRange:NSMakeRange(0, 1) withString:lowercaseFirstChar];
    if (value) {
        [backingStore setObject:value forKey:key];
    }else {
        [backingStore removeObjectForKey:key];
    }
    NSLog(@"%@", backingStore);
}


+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSString *selectorString = NSStringFromSelector(sel);
    if ([selectorString hasPrefix:@"set"]) {
        class_addMethod(self, sel, (IMP)autoDictionarySetter, "v@:@");
        return YES;
    }else {
        class_addMethod(self, sel, (IMP)autoDictionaryGetter, "@@:");
        return YES;
    }
    return [super resolveInstanceMethod:sel];
}

@end
