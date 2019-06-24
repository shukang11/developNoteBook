//
//  Account.h
//  MacroDemo
//
//  Created by tree on 2019/5/29.
//  Copyright © 2019 treee. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Account : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;

- (instancetype) initWithName:(NSString *)name Age:(NSInteger)age NS_DESIGNATED_INITIALIZER;

@end

NS_ASSUME_NONNULL_END
