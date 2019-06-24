//
//  Account.m
//  MacroDemo
//
//  Created by tree on 2019/5/29.
//  Copyright © 2019 treee. All rights reserved.
//

#import "Account.h"

@implementation Account
- (instancetype)initWithName:(NSString *)name Age:(NSInteger)age {
    self = [super init];
    if (self) {
        _name = name;
        _age = age;
    }
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@>: %@ %ld", [self class], self.name, (long)self.age];
}
@end
